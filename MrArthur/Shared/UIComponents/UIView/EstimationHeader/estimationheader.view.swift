//
//  EstimationHeaderView.swift
//  MrArthur
//
//  Created by IPS-157 on 26/07/22.
//

import SwiftUI

struct EstimationHeaderView: View {
    @AppStorage("HowItWorkScreenNo", store: UserDefaults(suiteName: "group.com.mrarthur.parental")) var howItWorkScreenNo : Int = 0
    @Environment(\.presentationMode) var presentationMode
    @Binding var title:String
    
    var body: some View {
        ZStack(alignment: .leading){
            Button {
            
                if(title == "Create a child profile - Identity".localized){
                    howItWorkScreenNo = 4
                    self.presentationMode.wrappedValue.dismiss()
                }else{
                    self.presentationMode.wrappedValue.dismiss()
                }
                
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.secondaryBlue)
                    .frame(width: 16, height: 16, alignment: .leading)
            }
            
            .padding(.leading, 20)
            .zIndex(1)
            HStack(){
                Spacer()
                Text(title.localized)
                    .fontModifier(font: .montserratBold, size: iPhoneFont20, color: .primaryBlue)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .zIndex(0)
        }
        .frame(width: UIScreen.screenWidth, height: statusBarHeight + 40, alignment: .leading)
        .background(
            Color.statusBarColor
        )
    }
}

struct EstimationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        EstimationHeaderView( title: .constant(""))
    }
}
