//
//  AddAttendeeAccountView.swift
//  MrArthur
//
//  Created by Amit Sinha on 22/07/22.
//

import SwiftUI

struct AddAttendeeAccountView: View {
    @StateObject private var observed = Observed()
    @State private var createAttendee = AddAttendeeRequestModel()
    @State private var attendeeName : String = ""
    var fromDashboard: Bool = false
    @State var isValid: Color = .secondaryBlue
    @State var birthDate: Date? = nil
    @State private var strToastMessage = ""
    @State private var attendeeImage = "setupAvatar"
    @State private var showToast = false
    @State private var showPicker = false
    @State var nextButtonEnabled = false
    @State var isMultiLine = false
    // For Loader
    @EnvironmentObject private var loaderObserver: LoaderObserver
    @EnvironmentObject private var rootViewObserver: RootViewObserver
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0){
                    Image(attendeeImage)
                        .resizable()
                        .frame(
                            width: 83.r,
                            height: 83.r
                        )
                        .padding(.bottom, 31.h)
                    
                    GenderRadioButtonGroupView { index in
                        print("selected gender index \(index)")
                        if index == 0{
                            attendeeImage = "setupAvatar"
                        }
                        else if index == 1{
                            attendeeImage = "iconAvatarProfileGirl"
                            
                        }
                        else if index == 2{
                            attendeeImage = "iconAvatarProfileBoy"
                        }
                    }
                    .padding(.bottom, 48.h)
                    
                    TextFieldView(
                        title: "FIRST NAME".localized,
                        fontSize: 18,
                        text: $attendeeName,
                        textColor: .secondaryBlue,
                        isValid: .constant(true),
                        isMultiLine: $isMultiLine,
                        isTextlimitFix: true,
                        onChange: {_ in}
                    )
                    .padding(.bottom, 63.h)
                    
                    CustomDatePickerView(
                        title: "DATE OF BIRTH".localized,
                        date: $birthDate,
                        showPicker: $showPicker
                    )
                    
                }
                
                Spacer(minLength: 16.h)
                
                BlueRoundedButton(
                    "NEXT",
                    width: 170,
                    height: 60
                ) {
                    self.onNext()
                    AmplitudeService.sendEvent(key: .OBS_ADD_UP_2_FILLE_NEXT)
                }
            }
            .padding(.horizontal, 24.w)
            .padding(.vertical, 32.h)
            NavigationLink(
                "",
                destination: AddUpTvScreenEstimateView(),
                isActive: $nextButtonEnabled
            )
            .labelsHidden()
            if showPicker {
                BottomSheetView(isOpen: $showPicker, maxHeight: UIScreen.screenHeight * 0.40) {
                    DatePickerView { date in
                        self.birthDate = date
                        self.showPicker = false
                    } onCancel: {
                        self.showPicker = false
                    }
                }
            }
        }
        .customNavigationViewWithBackCancelWidgit(
            title: "Child identity".localized,
            color: .white,
            showBackButton: fromDashboard,
            lastButtontitle: "Cancel_Head",
            amplitudeEvent: .OBS_ADD_UP_2_FILLE_BACK,
            action: {
                AmplitudeService.sendEvent(key: .OBS_ADD_UP_2_FILLE_CANCEL)
                rootViewObserver.currentPage = .attendeeList
            }
        )
        .background(
            LinearGradient(
                colors: [
                    Color.secondaryRed,
                    Color.lightPink
                ],
                startPoint: .top,
                endPoint: .center
            )
        )
        .toast(
            message: strToastMessage,
            isShowing: $showToast,
            duration: ToastMessage.short
        )
        .edgesIgnoringSafeArea(.all)
    }
    func validateAddAttendeeData()->Bool{
        if(attendeeImage == "setupAvatar"){
            strToastMessage = "Please select gender of child".localized
            showToast = true
            return false
            
        }else if(attendeeName.count == 0){
            strToastMessage = "Please add child name".localized
            showToast = true
            return false
        }else if let birthdate = birthDate{
            if(birthdate < Date()){
                return true
            }else{
                strToastMessage = "Birthdate must be past day".localized
                showToast = true
                return false
            }
        }else{
            strToastMessage = "Please select birthdate of child".localized
            showToast = true
            return false
        }
    }
    
    private func onNext() {
        if(self.validateAddAttendeeData()){
            createAttendee.attendeeName = self.attendeeName
            if(self.attendeeImage == "iconAvatarProfileGirl"){
                createAttendee.gender = "FEMALE"
            }else{
                createAttendee.gender = "MALE"
            }
            createAttendee.subscriptionUUID = UtilityMethod()
                .getValueForKey(
                    key: ConstantOfApp.kUUIDForSubscription
                ) as? String ?? ""
            
            let dateformat = DateFormatter()
            dateformat.dateFormat = "YYYY-MM-dd"
            let birthdate = dateformat.string(from: self.birthDate ?? Date())
            createAttendee.birthDate = birthdate
            UserDefaultsHelper.createAttendee = createAttendee
            nextButtonEnabled = true
        }
    }
}


struct AddAttendeeAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AddAttendeeAccountView()
          //  .multiPreview
    }
}
