//
//  attendeemanifesto.observer.swift
//  MrArthur
//
//  Created by IPS-169 on 28/07/22.
//

import Foundation

class AttendeeManifestoObserver: ObservableObject{
    
    @Published var currentIndex: Int
    @Published var currentHowItsWorkIndex: Int
    
    init(index: Int = 0, howIndex: Int = 0) {
        self.currentIndex = index
        self.currentHowItsWorkIndex = index + 1
    }
}

class ATTManifestoObserver: ObservableObject {
    var loaderObserver: LoaderObserver? = nil
    var attendeeManifestoObserver: AttendeeManifestoObserver? = nil
    var rootViewObserver: RootViewObserver? = nil
    
    @Published var buttonTitle: String = "START"
    @Published var startProgress: Bool = false
    @Published var hideBackButton: Bool = false
    @Published var hideNextButton: Bool = false
    @Published var hideHeaderProgress: Bool = false
    @Published var questionState: StateOfQuestion = .none
    
    let screenNameList = UtilityMethod.attendeeManifestoScreenList
    let arrofQuestion = UtilityMethod.attendeeManifestoQuestionList
    let questionList = UtilityMethod.getManifestoQuestionList(.ATTENDEE_USER)
    var pages: [Int] = []
    
    init() {
        self.pages = Array(0..<screenNameList.count)
    }
    
    func _init(
        loaderObserver: LoaderObserver,
        attendeeManifestoObserver: AttendeeManifestoObserver,
        rootViewObserver: RootViewObserver
    ) {
        self.loaderObserver = loaderObserver
        self.attendeeManifestoObserver = attendeeManifestoObserver
        self.rootViewObserver = rootViewObserver
        self.configureUI()
    }
    
    func onBack(completion: @escaping (Int) -> Void) {
        if let currentIndex = self.attendeeManifestoObserver?.currentIndex, currentIndex > 0 {
            self.amplitudeServiceEvent(isNext: false)
            self.attendeeManifestoObserver?.currentIndex -= 1
            self.configureUI()
            completion(1)
        }
    }
    
    func onNext(completion: @escaping (Int) -> Void) {
        self.callApiOnNext { status, move, error in
            if status {
                let index = self.attendeeManifestoObserver!.currentIndex
                let screenName = self.screenNameList[index]
                if screenName == "QUESTION_PERFECT_WELL_DONE" {
                    self.rootViewObserver?.currentPage = .attendeeDashboard
                } else {
                    self.attendeeManifestoObserver?.currentIndex  += move
                    completion(move)
                    self.configureUI()
                }
            }
        }
    }
    
    func onAnswer(completion: @escaping (Int) -> Void) {
        self.callApiOnNext { status, move, error in
            if status {
                self.attendeeManifestoObserver?.currentIndex  += move
                completion(move)
                self.configureUI()
            }
        }
    }
    
    private func amplitudeServiceEvent(isNext: Bool) {
        if let currentIndex = self.attendeeManifestoObserver?.currentIndex {
            if let emplitudeKey = self.getCaseFromScreenName(
                screenName: screenNameList[currentIndex],
                isNext: isNext
            ) {
                AmplitudeService.sendEvent(key: emplitudeKey)
            }
        }
    }
    
    func isDataProcessView() -> Bool {
        var screenName = "NA"
        if let currentIndex = self.attendeeManifestoObserver?.currentIndex {
            if(currentIndex < self.screenNameList.count) {
                screenName = screenNameList[currentIndex]
            }
        }
        return screenName == "QUESTION_DATA_PROCESSING"
    }
}

extension ATTManifestoObserver {
    private func callApiOnNext(completion: @escaping (_ status: Bool, _ move: Int, _ error: String?) -> Void) {
        if let currentIndex = self.attendeeManifestoObserver?.currentIndex {
            if(currentIndex < self.screenNameList.count) {
                let screenName = screenNameList[currentIndex]
                if (arrofQuestion.contains(screenName)) {
                    if let model = self.getCurrentQuestionModel() {
                        self.callApiForQuestionPage(model: model, completion: completion)
                    }
                } else {
                    self.callApiForStaticPage(index: currentIndex, completion: completion)
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
        if let currentIndex = attendeeManifestoObserver?.currentIndex {
            
            let stepname = screenNameList[currentIndex]
            self.amplitudeServiceEvent(isNext: true)
            if let question = getCurrentQuestionModel() {
                if let ansIndex = question.answer.firstIndex(where: {$0.ans == question.givenAnswer}) {
                    let selectedAns = question.backendAnswer[ansIndex]
                    let uuidOfSubscription = UtilityMethod().getValueForKey(key: ConstantOfApp.kUUIDForSubscription) as? String ?? ""
                    let request = ObserverQuestionRequestModel(
                        subscriptionUUID: uuidOfSubscription,
                        stepName: stepname,
                        answerList: [selectedAns]
                    )
                    if let param = try? request.asDictionary() {
                        QuestionListAPICall().attendeeAnsweredAPICall(parameter: param) { error, model in
                            self.loaderObserver?.showLoader = false
                            self.hideHeaderNFooter(false)
                            if let error = error, !error.isEmpty {
                                print("ERROR: ", error)
                                completion(false, 0, error)
                            } else {
                                completion(true, 1, nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func callApiForStaticPage(
        index: Int,
        completion: @escaping (_ status: Bool, _ move: Int, _ error: String?) -> Void
    ) {
        self.loaderObserver?.showLoader = true
        let stepName = screenNameList[index]
        self.amplitudeServiceEvent(isNext: true)
        
        let onbordingRequest = OnbordingNextStepRequestModel(stepName: stepName)
        if let param = try? onbordingRequest.asDictionary() {
            OnbordingStepAPICall().attendeeOnboardingAPICall(parameter: param) { error, _ in
                self.loaderObserver?.showLoader = false
                if let error = error, !error.isEmpty {
                    print("ERROR: ", error)
                    completion(false, 0, error)
                } else {
                    completion(true, 1, nil)
                }
            }
        }
    }
}


extension ATTManifestoObserver {
    func configureUI() {
        self.startProgress = isDataProcessView()
        self.setButtonVisibility()
    }
    
    private func setButtonVisibility() {
        if let currentIndex = attendeeManifestoObserver?.currentIndex {
            let screenName = screenNameList[currentIndex]
            var showBack = true
            var showNext = true
            if(arrofQuestion.contains(screenName)) {
                if let question = getCurrentQuestionModel() {
                    showNext = question.answerGiven
                } else {
                    showNext = false
                }
            } else {
                if screenName == "MANIFESTO_INTRO_HELLO_AND_FOLLOW_ME" ||
                    screenName  == "QUESTION_PERFECT_WELL_DONE" ||
                    screenName  == "QUESTION_DATA_PROCESSING" {
                    showBack = false
                    showNext = screenName != "QUESTION_DATA_PROCESSING"
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
    
    private func hideHeaderNFooter(_ hidden: Bool) {
        self.hideBackButton = hidden
        self.hideNextButton = hidden
        self.hideHeaderProgress = hidden
    }
    
    private func getNextButtonLabel() {
        if let currentIndex = attendeeManifestoObserver?.currentIndex, currentIndex >= 0 {
            let screenName = screenNameList[currentIndex]
            var label = "NEXT"
            if(screenName == "MANIFESTO_INTRO_HELLO_AND_FOLLOW_ME"){
                label = "START"
            }
            if (screenName == "MANIFESTO_LETS_EMBARK" || screenName == "HOW_IT_WORKS_FINAL_SCREEN") {
                label = "LET'S GO!"
            }
            if screenName == "QUESTION_COURAGE_LITTLE_TIME_LEFT"  {
                label = "CONTINUE"
            }
            self.buttonTitle = label.localized
        }
    }
    
    private func getCurrentQuestionModel() -> AnswerModel? {
        if let currentIndex = attendeeManifestoObserver?.currentIndex {
            let screenName = screenNameList[currentIndex]
            if let questionIndex = arrofQuestion.firstIndex(where: {$0 == screenName}) {
                let question = questionList[questionIndex]
                print("CURRENT QUESTION \(questionIndex): \(question)")
                return UserDefaultsHelper.getQuestionForID(question.id ?? 0)
            }
        }
        return nil
    }
}


extension ATTManifestoObserver {
    private func getCaseFromScreenName(screenName: String, isNext: Bool) -> EAmplitudeEventKey? {
        
        var amplitudeKey: EAmplitudeEventKey?
        switch screenName {
        case "MANIFESTO_INTRO_HELLO_AND_FOLLOW_ME":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_START_INTRO_1_NEXT
            : EAmplitudeEventKey.ATT_START_INTRO_1_BACK
            break
            
        case "MANIFESTO_MR_ARTHUR_IS_YOUR_FRIEND":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_MANIFESTO_1_NEXT
            : EAmplitudeEventKey.ATT_MANIFESTO_1_BACK
            break
            
        case "MANIFESTO_MR_ARTHUR_WILL_MAKE_YOU_SMART" :
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_MANIFESTO_2_NEXT
            : EAmplitudeEventKey.ATT_MANIFESTO_2_BACK
            break
            
        case  "MANIFESTO_MAKE_THE_FIRST_STEP_AGAINST_TYRANNY":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_MANIFESTO_3_NEXT
            : EAmplitudeEventKey.ATT_MANIFESTO_3_BACK
            break
        case  "MANIFESTO_MR_ARTHUR_WILL_EMPOWER_YOU":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_MANIFESTO_4_NEXT
            : EAmplitudeEventKey.ATT_MANIFESTO_4_BACK
            break
        case  "MANIFESTO_MR_ARTHUR_IS_A_NURSE":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_MANIFESTO_5_NEXT
            : EAmplitudeEventKey.ATT_MANIFESTO_5_BACK
            break
        case  "MANIFESTO_HOW_KID_WILL_MAKE_A_PROPOSAL":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_MANIFESTO_6_NEXT
            : EAmplitudeEventKey.ATT_MANIFESTO_6_BACK
            break
        case  "MANIFESTO_ENJOY_FREE_TIME_WITH_BUDDIES":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_MANIFESTO_7_NEXT
            : EAmplitudeEventKey.ATT_MANIFESTO_7_BACK
            break
        case  "MANIFESTO_LETS_EMBARK":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_MANIFESTO_8_NEXT
            : EAmplitudeEventKey.ATT_MANIFESTO_8_BACK
            break
            
        case  "QUESTION_TOO_MUCH_TIME_ON_SCREEN":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_QT_1_NEXT
            : EAmplitudeEventKey.ATT_QT_1_BACK
            break
        case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART1":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_QT_2_NEXT
            : EAmplitudeEventKey.ATT_QT_2_BACK
            break
        case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART2":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_QT_3_NEXT
            : EAmplitudeEventKey.ATT_QT_3_BACK
            break
        case  "QUESTION_FAMILY_SCREEN_ARGUMENTS":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_QT_4_NEXT
            : EAmplitudeEventKey.ATT_QT_4_BACK
            break
        case  "QUESTION_COURAGE_LITTLE_TIME_LEFT":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_QT_CARTON_1_NEXT
            : EAmplitudeEventKey.ATT_QT_CARTON_1_BACK
            break
        case  "QUESTION_WOULD_ACCEPT_ENFORCED_TIME_LIMIT_RULES":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_QT_5_NEXT
            : EAmplitudeEventKey.ATT_QT_5_BACK
            break
        case  "QUESTION_WOULD_PREFER_EMPOWERMENT_AND_ADVICES":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_QT_6_NEXT
            : EAmplitudeEventKey.ATT_QT_6_BACK
            break
        case  "QUESTION_ENJOY_AND_LEARN":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_QT_7_NEXT
            : EAmplitudeEventKey.ATT_QT_7_BACK
            break
        case  "QUESTION_ABOUT_SMART_EDUCATIVE_APPS":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_QT_8_NEXT
            : EAmplitudeEventKey.ATT_QT_8_BACK
            break
        case  "QUESTION_PERFECT_WELL_DONE":
            amplitudeKey = isNext
            ? EAmplitudeEventKey.ATT_QT_CARTON_2_NEXT
            : EAmplitudeEventKey.ATT_QT_CARTON_2_BACK
            break
        case  "QUESTION_DATA_PROCESSING":
            amplitudeKey = EAmplitudeEventKey.ATT_DATA_1_NEXT
            break
            
        default:
            break
        }
        return amplitudeKey
    }
}
