//
//  attendee.dashboard.note.view.swift
//  MrArthur
//
//  Created by Troo on 31/08/22.
//

import SwiftUI
import RichText

struct AttendeeDashboardNoteView: View {
    @AppStorage(
        ExtensionSharedAppGroupService.keys.EDUCATIONAL_ST_QUARTER_ON_GOING,
        store: ExtensionSharedAppGroupService.sharedDefault
    ) var educationalSTQuarterOnGoing: Int = 0
    
    @ObservedObject var observer = AttendeeDashboardNoteViewObserver()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Image("AttendeeDashboardStarBigYellow")
                .frame(width: 44.r, height: 44.r)
                .background(Color.whiteColor)
                .zIndex(1)
            
            VStack(spacing: 0) {
                
                Text("SMART ONES GAIN TIME!".localized)
                    .fontModifier(
                        font: .montserratBlack,
                        size: iPhoneFont15,
                        color: .primaryBlue
                    )
                    .padding(.top, 24.h)
                
                RichText(html: observer.getHtmlString(educationalSTQuarterOnGoing: educationalSTQuarterOnGoing))
                .customCSS(UtilityMethod.achivementCss)
                
            }
            .padding(8)
            .background(Color.white.cornerRadius(24.r))
            .padding(1.r)
            .background(Color.primaryYellow.cornerRadius(24.r))
            .padding(.top, 24.h)
            .zIndex(0)
        }
    }
}

struct AttendeeDashboardNoteViewPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            AttendeeDashboardNoteView()
            Spacer()
        }
        .padding()
        .background(Color.secondaryRed)
        .multiPreview
    }
}
