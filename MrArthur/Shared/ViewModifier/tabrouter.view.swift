//
//  TabPage.swift
//  MrArthur
//
//  Created by IPS-157 on 26/07/22.
//


import Foundation

enum TabPage {
    case dashboard, messages, media, more
}

class TabViewRouter: ObservableObject {
    @Published var currentPage: TabPage
    init() {
        self.currentPage = .dashboard
    }
}
