//
//  QuestionDataProcessingView.swift
//  MrArthur
//
//  Created by IPS-157 on 20/07/22.
//

import SwiftUI

struct QuestionDataProcessingView: View {

    @State var headLabel = "Analysing"
    @State var subLabel = "your answers"
    @State var progress = "0%"
    @State var percentage  = 0
    @Binding var startProgress: Bool
    let onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            
            Spacer(minLength: 16.h)
            
            Text(headLabel.localized)
                .fontModifier(
                    font: (percentage < 80) ? .montserratRegular : .montserratRegular,
                    size: iPhoneFont25 ,
                    color: (percentage < 80) ? .white : .white
                )
            
            Text(subLabel.localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont25,
                    color: .white
                )
                .padding(.top, 5.h)
            
            CircularProgressView(
                startProgress: $startProgress,
                onComplete: onComplete,
                onChange: { value in
                    progress = "\(value)%"
                    percentage = value
                    print(progress)
                }
            )
                .frame(
                    width: 227.w,
                    height: 227.h
                )
                .padding(.top, 70.h)
            
            Text(progress)
                .fontModifier(
                    font: .montserratRegular,
                    size: iPhoneFont50
                )
                .padding(.top, 28.h)
            
            Spacer(minLength: 16.h)
        }
        .statusBarStyle(color: .statusBarColor)
        .background(
            LinearGradient(
                colors: [
                    Color.primaryRed,
                    Color.thirdRed
                ],
                startPoint: .top,
                endPoint: .bottomTrailing
            )
        )
        .onAppear {
            print("ON APPEAR QuestionDataProcessingView")
        }
        .onChange(of: percentage) { newValue in
            if percentage >= 80 {
                headLabel = "Personalization".localized
                subLabel = "of your program".localized
            }
        }
    }
}

//struct QuestionDataProcessingView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionDataProcessingView(questionState: .constant(.none))
//            .multiPreview
//    }
//}
