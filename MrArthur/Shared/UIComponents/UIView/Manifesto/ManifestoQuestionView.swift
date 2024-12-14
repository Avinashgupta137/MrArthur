//
//  ManifestoQuestionView.swift
//  MrArthur
//
//  Created by BAPS on 21/12/22.
//

import SwiftUI

struct ManifestoQuestionView: View {
    let model: AnswerModel
    let onTap: (String) -> ()
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(model.question?.localized ?? "")
                    .fontModifier(
                        font: .montserratBold,
                        size: iPhoneFont25
                    )
                
                Spacer()
            }
            .padding(.bottom, 38.h)
            
            VStack(spacing: 20.h){
                ForEach(0..<model.quesAnswers.count, id: \.self) { i in
                    ManifestoQuestionAnswerView(model: model.quesAnswers[i]) {
                        onTap(model.quesAnswers[i].ans)
                    }
                }
            }
            
            Spacer(minLength: 16.h)
        }
        .padding(.top, 40.h)
        .padding(.horizontal, 22.w)
        .statusBarStyle(color: .statusBarColor)
        .background(
            Group {
                if (model.answerGiven) {
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                .primaryBlue,
                                .primaryRed
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .center
                    )
                } else {
                    LinearGradient(
                        colors: [
                            Color.primaryRed,
                            Color.thirdRed
                        ],
                        startPoint: .top,
                        endPoint: .center
                    )
                }
            }
        )
    }
}


private struct ManifestoQuestionAnswerView: View {
    let model: AnswerValueModel
    let onTap: () -> ()
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack(spacing: 0) {
                Spacer(minLength: 16.w)
                Text(model.ans.localized)
                    .fontModifier(
                        font: model.isActive ? .montserratBold : .montserratRegular,
                        size: iPhoneFont18,
                        color: model.isActive ? .white : .primaryBlue
                    )
                    .multilineTextAlignment(.center)
                Spacer(minLength: 16.w)
            }
                .frame(height: 67.h)
        }
        .contentShape(Rectangle())
        .background(model.isActive ? Color.primaryBlue : Color.white)
        .cornerRadius(34.r)
    }
}
