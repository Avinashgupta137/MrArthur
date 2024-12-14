//
//  observer.manifesto.context.view.swift
//  MrArthur
//
//  Created by IPS-169 on 08/07/22.
//

import SwiftUI

struct ObserverManifestoContextView: View {
    
    let index: Int
    @Binding var startProgress: Bool
    let onAnswerTap: () -> ()
    let onQuestionProcessingCompletion: () -> ()
    @State var iFrameUpdate = 0
    
    var body: some View {
        Group {
            switch index {
            case 0:
                ManifestoYouMadeTheHardPartView()
            case 1:
                ManifestoScreenIssueAwarenessView()
            case 2:
                ManifestoMrarthurNurseView()
            case 3:
                ManifestoHealthyScreenUseView()
            case 4:
                QuestionTimerIntroductionView()
            case 5:
                ManifestoQuestionView(model: getQuestionByIndex(index: 0)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 0), selectedAnswer: answer)
                }
            case 6:
                ManifestoQuestionView(model: getQuestionByIndex(index: 1)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 1), selectedAnswer: answer)
                }
            case 7:
                ManifestoQuestionView(model: getQuestionByIndex(index: 2)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 2), selectedAnswer: answer)
                }
            case 8:
                ManifestoQuestionView(model: getQuestionByIndex(index: 3)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 3), selectedAnswer: answer)
                }
            case 9:
                ManifestoQuestionView(model: getQuestionByIndex(index: 4)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 4), selectedAnswer: answer)
                }
            case 10:
                ManifestoQuestioninterlude()
            case 11:
                ManifestoQuestionView(model: getQuestionByIndex(index: 5)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 5), selectedAnswer: answer)
                }
            case 12:
                ManifestoQuestionView(model: getQuestionByIndex(index: 6)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 6), selectedAnswer: answer)
                }
            case 13:
                ManifestoQuestionView(model: getQuestionByIndex(index: 7)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 7), selectedAnswer: answer)
                }
            case 14:
                ManifestoWarningEmpoweredKid()
            case 15:
                ManifestoThereIsHope()
            case 16:
                ManifestoButHowDoesitWork()
            case 17:
                ManifestoTimeReductionExplanation()
            case 18:
                ManifestoSmartTimeExplanationView()
            case 19:
                ManifestoAiPrognosisExplanation()
            case 20:
                ManifestoQuestionView(model: getQuestionByIndex(index: 8)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 8), selectedAnswer: answer)
                }
            case 21:
                ManifestoQuestionView(model: getQuestionByIndex(index: 9)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 9), selectedAnswer: answer)
                }
            case 22:
                ManifestoQuestionView(model: getQuestionByIndex(index: 10)) { answer in
                    onAnswer(model: getQuestionByIndex(index: 10), selectedAnswer: answer)
                }
            case 23:
                QuestionDataProcessingView(
                    startProgress: $startProgress,
                    onComplete: onQuestionProcessingCompletion
                )
            case 24:
                FinalScreenGoToLogInView()
            default:
                AppEmptyView(note: "404")
            }
        }
        .id(iFrameUpdate)
    }
    
    private func getQuestionByIndex(index: Int) -> AnswerModel {
        return UtilityMethod.getManifestoQuestionList(.OBSERVER_USER)[index]
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
