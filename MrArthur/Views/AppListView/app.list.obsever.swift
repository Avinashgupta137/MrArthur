//
//  app.list.obsever.swift
//  MrArthur
//
//  Created by BAPS on 17/01/23.
//

import Foundation
import SwiftUI

class AppListObserver: ObservableObject{
    
    @Published var appList: [RecommandedAppListResponseModel] = []
    var allAppList: [RecommandedAppListResponseModel] = []
    @Published var categoryRow: [[AppCategory]] = []
    @Published var categories: [AppCategory] = []
    
    var firstApp: RecommandedAppListResponseModel?
    
    var loaderObserver: LoaderObserver? = nil
    
    func _init(loaderObserver: LoaderObserver) {
        self.loaderObserver = loaderObserver
        self.getRecommendedAppList()
    }
    
    func getRecommendedAppList() {
        self.loaderObserver?.showLoader = true
        RecommededAppService.getList { status, message, recommendedAppList in
            self.loaderObserver?.showLoader = false
            self.firstApp = recommendedAppList.first
            self.appList = recommendedAppList
            self.allAppList = recommendedAppList
            self.filterCategoiesFromAppList()
        }
    }
    
    func setSelection(_ cat: AppCategory) {
        var selectedCategory: AppCategory?
        for (index, category) in self.categories.enumerated() {
            if category.id == cat.id, !self.categories[index].isSelected {
                self.categories[index].selected = true
                selectedCategory = category
            } else {
                self.categories[index].selected = false
            }
        }
        self.getCategories()
        if selectedCategory != nil {
            self.appList = []
            if let first = self.firstApp {
                self.appList.append(first)
            }
            let list = allAppList.filter({$0.catList.contains(where: {$0.id == selectedCategory?.id})})
            self.appList.append(contentsOf: list)
        } else {
            self.appList = self.allAppList
        }
    }
    
    func shareApp(_ app: RecommandedAppListResponseModel) {
        guard let urlShare = URL(string: app.appLink) else { return }
        AppShared.shareSheet(items: [urlShare])
    }
    
    func installApp(_ app: RecommandedAppListResponseModel) {
        if let url = URL(string: app.appLink), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func filterCategoiesFromAppList() {
        let arr = self.appList.compactMap({$0.appCategoryList}).reduce([], +)
        self.categories = Array(Set(arr))
        self.getCategories()
    }
    
    private func getCategories(){
        var rows: [[AppCategory]] = []
        var currentRow: [AppCategory] = []
        
        var totalWidth: CGFloat = 0
        
        let screenWidth = UIScreen.screenWidth
        let tagSpaceing: CGFloat = 50.w
        
        if !categories.isEmpty {
            
            for index in 0..<categories.count{
                self.categories[index].size = categories[index].catName.getSize()
            }
            
            categories.forEach{ tag in
                
                totalWidth += ((tag.size ?? 0) + tagSpaceing)
                
                if totalWidth > screenWidth{
                    totalWidth = ((tag.size ?? 0) + tagSpaceing)
                    rows.append(currentRow)
                    currentRow.removeAll()
                    currentRow.append(tag)
                }else{
                    currentRow.append(tag)
                }
            }
            
            if !currentRow.isEmpty{
                rows.append(currentRow)
                currentRow.removeAll()
            }
            
            self.categoryRow = rows
        } else {
            self.categoryRow = []
        }
    }
}
