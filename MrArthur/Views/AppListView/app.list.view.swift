//
//  app.list.view.swift
//  MrArthur
//
//  Created by BAPS on 17/01/23.
//

import SwiftUI

struct AppListView: View {
    
    @StateObject var observer = AppListObserver()
    @EnvironmentObject private var loaderObserver: LoaderObserver
    
    var body: some View {
        Group {
            if observer.appList.count > 0 {
                VStack(spacing: 0) {
                    
                    if observer.categoryRow.count > 0 {
                        VStack(spacing: 0) {
                            ForEach(observer.categoryRow, id:\.self){ categories in
                                HStack(spacing: 14.w){
                                    ForEach(categories){ category in
                                        AppListTagView(category: category) {
                                            self.observer.setSelection(category)
                                        }
                                    }
                                }
                            }
                            .padding(.bottom, 16.h)
                        }
                        .padding(.vertical, 34.h)
                    }
                    
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 0) {
                            ForEach(observer.appList) { app in
                                Group {
                                    if observer.firstApp?.id == app.id {
                                        VStack(alignment: .leading, spacing: 14.h) {
                                            Text("Don't miss it!".localized)
                                                .fontModifier(
                                                    font: .montserratBlack,
                                                    size: 25.sp,
                                                    color: .primaryBlue
                                                )
                                                .padding(.leading, 21.w)
                                            AppListCellView(
                                                app: app,
                                                onInstall: {
                                                    observer.installApp(app)
                                                },
                                                onShare: {
                                                    observer.shareApp(app)
                                                }
                                            )
                                        }
                                        .padding(.top, 13.h)
                                        .background(Color.white)
                                    } else {
                                        AppListCellView(
                                            app: app,
                                            onInstall: {
                                                observer.installApp(app)
                                            },
                                            onShare: {
                                                observer.shareApp(app)
                                            }
                                        )
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
            } else {
                ListEmptyView(message: "No apps available here.")
            }
        }
        .onAppear {
            observer._init(loaderObserver: loaderObserver)
        }
        .customNavigationView(title: "Educational apps", color: .white)
        .background(Color.secondaryRed)
        
    }
}

struct AppListView_Previews: PreviewProvider {
    static var previews: some View {
        AppListView()
    }
}
