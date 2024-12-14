//
//  WhichDeviceAreYouUsing.swift
//  MrArthur
//
//  Created by IPS-169 on 26/07/22.
//

import SwiftUI

struct WhichDeviceAreYouUsing: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var attendeeManifestoObservedObject : AttendeeManifestoObserver
    @EnvironmentObject private var loaderObserver: LoaderObserver
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @StateObject var observed = WhichDeviceAreYouUsingObserver()
    @StateObject var observedQuestion = ObserverQuestionHelper()
    @State private var attendeeList = false
    @State private var attendeeAccount = false
    @State private var showDisplayInfo = false
    @State private var strSelectedAnswer:String = ""
    @State private var infoView: AnyView? = nil
    @State private var deviceUsingBtn = false
    @State private var finishViewActive = false
    
    var userExistingOrNew = UtilityMethod().getValueForKey(key: ConstantOfApp.kIsUserNewOrExist) as? String ?? ""
    private let fontSize: CGFloat = 18
    
    var infoObserver: some View {
        Group{
            Text("Once your Child's user profile has been created, you'll need to install the ".localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: fontSize,
                    color: .primaryBlue
                )
            +
            Text("mr.arthur ".localized)
                .fontModifier(
                    font: .montserratBold,
                    size: fontSize,
                    color: .primaryBlue
                )
            +
            Text("app on your child's device to continue.".localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: fontSize,
                    color: .primaryBlue
                )
        }
    }
    
    var infoAttendee: some View {
        Group{
            Text("Once your child's user profile has been created, please let him start and enjoy the App to send you a new screen time proposal.".localized)
                .fontModifier(
                    font: .montserratRegular,
                    size: fontSize,
                    color: .primaryBlue
                )
        }
    }
    
    var body: some View {
       LoadingView {
            ZStack {
                VStack(spacing: 0) {
                    HStack{
                        Text("WHICH_DEVICE_QUESTION".localized)
                            .fontModifier(
                                font: .montserratBold,
                                size: iPhoneFont25,
                                color: .primaryBlue
                            )
                            .padding(.bottom, 20.h)
                        Spacer()
                    }
                    VStack(spacing: 20.h){
                        ForEach(
                            0..<observedQuestion.selectedQuestion.answer.count,
                            id: \.self
                        ) { i in
                            AnswerTileView(
                                isActiveAnswer: $observedQuestion.selectedQuestion.answer[i].isActive,
                                title: observedQuestion.selectedQuestion.answer[i].ans,
                                onTap: {
                                    observedQuestion.deSelectAll()
                                    observedQuestion.selectedQuestion.answer[i].isActive = true
                                    showDisplayInfo = true
                                    strSelectedAnswer = observedQuestion.selectedQuestion.answer[i].ans.lowercased()
                                    deviceUsingBtn = true
                                    if(observedQuestion.selectedQuestion.answer[i].ans.lowercased() == "mine as a parent"){
                                        AmplitudeService.sendEvent(
                                            key: .OBS_ADD_UP_DEVICE_1_1_MINE_AS_A_PARENT
                                        )
                                        self.infoView = AnyView(infoObserver)
                                    }else{
                                        AmplitudeService.sendEvent(
                                            key: .OBS_ADD_UP_DEVICE_1_1_MINE_AS_MY_CHILD
                                        )
                                        self.infoView = AnyView(infoAttendee)
                                    }
                                    
                                }
                            )
                        }
                    }
                    
                    Spacer(minLength: 16.h)
                    
                    if(strSelectedAnswer.count == 0){
                        Image.init("DeviceOwnerChoice")
                            .resizable()
                            .frame(
                                width: UIScreen.screenWidth * 0.7,
                                height: UIScreen.screenWidth * 0.3
                            )
                    } else {
                        InfoDisplayView {
                            infoView
                        }
                    }
                    
                    Spacer(minLength: 16.resizable)
                    
                    BlueRoundedButton("NEXT".localized) {
                        onNext()
                    }
                    .opacity(deviceUsingBtn ? 1 : 0)
                    .disabled(!deviceUsingBtn)
                }
                NavigationLink(
                    "",
                    destination: AttendeeListView(),
                    isActive: $attendeeList
                )
                NavigationLink(
                    "",
                    destination: AddAttendeeAccountView(),
                    isActive: $attendeeAccount
                )
                NavigationLink(
                    "",
                    destination: AttendeeAddupfinishScannerView(),
                    isActive: $finishViewActive
                )
                
            }
        }
        .padding(.vertical, 32.h)
        .padding(.horizontal, 24.w)
        .frame(width: UIScreen.screenWidth)
        .onAppear {
            observedQuestion.getListOfQuestions(questionIndex: 11)
        }
        .customNavigationViewWithBackWidgit(
            title: "DEVICE_OWNER",
            color: .whiteColor,
            showBackButton: false
        )
        .background(
            LinearGradient(
                colors: [
                    Color.secondaryRed,
                    Color.lightPink
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
    
    private func onNext() {
        if(userExistingOrNew == ConstantOfApp.kExistingUser) {
            loaderObserver.showLoader = true
            if(strSelectedAnswer.localized == "mine as a parent".localized) {
                UtilityMethod().saveInDefault(value: ConstantOfApp.kCurrentUserObserver, key: ConstantOfApp.kCurrentUserRole)
                observed.showParentDashboard { message, status,countofattendee  in
                    loaderObserver.showLoader = false
                    if(status){
                        if(countofattendee.count > 0){
                            attendeeList = true
                        } else if (countofattendee.count == 0){
                            attendeeAccount = true
                        }
                    } else {
                        attendeeList = true
                    }
                }
            } else {
                UtilityMethod().saveInDefault (
                    value: ConstantOfApp.kCurrentUserAttendee,
                    key: ConstantOfApp.kCurrentUserRole
                )
                
                observed.showParentDashboard { message, status,attendeeOnboardingResponse  in
                    loaderObserver.showLoader = false
                    if(status){
                        if(attendeeOnboardingResponse.count > 0){
                            attendeeList = true
                        }else {
                            if(attendeeOnboardingResponse.count == 1){
                                let mediation = attendeeOnboardingResponse.first?.attendeeUserMediationList?.first
                                UtilityMethod().saveInDefault(value: mediation?.uuid ?? "", key: ConstantOfApp.kMediationUDID)
                                print("mediation uuid = \(UtilityMethod().getValueForKey(key: ConstantOfApp.kMediationUDID))")
                                UtilityMethod().saveInDefault(value: attendeeOnboardingResponse.first?.attendeeUserOnboarding?.uuid ?? "", key: ConstantOfApp.kAttendeeUUID)
                                print("attendee uuid = -\(attendeeOnboardingResponse.first?.attendeeUserOnboarding?.uuid ?? "")")
                                let settingDone = UtilityMethod().getValueForKey(key: ConstantOfApp.kAppSettingDone) as? Bool ?? false
                                if(settingDone){
                                    observed.attendeeLogin { status, message,attendeeResponse, value  in
                                        if(attendeeResponse.user?.attendeeUserMediationList?.count ?? 0 > 0) {
                                            if let attendeeManifestoDone = attendeeResponse.user?.attendeeUserOnboarding?.isOnbardingCompleted{
                                                if(attendeeManifestoDone){
                                                    let statusOfMediation = UtilityMethod().getValueForKey(key: ConstantOfApp.kStatusOfMeditation) as? String ?? ""
                                                    if statusOfMediation == ConstantOfApp.kMediationNotCreated{
                                                        rootViewObserver.currentPage = .attendeeDashboard
                                                    } else{
                                                        rootViewObserver.currentPage = .attendeeTabBar
                                                    }
                                                } else{
                                                    
                                                    rootViewObserver.currentPage =  .attendeeManifesto
                                                }
                                            } else {
                                                if let data = value as? (manifestoIndex: Int, howitworkIndex: Int, rootScreen: ERootView) {
                                                    attendeeManifestoObservedObject.currentIndex = data.manifestoIndex
                                                    attendeeManifestoObservedObject.currentHowItsWorkIndex = data.howitworkIndex
                                                    if(data.manifestoIndex > 19){
                                                    } else{
                                                        rootViewObserver.currentPage =  .attendeeManifesto
                                                    }
                                                }
                                            }
                                        } else {
                                            attendeeManifestoObservedObject.currentIndex = 0
                                            rootViewObserver.currentPage = .attendeeManifesto
                                        }
                                    }
                                }else{
                                    rootViewObserver.currentPage = .attendeePariningSetup
                                }
                            }else{
                                attendeeList = true
                            }
                        }
                    }else{
                        attendeeList = true
                    }
                }
            }
        } else {
            if(strSelectedAnswer.localized == "mine as a parent".localized){
                UtilityMethod().saveInDefault(
                    value: ConstantOfApp.kCurrentUserObserver,
                    key: ConstantOfApp.kCurrentUserRole
                )
                self.finishViewActive = true
            }else{
                UtilityMethod().saveInDefault(
                    value: ConstantOfApp.kCurrentUserAttendee,
                    key: ConstantOfApp.kCurrentUserRole
                )
                self.rootViewObserver.currentPage = .attendeePariningSetup
            }
        }
    }
}


//struct WhichDeviceAreYouUsing_Previews: PreviewProvider {
//    static var previews: some View {
//        WhichDeviceAreYouUsing()
//            .multiPreview
//    }
//}
