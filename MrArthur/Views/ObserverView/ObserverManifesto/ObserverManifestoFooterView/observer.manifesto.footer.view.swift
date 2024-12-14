//
//  observer.manifesto.footer.view.swift
//  MrArthur
//
//  Created by IPS-169 on 08/07/22.
//

import SwiftUI

struct ObserverFooterView: View {
    
    @Binding var questionIndex:Int
    @Binding var questionState: StateOfQuestion
    @Binding var isNext: Bool
    
    let arrNextShouldHide = [5,6,7,8,9,11,12,13,20,21,22]
    
    // MARK: - PROPERTIES
    @State var showBack = true
    @State var showNext = true
    let imageButton : CGFloat = isiPad() ? 50 : 30
    let arrOfScreenName = UtilityMethod().getValueForKey(key: ConstantOfApp.kScreenNameList) as? [String] ?? [String]()
    
    // MARK: - OBSERVERS
    @EnvironmentObject private var loaderObserver: LoaderObserver
    @EnvironmentObject private var observerManifestoObservedObject: ObserverManifesto
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @StateObject var observerFooterObj = Observed()
    
    var body: some View {
        HStack {
            if showBack {
                Button {
                    if let eAmplitudeKey = observerFooterObj.getCaseFromBackScreenName(screenName:arrOfScreenName[observerManifestoObservedObject.currentIndex]) {
                        AmplitudeService.sendEvent(key:eAmplitudeKey)
                    }
                    onBack()
                } label: {
                    Image.init(systemName: "arrow.backward").resizable()
                        .font(Font.title.weight(.heavy))
                    
                        .scaledToFit()
                        .frame(width: imageButton, height: imageButton)
                        .padding(10)
                        .foregroundColor(Color.primaryBlue)
                        .overlay(
                            RoundedRectangle(cornerRadius: isiPad() ? 70 : 50)
                                .stroke(Color.primaryBlue, lineWidth: 1)
                        )
                }
                .foregroundColor(Color.primaryBlue)
                .fixedSize(horizontal: true, vertical: true)
                .contentShape(Rectangle())
                
                Spacer()
            }
            
            Button {
                onNext()
            } label: {
                getNextButtonLabel()
                    .frame(
                        width: 184.sp,
                        height: 60.h
                    )
            }
            .contentShape(Rectangle())
            .background(
                RoundedRectangle(cornerRadius: 30.r)
                    .fill(Color.primaryBlue)
            )
            .opacity(showNext ? 1 : 0)
        }
        .padding(
            EdgeInsets(
                top: 0 ,
                leading: CGFloat.dynamicValue(foriPhone: 20, foriPad: 40),
                bottom: 40,
                trailing: CGFloat.dynamicValue(foriPhone: 20, foriPad: 40)
            )
        )
        .onChange(of: questionState) { newValue in
            setButtonVisibility(state: newValue)
        }
        .onAppear {
            setButtonVisibility(state: questionState)
        }
        
    }
    
    private func setButtonVisibility(state: StateOfQuestion, isNext: Bool? = nil) {
        let currentIndex = observerManifestoObservedObject.currentIndex
        print("Observer Manifesto Curent screen \(currentIndex)")
        if(arrNextShouldHide.contains(currentIndex)){
            if(state == .answerGiven){
                showBack = true
                showNext = true
            }else if(state == .answerGiving){
                showBack = false
                showNext = false
            }else{
                showBack = true
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
        if isNext != nil {
            self.isNext = isNext!
        }
    }
    
    private func getNextButtonLabel() -> Text {
        if(observerManifestoObservedObject.currentIndex < arrOfScreenName.count){
            let screenname = arrOfScreenName[observerManifestoObservedObject.currentIndex]
            var label = "NEXT".localized
            
            if screenname == "QUESTION_TIMER_INTRODUCTION" {
                label = "LET'S DO THIS!".localized
            }
            if screenname == "QUESTION_FINAL_SCREEN_GO_TO_LOG_IN" {
                label = "SIGN UP".localized
            }
            return Text(label.localized).fontModifier(font: .montserratBlack, size: 15)
        }else{
            return Text("NEXT".localized).fontModifier(font: .montserratBold, size: 15)
        }
    }
    
    private func onBack() {
        var backBy = 1
        let stepname = arrOfScreenName[observerManifestoObservedObject.currentIndex]
        print("Step Name: \(stepname) ")
        if stepname == "QUESTION_INTERLUDE01" {
            if let ans = UtilityMethod()
                .getQuestion(key: ConstantOfApp.kSelectedQuestion + "\(3)")?.selectedAnswer , ans.lowercased() == "no" {
                backBy = 2
            }
        }
        if (observerManifestoObservedObject.currentIndex > 0) {
            observerManifestoObservedObject.currentIndex -= backBy
        }
        showBack = observerManifestoObservedObject.currentIndex != 0
        setButtonVisibility(state: questionState, isNext: false)
        questionState = .none
    }
    
    private func onNext() {
        if(observerManifestoObservedObject.currentIndex < arrOfScreenName.count){
            if(arrNextShouldHide.contains(observerManifestoObservedObject.currentIndex)){
                if let selectedquestiondic = UtilityMethod().getQuestion(key: ConstantOfApp.kCurrentQuestion) {
                    loaderObserver.showLoader = true
                    let stepname = arrOfScreenName[observerManifestoObservedObject.currentIndex]
                    if let eAmplitudeKey = observerFooterObj.getCaseFromScreenName(screenName: stepname) {
                        AmplitudeService.sendEvent(key:eAmplitudeKey)
                    }
                    var ans = ""
                    if let selectedAns = UtilityMethod().getQuestion(
                        key: ConstantOfApp.kSelectedQuestion + "\(selectedquestiondic.id ?? 0)"
                    )?.selectedAnswer {
                        ans = selectedAns
                    }
                    var i = 0
                    if let index = selectedquestiondic.answer.firstIndex(where: {$0.ans == ans}) {
                        i = index
                    }
                    let backendAnswer = selectedquestiondic.backendAnswer[i]
                    ManifestoHelper.fetchAnwserList(
                        stepName: stepname,
                        anwser: [backendAnswer]
                    ) { error, status in
                        loaderObserver.showLoader = false
                        if status {
                            var nextBy = 1
                            let stepname = arrOfScreenName[observerManifestoObservedObject.currentIndex]
                            if stepname == "QUESTION_PARENTAL_CONTROL_APP" {
                                if let ans = UtilityMethod()
                                    .getQuestion(key: ConstantOfApp.kSelectedQuestion + "\(3)")?.selectedAnswer , ans.lowercased() == "no" {
                                    nextBy = 2
                                }
                            }
                            observerManifestoObservedObject.currentIndex += nextBy
                            showBack = observerManifestoObservedObject.currentIndex != 0
                            setButtonVisibility(state: questionState, isNext: true)
                            questionState = .none
                        } else {
                            print("error is = \(error)")
                        }
                    }
                } else {
                    observerManifestoObservedObject.currentIndex += 1
                    showBack = observerManifestoObservedObject.currentIndex != 0
                    setButtonVisibility(state: questionState, isNext: true)
                    questionState = .none
                }
            } else {
                loaderObserver.showLoader = true
                let stepname = arrOfScreenName[observerManifestoObservedObject.currentIndex]
                if let eAmplitudeKey = observerFooterObj.getCaseFromScreenName(screenName: stepname) {
                    AmplitudeService.sendEvent(key:eAmplitudeKey)
                }
                ManifestoHelper.nextStepOnBordingAPICall(
                    stepName: stepname
                ) { error, status in
                    loaderObserver.showLoader = false
                    if status {
                        
                        if observerManifestoObservedObject.currentIndex == 24 {
                            self.rootViewObserver.currentPage = .signUp
                        } else {
                            observerManifestoObservedObject.currentIndex += 1
                        }
                        setButtonVisibility(state: questionState, isNext: true)
                    } else {
                        print("erorr is = \(error) for on boarding api call")
                    }
                }
            }
        }
    }
}
