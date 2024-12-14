//
//  AttendeeList.swift
//  MrArthur
//
//   Created by IPS-169 on 26/07/22.
//

import SwiftUI

struct AttendeeListCell: View {
    //observable object
    @StateObject var observed = Observed()
    var title: String
    var iconAvtar: String
    var body: some View {
        VStack(spacing: 10){
            Image(iconAvtar)
                .resizable()
                .frame(width: 83, height: 83)
            Text(title)
                .font(AppFont.MontserratBoldFont(fontSize: CGFloat(isiPad() ? FontSize.ansiPad : FontSize.ansiPhoneFont)))
                .foregroundColor(.black)
                .frame(width: UIScreen.screenWidth - 211,height: 67, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
        .padding(16)
        .frame(width: UIScreen.screenWidth - 32)
        .background(Group{
            Color.white
        })
        .contentShape(Rectangle())
        .cornerRadius(34)
        .shadow(radius: 2)
    }
    
    
    
}

//struct AttendeeList_Previews: PreviewProvider {
//    static var previews: some View {
//        AttendeeList(title: "Title")
//    }
//}
