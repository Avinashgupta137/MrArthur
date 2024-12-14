//
//  ManifestoAttendee.swift
//  MrArthur
//
//  Created by IPS-169 on 28/07/22.
//

import SwiftUI
import SwiftUIPager

struct AttendeeManifesto: View {
    @EnvironmentObject private var loaderObserver: LoaderObserver
    @EnvironmentObject private var attendeeManifestoObserver: AttendeeManifestoObserver
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @State var questionState: StateOfQuestion = .none
    @StateObject var observer = ATTManifestoObserver()
    @StateObject var page: Page = .first()
    
    var body: some View {
        LoadingView {
            ZStack(alignment: .top){
                VStack{
                    AttendeeManifestoHeaderView(
                        questionstate: $questionState
                    )
                    .padding(.top, 16)
                    .statusBarStyle(color: .white)
                    .opacity(observer.hideHeaderProgress ? 0 : 1)
                    
                    Spacer()
                    //MARK: Footer View
                    ManifestoFooterView(
                        title: observer.buttonTitle,
                        hideBackButton: observer.hideBackButton,
                        hideNextButton: observer.hideNextButton,
                        onBack: {
                            withAnimation {
                                observer.onBack { move in
                                    self.page.update(.move(increment: -move))
                                }
                            }
                        },
                        onNext: {
                            observer.onNext { move in
                                self.movePage(move)
                            }
                        }
                    )
                       
                } .zIndex(10)
                Pager(
                    page: self.page,
                    data: observer.pages,
                    id: \.self
                ) { i in
                    AttendeeManifestoContextView (
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
        .onAppear {
            let currentIndex = self.attendeeManifestoObserver.currentIndex
            self.page.index = currentIndex
            self.observer._init(
                loaderObserver: self.loaderObserver,
                attendeeManifestoObserver: self.attendeeManifestoObserver,
                rootViewObserver: self.rootViewObserver
            )
        }
        .onChange(of: attendeeManifestoObserver.currentIndex, perform: { newValue in
            UserDefaultsHelper.attendeeManifestoLatestStep = newValue
        })
        .hideNavigation
        .ignoresSafeArea()
    }
    
    private func movePage(_ value: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                self.page.update(.move(increment: value))
            }
        }
//        if observer.isDataProcessView() {
//            self.observer.startProgress = true
//        }
    }
}
