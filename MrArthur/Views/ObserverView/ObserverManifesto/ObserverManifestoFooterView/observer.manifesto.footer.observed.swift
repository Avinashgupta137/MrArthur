//
//  observer.manifesto.footer.observed.swift
//  MrArthur
//
//  Created by IPS-169 on 14/07/22.
//

import Foundation
import UIKit
import Foundation
import SwiftUI


extension ObserverFooterView{
    
    class Observed:ObservableObject{
        
        func getCaseFromScreenName(screenName:String)->EAmplitudeEventKey?{
            var amplitudeKey = EAmplitudeEventKey(rawValue: "")
            switch screenName {
            case "MANIFESTO_YOU_MADE_THE_HARD_PART":
                amplitudeKey = EAmplitudeEventKey.OBS_MANIFESTO_INTRO_NEXT
                break
                
            case "MANIFESTO_HEALTHY_SCREEN_USE":
                amplitudeKey = EAmplitudeEventKey.OBS_MANIFESTO_01_NEXT
                break
                
            case  "MANIFESTO_SCREEN_ISSUE_AWARENESS":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_03_NEXT
                break
                
            case  "MANIFESTO_MR_ARTHUR_NURSE":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_02_NEXT
                break
                
            case  "QUESTION_TIMER_INTRODUCTION":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_INTRO_NEXT
                break
                
            case  "QUESTION_MAIN_GOAL":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_1_NEXT
                break
                
            case  "QUESTION_WHO_ARE_YOU":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_2_NEXT
                break
                
            case  "QUESTION_FAMILY_SCREEN_ARGUMENTS":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_3_NEXT
                break
                
            case  "QUESTION_PARENTAL_CONTROL_APP":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_4_NEXT
                break
                
            case  "QUESTION_PARENTAL_CONTROL_APP_SATISFACTION":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_5_NEXT
                break
                
            case  "QUESTION_INTERLUDE01":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_CARTON_1_NEXT
                break
            case  "QUESTION_IS_SCREEN_USE_PROBLEMATIC":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_6_NEXT
                break
                
            case  "QUESTION_FEEL_GUILTY":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_7_NEXT
                break
                
            case  "QUESTION_IS_KID_AWARE":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_8_NEXT
                break
            case  "MANIFESTO_WARNING_EMPOWERED_KID":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_4_NEXT
                break
            case  "MANIFESTO_THERE_IS_HOPE":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_5_NEXT
                break
            case  "MANIFESTO_BUT_HOW_DOES_IT_WORK":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_6_NEXT
                break
            case  "MANIFESTO_TIME_REDUCTION_EXPLANATION":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_7_NEXT
                break
            case  "MANIFESTO_MR_ARTHUR_AI_PROGNOSIS_EXPLANATION":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_9_NEXT
                break
            case  "MANIFESTO_SMART_TIME_EXPLANATION":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_8_NEXT
                break
            case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART1":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_9_NEXT
                break
            case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART2":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_10_NEXT
                break
            case  "QUESTION_OBSERVER_OWN_SCREEN_USE_OPINION":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_11_NEXT
                break
            case "QUESTION_DATA_PROCESSING":
                amplitudeKey =    EAmplitudeEventKey.OBS_DATA_01_NEXT
                break
                
            case "QUESTION_FINAL_SCREEN_GO_TO_LOG_IN":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_FINISH_NEXT
                break
                
            default:
                
                break
            }
            
            if let key = amplitudeKey {
                return key
            }
            
            print("[ObserverFooterView][getCaseFromScreenName] there is no key for this screen name \(screenName)")
            
            return nil
        }
        
        func getCaseFromBackScreenName(screenName:String)->EAmplitudeEventKey?{
            var amplitudeKey = EAmplitudeEventKey(rawValue: "")
            switch screenName {
            case "MANIFESTO_YOU_MADE_THE_HARD_PART":
                amplitudeKey = EAmplitudeEventKey.OBS_MANIFESTO_INTRO_BACK
                break
                
            case "MANIFESTO_HEALTHY_SCREEN_USE":
                amplitudeKey = EAmplitudeEventKey.OBS_MANIFESTO_01_BACK
                break
                
            case  "MANIFESTO_SCREEN_ISSUE_AWARENESS":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_03_BACK
                break
                
            case  "MANIFESTO_MR_ARTHUR_NURSE":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_02_BACK
                break
                
            case  "QUESTION_TIMER_INTRODUCTION":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_INTRO_BACK
                break
                
            case  "QUESTION_MAIN_GOAL":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_1_BACK
                break
                
            case  "QUESTION_WHO_ARE_YOU":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_2_BACK
                break
                
            case  "QUESTION_FAMILY_SCREEN_ARGUMENTS":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_3_BACK
                break
                
            case  "QUESTION_PARENTAL_CONTROL_APP":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_4_BACK
                break
                
            case  "QUESTION_PARENTAL_CONTROL_APP_SATISFACTION":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_5_BACK
                break
                
            case  "QUESTION_INTERLUDE01":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_CARTON_1_BACK
                break
                
            case  "QUESTION_IS_SCREEN_USE_PROBLEMATIC":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_6_BACK
                break
                
            case  "QUESTION_FEEL_GUILTY":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_7_BACK
                break
                
            case  "QUESTION_IS_KID_AWARE":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_8_BACK
                break
                
            case  "MANIFESTO_WARNING_EMPOWERED_KID":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_4_BACK
                break
                
            case  "MANIFESTO_THERE_IS_HOPE":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_5_BACK
                break
                
            case  "MANIFESTO_BUT_HOW_DOES_IT_WORK":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_6_BACK
                break
                
            case  "MANIFESTO_TIME_REDUCTION_EXPLANATION":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_7_BACK
                break
                
            case  "MANIFESTO_MR_ARTHUR_AI_PROGNOSIS_EXPLANATION":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_9_BACK
                break
                
            case  "MANIFESTO_SMART_TIME_EXPLANATION":
                amplitudeKey =    EAmplitudeEventKey.OBS_MANIFESTO_8_BACK
                break
                
            case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART1":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_9_BACK
                break
                
            case  "QUESTION_MOST_PROBLEMATIC_DEVICE_PART2":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_10_BACK
                break
                
            case  "QUESTION_OBSERVER_OWN_SCREEN_USE_OPINION":
                amplitudeKey =    EAmplitudeEventKey.OBS_QT_11_BACK
                break
                
            case "QUESTION_DATA_PROCESSING":
                amplitudeKey =    EAmplitudeEventKey.OBS_DATA_02_BACK
                break

            default:
                break
            }
            if let key = amplitudeKey {
                return key
            }
            
            print("[ObserverFooterView][getCaseFromBackScreenName] there is no key for this screen name \(screenName)")
            
            return nil
        }
        
    }
}
