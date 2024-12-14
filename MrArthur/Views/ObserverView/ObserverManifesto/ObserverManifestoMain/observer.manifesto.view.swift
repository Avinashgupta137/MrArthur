//
//  observer.manifesto.view.swift
//  MrArthur
//
//  Created by IPS-169 on 08/07/22.
//

import SwiftUI
import SwiftUIPager

struct ObserverManifestoMainView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var loaderObserver: LoaderObserver
    @EnvironmentObject private var observerManifesto: ObserverManifesto
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @StateObject var observer = ObserverManifestoObserver()
    @StateObject var page: Page = .first()
    @State var showPrivacyFlow = false
    let pages = Array(0..<25)
    
    var body: some View {
        LoadingView {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    
                    ObserverHeaderView()
                        .padding(.top, 16)
                        .statusBarStyle(color: .white)
                        .opacity(observer.hideHeaderProgress ? 0 : 1)
                    
                    Spacer()
                    
                    ManifestoFooterView(
                        title: observer.buttonTitle,
                        hideBackButton: observer.hideBackButton,
                        hideNextButton: observer.hideNextButton,
                        onBack: {
                            observer.onBack { move in
                                withAnimation {
                                    self.page.update(.move(increment: -move))
                                }
                            } showPrivacy: {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        },
                        onNext: {
                            observer.onNext { move in
                                self.movePage(move)
                            } showPrivacy: {
                                // navigate
                                self.showPrivacyFlow = true
                            }
                        }
                    )
                }
                .zIndex(10)
                
                Pager(
                    page: self.page,
                    data: self.pages,
                    id: \.self
                ) { i in
                    ObserverManifestoContextView (
                        index: i,
                        startProgress: $observer.startProgress,
                        onAnswerTap: {
                            observer.onNext { move in
                                self.movePage(move)
                            }
                        },
                        onQuestionProcessingCompletion: {
                            observer.onNext { move in
                                self.movePage(move)
                            }
                        }
                    )
                }
                .pageOffset(0)
                .disableDragging()
                .itemSpacing(0)
                .contentLoadingPolicy(.lazy(recyclingRatio: 2))
            }
        }
        .navigationDestination(isPresented: $showPrivacyFlow) {
            ObserverAddupPrivacyView(fromSingIn: false)
        }
        .onAppear {
            let currentIndex = self.observerManifesto.currentIndex
            self.page.index = currentIndex
            self.observer._init(
                loaderObserver: self.loaderObserver,
                observerManifesto: self.observerManifesto,
                rootViewObserver: self.rootViewObserver
            )
        }
        .hideNavigation
        .ignoresSafeArea()
    }
    
    private func movePage(_ value: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                self.page.update(.move(increment: value))
            }
        }
    }
}

