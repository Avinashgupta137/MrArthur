//
//  achievement.multiday.horizontal.view.swift
//  MrArthur
//
//  Created by BAPS on 15/11/22.
//

import SwiftUI

struct AchievementMultidayHorizontalView: View {
    
    @Binding var educationalTimeSpent: Int
    @Binding var totalEducationalTime: Int
    @Binding var totalEntertainmentTime: Int
    
    @State var sTimeSpent: CGFloat = 0
    @State var sTimeRemaining: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top){
            
            GeometryReader { geometry in
                HStack(spacing: 0){
                    Rectangle()
                        .fill(Color.primaryBlue)
                        .frame(
                            width: min(
                                geometry.size.width * (self.sTimeSpent),
                                geometry.size.width
                            )
                        )
                        .animation(.linear, value: sTimeSpent)
                    
                    Rectangle()
                        .fill(Color.progressGray)
                        .frame(
                            width: min(
                                geometry.size.width * (self.sTimeRemaining),
                                geometry.size.width
                            )
                        )
                        .animation(.linear, value: sTimeRemaining)
                }
            }
            .frame(height: 40.h)
            .cornerRadius(25.r, corners: [.topLeft, .bottomLeft])
            .padding(5.r)
            .background(
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(
                        25.r,
                        corners: [.topLeft, .bottomLeft]
                    )
                    .shadow(radius: 6, x: 0, y: 3)
            )
        }
        .onAppear {
            setValues()
        }
        .onChange(of: educationalTimeSpent) { _ in
            setValues()
        }
        .onChange(of: totalEducationalTime) { _ in
            setValues()
        }
        .onChange(of: totalEntertainmentTime) { _ in
            setValues()
        }
    }
    
    private func getEntertainmentQuarter() -> QuartersFromSecondModel {
        return ExtensionScreenTimeHelperService.getQuartersFromSecond(second: totalEntertainmentTime)
    }
    
    private func setValues() {
            if educationalTimeSpent > 0 && totalEducationalTime > 0 && totalEntertainmentTime > 0 {
                sTimeSpent = CGFloat((educationalTimeSpent * 100) / totalEducationalTime) / 100
                if (sTimeSpent < 1) {
                    sTimeRemaining = 1 - sTimeSpent

                } else {
                    sTimeRemaining = 0
                }
            } else {
                sTimeSpent = 0
                sTimeRemaining = 1
            }
        }
}

//struct AchievementMultidayHorizontalView_Previews: PreviewProvider {
//    static var previews: some View {
//        AchievementMultidayHorizontalView(
//            educationalTimeSpent: .constant(50),
//            totalEducationalTime: .constant(100),
//            totalEntertainmentTime: .constant(100)
//        )
//    }
//}
