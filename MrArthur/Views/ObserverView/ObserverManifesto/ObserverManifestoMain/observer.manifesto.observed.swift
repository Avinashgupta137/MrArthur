//
//  observer.manifesto.observed.swift
//  MrArthur
//
//  Created by IPS-169 on 18/07/22.
//

import SwiftUI


class ObserverManifesto: ObservableObject {
    @Published var currentIndex: Int
    @Published var currentHowItWorksIndex: Int
    init(index: Int = 0) {
        self.currentIndex = index
        self.currentHowItWorksIndex = 0
        let _ = CurrentUserService.getToken()
    }
}

class ObserverManifestoObserver: ObservableObject {
    
    var loaderObserver: LoaderObserver? = nil
    var observerManifesto: ObserverManifesto? = nil
    var rootViewObserver: RootViewObserver? = nil
    
    @Published var buttonTitle: String = "NEXT"
    @Published var startProgress: Bool = false
    @Published var hideBackButton: Bool = false
    @Published var hideNextButton: Bool = false
    @Published var hideHeaderProgress: Bool = false
    
    let arrOfScreenName = UtilityMethod().getValueForKey(
        key: ConstantOfApp.kScreenNameList
    ) as? [String] ?? []
    let questionPageIndexs = [5,6,7,8,9,11,12,13,20,21,22]
    let questionList = UtilityMethod.getManifestoQuestionList(.OBSERVER_USER)
    
    func _init(
        loaderObserver: LoaderObserver,
        observerManifesto: ObserverManifesto,
        rootViewObserver: RootViewObserver
    ) {
        self.loaderObserver = loaderObserver
        self.observerManifesto = observerManifesto
        self.rootViewObserver = rootViewObserver
        self.startProgress = observerManifesto.currentIndex == 23
        self.configureUI()
    }
    
    func onBack(completion: @escaping (Int) -> Void, showPrivacy: @escaping () -> Void = {}) {
        if let currentIndex = self.observerManifesto?.currentIndex, currentIndex > 0 {
            self.amplitudeServiceEvent(isNext: false)
            let prevBy = self.doYouUseParentalControlApps(index: (currentIndex - 1)) ? 2 : 1
            self.observerManifesto?.currentIndex -= prevBy
            self.configureUI()
            completion(prevBy)
        }
    }
    
    func onNext(completion: @escaping (Int) -> Void, showPrivacy: @escaping () -> Void = {}) {
        self.callApiOnNext { status, move, error in
            if status {
                let index = (self.observerManifesto?.currentIndex ?? 0)
                if self.isPrivacyScreen(index) && !UserDefaultsHelper.userHasAcceptedPrivacyPolicy {
                    showPrivacy()
                } else {
                    self.observerManifesto?.currentIndex += move
                    completion(move)
                }
                self.configureUI()
            }
        }
    }
    
    func onAnswer(completion: @escaping (Int) -> Void) {
        self.callApiOnNext { status, move, error in
            if status {
                completion(move)
                self.observerManifesto?.currentIndex += move
                self.configureUI()
            }
        }
    }
    
    private func amplitudeServiceEvent(isNext: Bool) {
        if let currentIndex = self.observerManifesto?.currentIndex {
            let screenName = arrOfScreenName[currentIndex]
            if let emplitudeKey = self.getCaseFromScreenName(screenName: screenName, isNext: isNext) {
                AmplitudeService.sendEvent(key: emplitudeKey)
            }
        }
    }
    
    private func isPrivacyScreen(_ index: Int) -> Bool {
        if index >= 0 {
            let step = self.arrOfScreenName[index]
            return step == "QUESTION_TIMER_INTRODUCTION"
        }
        return false
    }
    
}

// MARK: API calling
extension ObserverManifestoObserver {
    
    private func callApiOnNext(completion: @escaping (_ status: Bool, _ move: Int, _ error: String?) -> Void) {
        if let currentIndex = self.observerManifesto?.currentIndex {
            if(currentIndex < self.arrOfScreenName.count){
                if(self.questionPageIndexs.contains(currentIndex)) {
                    if let model = self.getCurrentQuestionModel() {
                        self.callApiForQuestionPage(model: model, completion: completion)
                    }
                } else {
                    self.callApiForStaticPage(completion: completion)
                }
            }
        }
    }
    
    private func callApiForQuestionPage(
        model: AnswerModel,
        completion: @escaping (_ status: Bool, _ move: Int, _ error: String?) -> Void
    ) {
        self.loaderObserver?.showLoader = true
        self.hideHeaderNFooter(true)
        if let currentIndex = observerManifesto?.currentIndex {
            let stepname = arrOfScreenName[currentIndex]
            self.amplitudeServiceEvent(isNext: true)
            if let question = getCurrentQuestionModel() {
                if let ansIndex = question.answer.firstIndex(where: {$0.ans == question.givenAnswer}) {
                    let selectedAns = question.backendAnswer[ansIndex]
                    ManifestoHelper.fetchAnwserList(
                        stepName: stepname,
                        anwser: [selectedAns]
                    ) { error, status in
                        self.loaderObserver?.showLoader = false
                        self.hideHeaderNFooter(false)
                        let nextBy = self.doYouUseParentalControlApps(index: currentIndex) ? 2 : 1
                        if status {
                            completion(status, nextBy, error)
                        } else {
                            print("error is = \(error)")
                        }
                    }
                }
            }
        }
    }
    
    private func callApiForStaticPage(
        completion: @escaping (_ status: Bool, _ move: Int, _ error: String?) -> Void
    ) {
        self.loaderObserver?.showLoader = true
        
        if let currentIndex = observerManifesto?.currentIndex {
            let stepname = arrOfScreenName[currentIndex]
            self.amplitudeServiceEvent(isNext: true)
            ManifestoHelper.nextStepOnBordingAPICall(
                stepName: stepname
            ) { error, status in
                self.loaderObserver?.showLoader = false
                if status {
                    if currentIndex == 24 {
                        self.rootViewObserver?.currentPage = .signUp
                    } else {
                        completion(status, 1, error)
                    }
                } else {
                    print("erorr is = \(error) for on boarding api call")
                }
            }
        }
    }
    
    private func doYouUseParentalControlApps(index: Int) -> Bool {
//        print("check doYouUseParentalControlApps", index, self.arrOfScreenName[index])
        if index >= 0 {
            let step = self.arrOfScreenName[index]
            if step == "QUESTION_PARENTAL_CONTROL_APP" || step == "QUESTION_PARENTAL_CONTROL_APP_SATISFACTION" {
                if let question = UserDefaultsHelper.getQuestionForID(3) {
                    if let answer = question.givenAnswer, answer.lowercased() == "no" {
                        return true
                    }
                }
            }
        }
        return false
    }
}

// MARK: Configure UI
extension ObserverManifestoObserver {
    func configureUI() {
        self.startProgress = observerManifesto?.currentIndex == 23
        self.setButtonVisibility()
    }
    
    private func hideHeaderNFooter(_ hidden: Bool) {
        self.hideBackButton = hidden
        self.hideNextButton = hidden
        self.hideHeaderProgress = hidden
    }
    
    private func getCurrentQuestionModel() -> AnswerModel? {
        if let currentIndex = observerManifesto?.currentIndex {
            if questionPageIndexs.contains(currentIndex),
                let questionIndex = questionPageIndexs.firstIndex(where: {$0 == currentIndex}),
               questionIndex < questionList.count
            {
                let question = questionList[questionIndex]
                print("CURRENT QUESTION \(questionIndex): \(question)")
                return UserDefaultsHelper.getQuestionForID(question.id ?? 0)
            }
        }
        return nil
    }
    
    private func getNextButtonLabel() {
        if let currentIndex = observerManifesto?.currentIndex, currentIndex > 0 {
            let screenname = arrOfScreenName[currentIndex]
            var label = "NEXT"
            if screenname == "QUESTION_TIMER_INTRODUCTION" {
                label = "LET'S DO THIS!"
            }
            if screenname == "QUESTION_FINAL_SCREEN_GO_TO_LOG_IN" {
                label = "SIGN UP"
            }
            self.buttonTitle = label.localized
        }
    }
    
    private func setButtonVisibility() {
        if let currentIndex = observerManifesto?.currentIndex {
            var showBack = true
            var showNext = false
            if(questionPageIndexs.contains(currentIndex)){
                if let question = getCurrentQuestionModel() {
                    showNext = question.answerGiven
                } else {
                    showNext = false
                }
            } else {
                if currentIndex == 0 || currentIndex == 23 || currentIndex == 24 {
                    showBack = false
                    showNext = currentIndex != 23
                } else {
                    showBack = true
                    showNext = true
                }
            }
            self.hideBackButton = !showBack
            self.hideNextButton = !showNext
            self.getNextButtonLabel()
        }
    }
}

// MARK: Get keys
extension ObserverManifestoObserver {
    private func getCaseFromScreenName(screenName: String, isNext: Bool) -> EAmplitudeEventKey? {
        
        var amplitudeKey: EAmplitudeEventKey?
        switch screenName {
        case "MANIFESTO_YOU_MADE_THE_HARD_PART":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_MANIFESTO_INTRO_NEXT
            : EAmplitudeEventKey.OBS_MANIFESTO_INTRO_BACK
            break
        case "MANIFESTO_HEALTHY_SCREEN_USE":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_MANIFESTO_01_NEXT
            : EAmplitudeEventKey.OBS_MANIFESTO_01_BACK
            break
        case  "MANIFESTO_SCREEN_ISSUE_AWARENESS":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_MANIFESTO_03_NEXT
            : EAmplitudeEventKey.OBS_MANIFESTO_03_BACK
            break
        case  "MANIFESTO_MR_ARTHUR_NURSE":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_MANIFESTO_02_NEXT
            : EAmplitudeEventKey.OBS_MANIFESTO_02_BACK
            break
        case  "QUESTION_TIMER_INTRODUCTION":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_QT_INTRO_NEXT
            : EAmplitudeEventKey.OBS_QT_INTRO_BACK
            break
        case  "QUESTION_MAIN_GOAL":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_QT_1_NEXT
            : EAmplitudeEventKey.OBS_QT_1_BACK
            break
        case  "QUESTION_WHO_ARE_YOU":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_QT_2_NEXT
            : EAmplitudeEventKey.OBS_QT_2_BACK
            break
        case  "QUESTION_FAMILY_SCREEN_ARGUMENTS":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_QT_3_NEXT
            : EAmplitudeEventKey.OBS_QT_3_BACK
            break
        case  "QUESTION_PARENTAL_CONTROL_APP":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_QT_4_NEXT
            : EAmplitudeEventKey.OBS_QT_4_BACK
            break
        case  "QUESTION_PARENTAL_CONTROL_APP_SATISFACTION":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_QT_5_NEXT
            : EAmplitudeEventKey.OBS_QT_5_BACK
            break
        case  "QUESTION_INTERLUDE01":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_QT_CARTON_1_NEXT
            : EAmplitudeEventKey.OBS_QT_CARTON_1_BACK
            break
        case  "QUESTION_IS_SCREEN_USE_PROBLEMATIC":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_QT_6_NEXT
            : EAmplitudeEventKey.OBS_QT_6_BACK
            break
        case  "QUESTION_FEEL_GUILTY":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_QT_7_NEXT
            : EAmplitudeEventKey.OBS_QT_7_BACK
            break
        case  "QUESTION_IS_KID_AWARE":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_QT_8_NEXT
            : EAmplitudeEventKey.OBS_QT_8_BACK
            break
        case  "MANIFESTO_WARNING_EMPOWERED_KID":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_MANIFESTO_4_NEXT
            : EAmplitudeEventKey.OBS_MANIFESTO_4_BACK
            break
        case  "MANIFESTO_THERE_IS_HOPE":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_MANIFESTO_5_NEXT
            : EAmplitudeEventKey.OBS_MANIFESTO_5_BACK
            break
        case  "MANIFESTO_BUT_HOW_DOES_IT_WORK":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_MANIFESTO_6_NEXT
            : EAmplitudeEventKey.OBS_MANIFESTO_6_BACK
            break
        case  "MANIFESTO_TIME_REDUCTION_EXPLANATION":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_MANIFESTO_7_NEXT
            : EAmplitudeEventKey.OBS_MANIFESTO_7_BACK
            break
        case  "MANIFESTO_MR_ARTHUR_AI_PROGNOSIS_EXPLANATION":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_MANIFESTO_9_NEXT
            : EAmplitudeEventKey.OBS_MANIFESTO_9_BACK
            break
        case  "MANIFESTO_SMART_TIME_EXPLANATION":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_MANIFESTO_8_NEXT
            : EAmplitudeEventKey.OBS_MANIFESTO_8_BACK
            break
        case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART1":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_QT_9_NEXT
            : EAmplitudeEventKey.OBS_QT_9_BACK
            break
        case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART2":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_QT_10_NEXT
            : EAmplitudeEventKey.OBS_QT_10_BACK
            break
        case  "QUESTION_OBSERVER_OWN_SCREEN_USE_OPINION":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_QT_11_NEXT
            : EAmplitudeEventKey.OBS_QT_11_BACK
            break
        case "QUESTION_DATA_PROCESSING":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.OBS_DATA_01_NEXT
            : EAmplitudeEventKey.OBS_DATA_02_BACK
            break
        case "QUESTION_FINAL_SCREEN_GO_TO_LOG_IN":
            amplitudeKey = EAmplitudeEventKey.OBS_QT_FINISH_NEXT
            break
        default:
            break
        }
        return amplitudeKey
    }
}
