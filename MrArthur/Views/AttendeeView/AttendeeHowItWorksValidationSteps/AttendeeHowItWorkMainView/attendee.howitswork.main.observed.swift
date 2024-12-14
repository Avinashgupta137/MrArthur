//
//  attendee.howitswork.main.observed.swift
//  MrArthur
//
//  Created by Amit Sinha on 02/11/22.
//

import Foundation
import SwiftUI

class AttendeeHowItWorkPageObs:ObservableObject{
    @Published var currentPage : EHowItsWork = .CONGRATS
}

extension AttendeeHowItworkMainView{
    class AttendeeHowItWorkObserver:ObservableObject{
        
    }
}
class AttendeeHowItWorkHelper{
    private static let steps: [String] = [
        "CONGRATS",
        "SUMMARY",
        "MECHANICS_INTRO",
        "EDUCATIONAL_APPS",
        "UNLOCK_ENTERTAINMENT_TIME",
        "DAILY_ADVANCE_ENTERTAINMENT_TIME",
        "SAVE_ENTERTAINMENT_TIME",
        "LOOK_AT_DASHBOARD"
    ]
    static func callAPI(
        stepname: EHowItsWork,
        complition: @escaping (String?, AttendeeHowItsWorkResponse?) -> ()
    ){
        let params: [String: Any] = [
            "stepName": stepname.rawValue
        ]
        APIHelper().callAPI(
            URLString: ConstantHttp.mediationApproveSteps,
            methodName: .post,
            param: params,
            withToken: ConstantOfApp.kAttendeeTokenSend
        ) { data in
            if let model: AttendeeHowItsWorkResponse = try? APIHelper().decodeStickers(from: data) {
                print("AttendeeHowItWorkHelper callAPI", model.uuid ?? "")
                complition(nil, model)
            } else {
                complition(ConstantOfApp.kErrorDefaultMessage, nil)
            }
        } fail: { error in
            complition(error, nil)
        }
    }
    
    static func getNext(currentPage: EHowItsWork) -> EHowItsWork {
        var nextPage: EHowItsWork = currentPage
        if let index = steps.firstIndex(where: {$0 == currentPage.rawValue}) {
            let nextIndex = index + 1
            if nextIndex < steps.count {
                nextPage = EHowItsWork(rawValue: steps[nextIndex]) ?? currentPage
            }
        }
        return nextPage
    }
    
    static func getPrevious(currentPage: EHowItsWork) -> EHowItsWork {
        var previousPage: EHowItsWork = currentPage
        if let index = steps.firstIndex(where: {$0 == currentPage.rawValue}) {
            let previousIndex = index - 1
            if previousIndex < steps.count, previousIndex >= 0 {
                previousPage = EHowItsWork(rawValue: steps[previousIndex]) ?? currentPage
            }
        }
        return previousPage
    }
    static func getCurrentIndex(currentPage: EHowItsWork) -> Int {
        if let index = steps.firstIndex(where: {$0 == currentPage.rawValue}) {
            return index
        }
        return 0
    }
}
