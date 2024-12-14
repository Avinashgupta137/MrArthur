//
//  AttendeeManifestoFooterView  + Observed.swift
//  MrArthur
//
//  Created by IPS-169 on 29/07/22.
//

import Foundation
import SwiftUI
extension AttendeeMaifestoFooterView{
    
    class Observed:ObservableObject{
        @AppStorage("screenno", store: UserDefaults(suiteName: "group.com.mrarthur.parental")) var screenno : Int = 0
        @AppStorage("arrOFAttendeeQuestion", store: UserDefaults(suiteName: "group.com.mrarthur.parental")) var arrofAttendeeQuestiondata : Data =  Data()
        
        @Published var onbordingresponse = OnbordingResponseModel()
        
        var arrOfScreename = UtilityMethod().getValueForKey(key: ConstantOfApp.kScreenNameList) as? [String] ?? [String]()
        
        var opacityValue=0.0;
        func getopacityValue() -> Double {
            if screenno == 0 {
                opacityValue = 0.0 ;
            } else{
                opacityValue = 1.0 ;
            }
            return opacityValue;
        }
        
        func fetchLatestArrOFAttendeeQuestion()->[[String:Any]]{
            if let arrofQuestion = APIHelper.dataToJSON(data: arrofAttendeeQuestiondata) as? [[String:Any]]{
                return arrofQuestion
            }else{
                return [[String:Any]]()
            }
        }
        
        func getCaseFromScreenName(screenName:String)->EAmplitudeEventKey?{
            var amplitudeKey = EAmplitudeEventKey(rawValue: "")
            switch screenName {
               
            case "MANIFESTO_INTRO_HELLO_AND_FOLLOW_ME":
                amplitudeKey = EAmplitudeEventKey.ATT_START_INTRO_1_NEXT
                break
                
            case  "MANIFESTO_MR_ARTHUR_IS_YOUR_FRIEND":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_1_NEXT
                break
                
            case  "MANIFESTO_MR_ARTHUR_WILL_MAKE_YOU_SMART":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_2_NEXT
                break
                
            case "MANIFESTO_MAKE_THE_FIRST_STEP_AGAINST_TYRANNY":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_3_NEXT
                break
                
            case  "MANIFESTO_MR_ARTHUR_WILL_EMPOWER_YOU":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_4_NEXT
                break
                
            case  "MANIFESTO_MR_ARTHUR_IS_A_NURSE":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_5_NEXT
                break
                
            case  "MANIFESTO_HOW_KID_WILL_MAKE_A_PROPOSAL":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_6_NEXT
                break
                
            case  "MANIFESTO_ENJOY_FREE_TIME_WITH_BUDDIES":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_7_NEXT
                break
                
            case  "MANIFESTO_LETS_EMBARK":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_8_NEXT
                break
                
            case  "QUESTION_TOO_MUCH_TIME_ON_SCREEN":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_1_NEXT
                break
                
            case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART1":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_2_NEXT
                break
            case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART2":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_3_NEXT
                break
                
            case  "QUESTION_FAMILY_SCREEN_ARGUMENTS":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_4_NEXT
                break
                
            case  "QUESTION_COURAGE_LITTLE_TIME_LEFT":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_CARTON_1_NEXT
                break
            case  "QUESTION_WOULD_ACCEPT_ENFORCED_TIME_LIMIT_RULES":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_5_NEXT
                break
            case  "QUESTION_WOULD_PREFER_EMPOWERMENT_AND_ADVICES":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_6_NEXT
                break
            case  "QUESTION_ENJOY_AND_LEARN":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_7_NEXT
                break
            case  "QUESTION_ABOUT_SMART_EDUCATIVE_APPS":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_8_NEXT
                break
            case  "QUESTION_PERFECT_WELL_DONE":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_CARTON_2_NEXT
                break
            case  "QUESTION_DATA_PROCESSING":
                amplitudeKey =    EAmplitudeEventKey.ATT_DATA_1_NEXT
                break

            default:
               
            break
            }
  
            if let key = amplitudeKey {
                return key
            }
            
            print("[AttendeeFooterView][getCaseFromScreenName] there is no key for this screen name \(screenName)")
            
            return nil
        }
        
        
        func getCaseFromScreenNameForBackBtn(screenName:String)->EAmplitudeEventKey?{
            var amplitudeKey = EAmplitudeEventKey(rawValue: "")
            switch screenName {
               
            case "MANIFESTO_INTRO_HELLO_AND_FOLLOW_ME":
                amplitudeKey = EAmplitudeEventKey.ATT_START_INTRO_1_BACK
                break
            case  "MANIFESTO_MR_ARTHUR_IS_YOUR_FRIEND":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_1_BACK
                break
            case  "MANIFESTO_MR_ARTHUR_WILL_MAKE_YOU_SMART":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_2_BACK
                break
            case  "MANIFESTO_MAKE_THE_FIRST_STEP_AGAINST_TYRANNY":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_3_BACK
                break
            case  "MANIFESTO_MR_ARTHUR_WILL_EMPOWER_YOU":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_4_BACK
                break
            case  "MANIFESTO_MR_ARTHUR_IS_A_NURSE":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_5_BACK
                break
            case  "MANIFESTO_HOW_KID_WILL_MAKE_A_PROPOSAL":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_6_BACK
                break
            case  "MANIFESTO_ENJOY_FREE_TIME_WITH_BUDDIES":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_7_BACK
                break
            case  "MANIFESTO_LETS_EMBARK":
                amplitudeKey =    EAmplitudeEventKey.ATT_MANIFESTO_8_BACK
                break
            case  "QUESTION_TOO_MUCH_TIME_ON_SCREEN":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_1_BACK
                break
            case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART1":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_2_BACK
                break
            case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART2":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_3_BACK
                break
            case  "QUESTION_FAMILY_SCREEN_ARGUMENTS":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_4_BACK
                break
            case  "QUESTION_COURAGE_LITTLE_TIME_LEFT":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_CARTON_1_NEXT
                break
            case  "QUESTION_WOULD_ACCEPT_ENFORCED_TIME_LIMIT_RULES":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_5_BACK
                break
            case  "QUESTION_WOULD_PREFER_EMPOWERMENT_AND_ADVICES":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_6_BACK
                break
            case  "QUESTION_ENJOY_AND_LEARN":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_7_BACK
                break
            case  "QUESTION_ABOUT_SMART_EDUCATIVE_APPS":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_8_BACK
                break
            case  "QUESTION_PERFECT_WELL_DONE":
                amplitudeKey =    EAmplitudeEventKey.ATT_QT_CARTON_2_BACK
                break
                
            default:
               
            break
            }
  
            if let key = amplitudeKey {
                return key
            }
            
            print("[AttendeeFooterView][getCaseFromScreenName] there is no key for this screen name \(screenName)")
            
            return nil
        }
        
    }
}
