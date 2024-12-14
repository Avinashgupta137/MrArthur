//
//  goal.detail.service.swift
//  MrArthur
//
//  Created by IPS-169 on 20/09/22.
//

import Foundation
import SwiftUI

class GoalDetailService {
    
    static let initImage = "MrArthurIANotHappyAtAllFace"
    static let initMessage = "It’s just not enough... your parents will never accept this !"
    
    static func getTextImageForWorst(
        reducedPercentage: Int, educationIncPercent: Int, forChild: Bool = false
    ) -> (label: String, image: String) {
        
        var rLine = 0
        if(reducedPercentage >= 5 && reducedPercentage <= 10) {
            rLine = 1
        } else if(reducedPercentage > 10 && reducedPercentage <= 20) {
            rLine = 2
        } else if(reducedPercentage > 20 && reducedPercentage <= 30) {
            rLine = 3
        } else if(reducedPercentage > 30 && reducedPercentage <= 40) {
            rLine = 4
        } else if(reducedPercentage > 40 && reducedPercentage <= 50) {
            rLine = 5
        }
        
        var eLine = 0
        if(educationIncPercent >= 5 && educationIncPercent <= 10) {
            eLine = 1
        } else if(educationIncPercent > 10 && educationIncPercent <= 20) {
            eLine = 2
        } else if(educationIncPercent > 20 && educationIncPercent <= 30) {
            eLine = 3
        } else if(educationIncPercent > 30 && educationIncPercent <= 50) {
            eLine = 4
        }
        
        var i = 0
        if rLine <= eLine {
            i = rLine
        } else {
            i = eLine
        }
        let lable = forChild ? getTextByWorstForChild(i) : getTextByWorst(i)
        return (label: lable, image: getImageByWorst(i))
    }
    
    private static func getImageByWorst(_ i: Int) -> String {
        var imgStr = "MrArthurIANotHappyAtAllFace"
        if(i == 1) {
            imgStr = "MrArthurIANotHappyAtAllFace"
        } else if(i == 2) {
            imgStr = "MrArthurIAQuiteHappyFace"
        } else if(i == 3) {
            imgStr = "MrArthurIAHappyFace"
        } else if(i == 4) {
            imgStr = "MrArthurIASuperHappyFace"
        } else if(i == 5) {
            imgStr = "MrArthurIAAstonishedFace"
        }
        return imgStr
    }
    
    private static func getTextByWorst(_ i: Int) -> String {
        var txt = "It’s just not enough... your child can do better"
        if(i == 1) {
            txt = "It’s just not enough... your child can do better"
        } else if(i == 2) {
            txt = "Not bad but not great, maybe a good start ? Or you can refuse and ask him to do a little better"
        } else if(i == 3) {
            txt = "Nice, your child did good, you can accept this goal"
        } else if(i == 4) {
            txt = "Great, that’s a terrific goal, you should proudly accept it !"
        } else if(i == 5) {
            txt = "That’s amazing, your child is ready to make huge efforts, you can be really proud !"
        }
        return txt.localized
    }
    
    private static func getTextByWorstForChild(_ i: Int) -> String {
        var txt = "It’s just not enough... your parents will never accept this !"
        if(i == 1) {
            txt = "It’s just not enough... your parents will never accept this !"
        } else if(i == 2) {
            txt = "Not bad, but probably not enough for your parents, you can do better !"
        } else if(i == 3) {
            txt = "Nice, you are getting there, your parents might accept your goal !"
        } else if(i == 4) {
            txt = "Great, that’s a terrific goal, I bet your parents will proudly accept it !"
        } else if(i == 5) {
            txt = "Wow that’s amazing, you really want to change your life for the best, your parents are going to be so proud of you !"
        }
        return txt.localized
    }
    
    static  func getImageByPercentage(percentage:Int)->Image{
        print("percentage for image = \(percentage)")
        if(percentage >= 5 && percentage <= 10) {
            return  Image("MrArthurIANotHappyAtAllFace")
        } else if(percentage > 10 && percentage <= 20) {
            return Image("MrArthurIAQuiteHappyFace")
        } else if(percentage > 20 && percentage <= 30) {
            return Image("MrArthurIAHappyFace")
        } else if(percentage > 30 && percentage <= 40) {
            return Image("MrArthurIASuperHappyFace")
        } else if(percentage > 40 && percentage <= 50) {
            return Image("MrArthurIAAstonishedFace")
        } else {
            return Image("MrArthurIANotHappyAtAllFace")
        }
    }
    
    static func getTextByPercentage(percentage:Int)->String{
        var txt = "It’s just not enough... your parents will never accept this !"
        if(percentage >= 5 && percentage <= 10) {
            txt = "It’s just not enough... your parents will never accept this !"
        } else if(percentage > 10 && percentage <= 20) {
            txt = "Not bad, but probably not enough for your parents, you can do better !"
        } else if(percentage > 20 && percentage <= 30) {
            txt = "Nice, you are getting there, your parents might accept your goal !"
        } else if(percentage > 30 && percentage <= 40) {
            txt = "Great, that’s a terrific goal, I bet your parents will proudly accept it !"
        } else if(percentage > 40 && percentage <= 50) {
            txt = "Wow that’s amazing, you really want to change your life for the best, your parents are going to be so proud of you !"
        }
        return txt.localized
    }
}
