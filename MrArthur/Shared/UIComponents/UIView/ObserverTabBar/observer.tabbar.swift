//
//  ObserverTabBar.swift
//  MrArthur
//
//  Created by IPS-157 on 26/07/22.
//

import SwiftUI
import Intercom
struct ObserverTabBar: View {
    
    @State var tabPage: ETabPage = .page_01
    @State var video: MediaDetails = MediaDetails()
    @State private var isPresented: Bool = Bool()
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch tabPage {
                case .page_01:
                    ObserverDashboardView()
                case .page_02:
                    AppListView()
                case .page_03:
                    MediaView { video in
                        self.video = video ?? MediaDetails()
                        self.isPresented.toggle()
                    }
                case .page_04:
                    ObserverMoreMainView()
                }
            }
            TabbarView(tabPage: $tabPage) {
                self.onAppearMessage()
            }
        }
        .customPopupView(isPresented: $isPresented, popupView: {
            WebMainView(media: self.$video, isPresented: $isPresented)
        })
        .edgesIgnoringSafeArea(.all)
        .background(.white)
    }
    
    func onAppearMessage(){
        let observerEmail = UtilityMethod().getValueForKey(key: ConstantOfApp.kEmailId ) as? String
        IntercomMessageService().registerMail(email: observerEmail)
    }
}
