//
//  AttendeeMaifestoFooterView.swift
//  MrArthur
//
//  Created by IPS-169 on 29/07/22.
//

import SwiftUI

struct AttendeeMaifestoFooterView: View {
    @Binding var questionstate: StateOfQuestion
    let arrofQuestion = UtilityMethod.attendeeManifestoQuestionList

    let arrOfAttendeeScreenName = UtilityMethod.attendeeManifestoScreenList
    //observed object
    @StateObject private var observed = Observed()
    @StateObject private var manifestoObserved = AttendeeManifestoHelper()
    @EnvironmentObject private var loaderObserver: LoaderObserver
    @EnvironmentObject private var attendeeManifestoObservedObject : AttendeeManifestoObserver
    
    // MARK: - PROPERTIES
    @State  var showback = true
    @State var shownext = true
    let imageButton : CGFloat = isiPad() ? 50 : 30
    @State static var titlebtn : String = "NEXT"
    var body: some View {
        HStack {
            if showback {
                Button {
                    if(attendeeManifestoObservedObject.currentIndex > 0){
                        if let emplitudeKey = observed.getCaseFromScreenNameForBackBtn(
                            screenName: arrOfAttendeeScreenName[attendeeManifestoObservedObject.currentIndex]
                        ) {
                            AmplitudeService.sendEvent(key: emplitudeKey)
                        }
                        attendeeManifestoObservedObject.currentIndex  -= 1
                    }
                    showback = attendeeManifestoObservedObject.currentIndex  != 0
                    setButtonVisibility(state: questionstate)
                    questionstate = .none
                    
                } label: {
                    Image.init(systemName: "arrow.backward")
                        .resizable()
                        .font(Font.title.weight(.heavy))
                        .scaledToFit()
                        .frame(width: imageButton, height: imageButton)
                        .padding(10 )
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
            
            BlueRoundedButton(getNextButtonLabel()){
                onNext()
            }
            .opacity(shownext ? 1 : 0)
            
        }
        .padding(EdgeInsets(top: 0 , leading: 20, bottom: 40, trailing: 20))
        .onChange(of: questionstate, perform: { newValue in
            print("onChange \(newValue)")
            setButtonVisibility(state: newValue)
        })
        .onAppear(perform: {
            setButtonVisibility(state: questionstate)
        })
        
    }
    
    private func setButtonVisibility(state: StateOfQuestion) {
        print("Attendee menifesto index  \(attendeeManifestoObservedObject.currentIndex)")
        UserDefaultsHelper.attendeeManifestoLatestStep = attendeeManifestoObservedObject.currentIndex
        let screenname = arrOfAttendeeScreenName[attendeeManifestoObservedObject.currentIndex]
        if(arrofQuestion.contains(screenname)){
            if(state == .answerGiven){
                showback = true
                shownext = true
            }else if(state == .answerGiving){
                showback = false
                shownext = false
            }else{
                showback = true
                shownext = false
            }
        } else {
            let index = attendeeManifestoObservedObject.currentIndex
            let screenName: String = arrOfAttendeeScreenName[index]
            if screenName == "MANIFESTO_INTRO_HELLO_AND_FOLLOW_ME" ||
                screenName  == "QUESTION_PERFECT_WELL_DONE" ||
                screenName  == "QUESTION_DATA_PROCESSING" {
                showback = false
                shownext = screenName != "QUESTION_DATA_PROCESSING"
            } else {
                showback = true
                shownext = true
            }
        }
    }
    
    private func getNextButtonLabel() -> String {
        let screenname = arrOfAttendeeScreenName[self.attendeeManifestoObservedObject.currentIndex]
        var label = "NEXT"
        if(screenname == "MANIFESTO_INTRO_HELLO_AND_FOLLOW_ME"){
            label = "START"
        }
        if (screenname == "MANIFESTO_LETS_EMBARK" || screenname == "HOW_IT_WORKS_FINAL_SCREEN") {
            label = "LET'S GO!"
        }
        if screenname == "QUESTION_COURAGE_LITTLE_TIME_LEFT"  {
            label = "CONTINUE"
        }
        
        return label
    }
    
    private func onNext() {
        if(attendeeManifestoObservedObject.currentIndex  < arrOfAttendeeScreenName.count){
//            let screenname = arrOfAttendeeScreenName[attendeeManifestoObservedObject.currentIndex]
            if(arrofQuestion.contains(arrOfAttendeeScreenName[attendeeManifestoObservedObject.currentIndex])){
                if let selectedquestiondic = UtilityMethod().getQuestion(key: ConstantOfApp.kCurrentAttendeeQuestion) {
                    loaderObserver.showLoader = true
                    let stepName = arrOfAttendeeScreenName[attendeeManifestoObservedObject.currentIndex]
                    if let emplitudeKey = observed.getCaseFromScreenName(screenName: stepName){
                        AmplitudeService.sendEvent(key: emplitudeKey)
                    }
                    
                    var ans = ""
                    if let selectedAns = UtilityMethod().getQuestion(
                        key: ConstantOfApp.kSelectedAttendeeQuestion + "\(selectedquestiondic.id ?? 0)"
                    )?.selectedAnswer {
                        ans = selectedAns
                    }
                    var i = 0
                    if let index = selectedquestiondic.answer.firstIndex(where: {$0.ans == ans}) {
                        i = index
                    }
                    let backendAnswer = selectedquestiondic.backendAnswer[i]
                    
                    manifestoObserved.fetchAttendeeAnwserList(
                        stepName: arrOfAttendeeScreenName[attendeeManifestoObservedObject.currentIndex],
                        anwser: [backendAnswer]
                    ) { error, onbordignresponse in
                        loaderObserver.showLoader = false
                        if let error = error, !error.isEmpty {
                            print("ERROR: ", error)
                        } else {
                            attendeeManifestoObservedObject.currentIndex += 1
                            showback = attendeeManifestoObservedObject.currentIndex != 0
                            setButtonVisibility(state: questionstate)
                            questionstate = .none
                        }
                    }
                } else {
                    attendeeManifestoObservedObject.currentIndex += 1
                    if let emplitudeKey = observed.getCaseFromScreenName(screenName: arrOfAttendeeScreenName[attendeeManifestoObservedObject.currentIndex]){
                        AmplitudeService.sendEvent(key: emplitudeKey)
                    }
                    showback = attendeeManifestoObservedObject.currentIndex != 0
                    setButtonVisibility(state: questionstate)
                    questionstate = .none
                }
            } else {
                loaderObserver.showLoader = true
                let stepName = arrOfAttendeeScreenName[attendeeManifestoObservedObject.currentIndex]
                if let emplitudeKey = observed.getCaseFromScreenName(
                    screenName: stepName
                ){
                    AmplitudeService.sendEvent(key: emplitudeKey)
                }
                manifestoObserved.nextStepOnBordingAttendeeAPICall(
                    stepName: stepName
                ) { errormessage, status in
                    loaderObserver.showLoader = false
                    if (status != nil) {
                        if attendeeManifestoObservedObject.currentIndex  == 25 {
                            attendeeManifestoObservedObject.currentIndex += 1
                        } else {
                            attendeeManifestoObservedObject.currentIndex  += 1
                        }
                        setButtonVisibility(state: questionstate)
                    }
                    else{
                        print("erorr is = \(String(describing: errormessage)) for on boarding api call")
                    }
                }
            }
        }
    }
}

