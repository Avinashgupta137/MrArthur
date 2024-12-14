//
//  LoginHelper.swift
//  MrArthur
//
//  Created by IPS-169 on 25/07/22.
//

import Foundation
class LoginHelper {
    
    static func loginAPICall(
        withToken:String,
        param:[String:Any],
        completion:@escaping(String?,Bool)->()
    ){
        APIHelper.shared.callAPI(
            URLString: ConstantHttp.observerLoginURL,
            methodName: APICallMethodType.post,
            param: param,
            withToken: withToken
        ) { data in
            completion("",true)
        } fail: { error in
            print("error is = \(error) loginAPICall")
            completion(error,false)
        }
    }
    static func validateAPICall(
        withToken:String,
        param:[String:Any],
        success: @escaping ((Any) -> Void),
        failure: @escaping ((String) -> Void)
    ) {
        ValidateAPICall.validateCode (
                withToken: withToken,
                parameter: param
            ) { errorMsg, response  in
                DispatchQueue.main.async {
                    
                    if((errorMsg ?? "").count == 0){
                        var redirectTo = "NA"
                        if let launchObjResponse = response {
                            UtilityMethod().saveInDefault(
                                value: launchObjResponse.token ?? "",
                                key: ConstantOfApp.kObserverUserToken
                            )
                            
                            UtilityMethod().saveInDefault(
                                value: launchObjResponse.user?.type ?? "",
                                key: ConstantOfApp.kUserType
                            )
                            
                            UtilityMethod().saveInDefault(
                                value: launchObjResponse
                                    .user?
                                    .subscriptionRoleList?
                                    .first?
                                    .subscription?
                                    .uuid ?? "", key: ConstantOfApp.kUUIDForSubscription
                            )
                            if let isCompeleted = launchObjResponse
                                .user?
                                .subscriptionRoleList?
                                .first?
                                .subscription?
                                .subscriptionOnboarding?
                                .done,
                               isCompeleted {
                                success(ERootView.whichDeviceUsing)
                            } else {
                                if let stepList = launchObjResponse.user?
                                    .subscriptionRoleList?
                                    .first?.subscription?
                                    .subscriptionOnboarding?
                                    .stepListJsonb?
                                    .stepList {
                                    let screenName = stepList.map({$0.name })
                                    UtilityMethod().saveInDefault(value:screenName, key: ConstantOfApp.kScreenNameList)
                                    if let index = stepList.firstIndex(where: {$0.updatedAt == nil && $0.name != "QUESTION_DATA_PROCESSING"}) {
                                        redirectTo = stepList[index].name ?? "NA"
                                    } else {
                                        redirectTo = stepList.last?.name ?? "NA"
                                    }
                                }
                                success(self.getRootScreenView(lastStepName: redirectTo))
                            }
                            
                        }
                    } else {
                        failure((errorMsg ?? ConstantOfApp.kErrorDefaultMessage))
                    }
                    
                }
            }
    }
    
    private static func getRootScreenView(lastStepName: String) -> (
        (
            manifestoIndex: Int,
            howitworkIndex: Int,
            rootScreen: ERootView
        )
    ){
        var manifestoIndex = 0
        var howItWorkIndex = 0
        var rootScreen: ERootView = .observerManifesto
        switch lastStepName {
        case "MANIFESTO_YOU_MADE_THE_HARD_PART":
            manifestoIndex = 0
            break
        case  "MANIFESTO_SCREEN_ISSUE_AWARENESS":
            manifestoIndex = 1
            break
        case  "MANIFESTO_MR_ARTHUR_NURSE":
            manifestoIndex = 2
            break
        case  "QUESTION_TIMER_INTRODUCTION":
            manifestoIndex = 3
            break
        case  "QUESTION_MAIN_GOAL":
            manifestoIndex = 4
            break
        case  "QUESTION_WHO_ARE_YOU":
            manifestoIndex = 5
            break
        case  "QUESTION_FAMILY_SCREEN_ARGUMENTS":
            manifestoIndex = 6
            break
        case  "QUESTION_PARENTAL_CONTROL_APP":
            manifestoIndex = 7
            break
        case  "QUESTION_PARENTAL_CONTROL_APP_SATISFACTION":
            manifestoIndex = 8
            break
        case  "QUESTION_INTERLUDE01":
            manifestoIndex = 9
            break
        case  "QUESTION_IS_SCREEN_USE_PROBLEMATIC":
            manifestoIndex = 10
            break
        case  "QUESTION_FEEL_GUILTY":
            manifestoIndex = 11
            break
        case  "QUESTION_IS_KID_AWARE":
            manifestoIndex = 12
            break
        case  "MANIFESTO_WARNING_EMPOWERED_KID":
            manifestoIndex = 13
            break
        case  "MANIFESTO_THERE_IS_HOPE":
            manifestoIndex = 14
            break
        case  "MANIFESTO_BUT_HOW_DOES_IT_WORK":
            manifestoIndex = 15
            break
        case  "MANIFESTO_TIME_REDUCTION_EXPLANATION":
            manifestoIndex = 16
            break
        case  "MANIFESTO_MR_ARTHUR_AI_PROGNOSIS_EXPLANATION":
            manifestoIndex = 17
            break
        case  "MANIFESTO_SMART_TIME_EXPLANATION":
            manifestoIndex = 18
            break
        case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART1":
            manifestoIndex = 19
            break
        case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART2":
            manifestoIndex = 20
            break
        case  "QUESTION_OBSERVER_OWN_SCREEN_USE_OPINION":
            manifestoIndex = 21
            break
        case "QUESTION_DATA_PROCESSING":
            manifestoIndex = 23
            break
        case  "QUESTION_FINAL_SCREEN_GO_TO_LOG_IN":
            manifestoIndex = 24
            break
        case "whichDeviceUsing":
            rootScreen = .whichDeviceUsing
            break
        case "CreateChildAccount":
            rootScreen = .addAttende
            break
        case "Dashboard":
            rootScreen = .observerTabBar
        default:
            break
        }
        return (
            manifestoIndex,
            howItWorkIndex,
            rootScreen
        )
    }
    func attendeeLoginAPICall(param:[String:Any],success: @escaping ((Any) -> Void),
                              failure: @escaping ((String) -> Void)){
        AttendeeLoginAPICall().request { error, attendeeResponse in
            if let attendee = attendeeResponse?.user{
                UserDefaultsHelper.selectedAttendee = attendee
            }
            if((error ?? "").count == 0){
                UtilityMethod().saveInDefault(value: attendeeResponse?.token ?? "", key: ConstantOfApp.kAttendeeUserToken)
                print("Attendee Token = \(UtilityMethod().getValueForKey(key: ConstantOfApp.kAttendeeUserToken))")
                let _ = CurrentUserService.setToken(token: UtilityMethod().getValueForKey(key: ConstantOfApp.kAttendeeUserToken) as? String ?? "")
                DeviceService.registerDevice() { success in }
                
                var redirectTo = "NA"
                if let attendeeObj =  attendeeResponse{
                    if let isCompeleted = attendeeObj
                        .user?.attendeeUserOnboarding?.done,
                       isCompeleted {
                        let statusOfMediation = UtilityMethod().getValueForKey(key: ConstantOfApp.kStatusOfMeditation) as? String ?? ""
                        if(statusOfMediation == ConstantOfApp.kMediationNotCreated){
                            success(getRootAttendeeScreenView(lastStepName: "Dashboard"))
                        }else{
                            success(getRootAttendeeScreenView(lastStepName: "AttendeeTabBar"))
                        }
                    } else {
                        if let stepList = attendeeObj.user?.attendeeUserOnboarding?
                            .stepListJsonb?
                            .stepList {
                            let screenName = stepList.map({$0.name })
                            UtilityMethod().saveInDefault(value:screenName, key: ConstantOfApp.kArrOfAttendeeScreenList)
                            if let index = stepList.firstIndex(where: {$0.updatedAt == nil && $0.name != "QUESTION_DATA_PROCESSING"}) {
                                redirectTo = stepList[index].name ?? "NA"
                            } else {
                                redirectTo = stepList.last?.name ?? "NA"
                            }
                            success(getRootAttendeeScreenView(lastStepName: redirectTo))
                        }
                    }
                    
                } else {
                    failure((error ?? ConstantOfApp.kErrorDefaultMessage))
                }
            } else {
                failure((error ?? ConstantOfApp.kErrorDefaultMessage))
            }
        }
    }
}

private func getRootAttendeeScreenView(lastStepName: String) -> (
    (
        manifestoIndex: Int,
        howitworkIndex: Int,
        rootScreen: ERootView
    )
){
    var manifestoIndex = 0
    var howItWorkIndex = 0
    var rootScreen: ERootView = .attendeeManifesto
    print("Step name = \(lastStepName)")
    switch lastStepName {
    case "MANIFESTO_INTRO_HELLO_AND_FOLLOW_ME":
        manifestoIndex = 0
        break
    case  "MANIFESTO_MR_ARTHUR_IS_YOUR_FRIEND":
        manifestoIndex = 1
        break
    case  "MANIFESTO_MR_ARTHUR_WILL_MAKE_YOU_SMART":
        manifestoIndex = 2
        break
    case  "MANIFESTO_MAKE_THE_FIRST_STEP_AGAINST_TYRANNY":
        manifestoIndex = 3
        break
    case  "MANIFESTO_MR_ARTHUR_WILL_EMPOWER_YOU":
        manifestoIndex = 4
        break
    case  "MANIFESTO_MR_ARTHUR_IS_A_NURSE":
        manifestoIndex = 5
        break
    case  "MANIFESTO_HOW_KID_WILL_MAKE_A_PROPOSAL":
        manifestoIndex = 6
        break
    case  "MANIFESTO_ENJOY_FREE_TIME_WITH_BUDDIES":
        manifestoIndex = 7
        break
    case  "MANIFESTO_LETS_EMBARK":
        manifestoIndex = 8
        break
    case  "QUESTION_TOO_MUCH_TIME_ON_SCREEN":
        manifestoIndex = 9
        break
    case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART1":
        manifestoIndex = 10
        break
    case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART2":
        manifestoIndex = 11
        break
    case  "QUESTION_FAMILY_SCREEN_ARGUMENTS":
        manifestoIndex = 12
        break
    case  "QUESTION_COURAGE_LITTLE_TIME_LEFT":
        manifestoIndex = 13
        break
    case  "QUESTION_WOULD_ACCEPT_ENFORCED_TIME_LIMIT_RULES":
        manifestoIndex = 14
        break
    case  "QUESTION_WOULD_PREFER_EMPOWERMENT_AND_ADVICES":
        manifestoIndex = 15
        break
    case  "QUESTION_ENJOY_AND_LEARN":
        manifestoIndex = 16
        break
    case  "QUESTION_ABOUT_SMART_EDUCATIVE_APPS":
        manifestoIndex = 17
        break
    case  "QUESTION_PERFECT_WELL_DONE":
        manifestoIndex = 18
        break
    case  "QUESTION_DATA_PROCESSING":
        manifestoIndex = 19
        break
    case "CreateChildAccount":
        rootScreen = .addAttende
        break
        
    case "Dashboard":
        rootScreen = .attendeeDashboard
        break
        
    case "AttendeeTabBar":
        rootScreen = .attendeeTabBar
        break
        
    default:
        break
    }
    
    return (
        manifestoIndex,
        howItWorkIndex,
        rootScreen
    )
}
