//
//  AttendeeManifestoContextView.swift
//  MrArthur
//
//  Created by IPS-157 on 04/08/22.
//

import SwiftUI

struct AttendeeManifestoContextView: View {
    
    let index: Int
    @Binding var startProgress: Bool
    let onAnswerTap: () -> ()
    let onQuestionProcessingCompletion: () -> ()
    let arrOfAttendeeScreenName = UtilityMethod.attendeeManifestoScreenList
    @State var iFrameUpdate = 0

    var body: some View {
        
        VStack(spacing: 0) {
            switch arrOfAttendeeScreenName[index] {
            case "MANIFESTO_INTRO_HELLO_AND_FOLLOW_ME":
                ManifestoIntroHelloandFollowme()
            case "MANIFESTO_MR_ARTHUR_IS_YOUR_FRIEND":
                ManifestoMrArthurIsYourFriend()
            case "MANIFESTO_MR_ARTHUR_WILL_MAKE_YOU_SMART":
                ManifestoMrArthurWillMakeYouSmart()
            case "MANIFESTO_MAKE_THE_FIRST_STEP_AGAINST_TYRANNY":
                ManifestoMakeTheFirstStepAgainstTyranny()
            case "MANIFESTO_MR_ARTHUR_WILL_EMPOWER_YOU":
                ManifestoMrArthurWillEmpowerYou()
            case "MANIFESTO_MR_ARTHUR_IS_A_NURSE":
                ManifestoMrArthurIsaNurse()
            case "MANIFESTO_HOW_KID_WILL_MAKE_A_PROPOSAL":
                ManifestoHowKidWillMakeAProposal()
            case "MANIFESTO_ENJOY_FREE_TIME_WITH_BUDDIES":
                ManifestoEnjoyFreeTimeWithBuddies()
            case "MANIFESTO_LETS_EMBARK" :
                ManifestoLetsEmbark()
            case "QUESTION_TOO_MUCH_TIME_ON_SCREEN" :
                ManifestoQuestionView(model: getQuestionByIndex(index: 0)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 0), selectedAnswer: answer)
                }
            case "QUESTION_MOST_PROBLEMATIC_DEVICE_PART1":
                ManifestoQuestionView(model: getQuestionByIndex(index: 1)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 1), selectedAnswer: answer)
                }
            case "QUESTION_MOST_PROBLEMATIC_DEVICE_PART2":
                ManifestoQuestionView(model: getQuestionByIndex(index: 2)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 2), selectedAnswer: answer)
                }
            case "QUESTION_FAMILY_SCREEN_ARGUMENTS":
                ManifestoQuestionView(model: getQuestionByIndex(index: 3)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 3), selectedAnswer: answer)
                }
            case "QUESTION_COURAGE_LITTLE_TIME_LEFT":
                QuestionCourageLittleTimeLeft()
            case "QUESTION_WOULD_ACCEPT_ENFORCED_TIME_LIMIT_RULES":
                ManifestoQuestionView(model: getQuestionByIndex(index: 4)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 4), selectedAnswer: answer)
                }
            case "QUESTION_WOULD_PREFER_EMPOWERMENT_AND_ADVICES":
                ManifestoQuestionView(model: getQuestionByIndex(index: 5)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 5), selectedAnswer: answer)
                }
            case "QUESTION_ENJOY_AND_LEARN":
                ManifestoQuestionView(model: getQuestionByIndex(index: 6)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 6), selectedAnswer: answer)
                }
            case "QUESTION_ABOUT_SMART_EDUCATIVE_APPS":
                ManifestoQuestionView(model: getQuestionByIndex(index: 7)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 7), selectedAnswer: answer)
                }
            case "QUESTION_PERFECT_WELL_DONE":
                AttendeeQuestionPerfectWellDone()
            case "QUESTION_DATA_PROCESSING":
                QuestionDataProcessingView(
                    startProgress: $startProgress,
                    onComplete: onQuestionProcessingCompletion
                )
            default:
                AppEmptyView(
                    note: "404"
                )
            }
        }
        .id(iFrameUpdate)
    }
    
    private func getQuestionByIndex(index: Int) -> AnswerModel {
        return UtilityMethod.getManifestoQuestionList(.ATTENDEE_USER)[index]
    }
    
    private func onAnswer(model: AnswerModel, selectedAnswer: String) {
        var question = model
        question.selectedAnswer = selectedAnswer
        UserDefaultsHelper.setQuestionForID(question)
        self.iFrameUpdate += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.onAnswerTap()
        }
    }
}

//struct AttendeeManifestoContextView_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeManifestoContextView()
//    }
//}
