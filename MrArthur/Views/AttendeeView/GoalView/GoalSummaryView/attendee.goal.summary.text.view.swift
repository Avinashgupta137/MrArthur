//
//  attendee.goal.summary.text.view.swift
//  MrArthur
//
//  Created by BAPS on 29/11/22.
//

import SwiftUI
import RichText

struct ATTGoalSummaryTextView: View {
    
    let rPercentage: Int
    let rDuration: String
    let ePercentage: Int
    let eDuration: String
    
    var body: some View {
        VStack{
            RichText(html: getHtmlString())
            .fontType(.customName("Montserrat-Bold"))
            .customCSS(UtilityMethod.goalCss)

        }
        .padding(.top, 25.h)
    }
    
    private func getHtmlString() -> String {
        return """
        <p>\("You would like to reduce ".localized)<br>
            <span class="primaryRedBg">\("your total screen time".localized)</span>
             \(" by".localized)
            <span style="color: #FD657C;">\(rPercentage)%</span>
            \(" per day. This means you will have ".localized)
            <span class="primaryRedBg">\(rDuration)</span>
            \("of screen time per day.".localized)
        </p>
        <p>
            \("You’ve also increased you ".localized)<br>
            <span class="primaryBlueBg">\("educational screen time".localized)</span>
             \("to".localized)
            <span style="color: #272F60;">\(ePercentage)%<span style="color: #FFFFFF;">.</span></span>
            \(" This means you will spend ".localized)
            <span class="primaryBlueBg">\(eDuration)</span>
            \(" on smart time per day".localized)
        </p>
"""
    }
}

//struct attendee_goal_summary_text_view_Previews: PreviewProvider {
//    static var previews: some View {
//        attendee_goal_summary_text_view()
//    }
//}
