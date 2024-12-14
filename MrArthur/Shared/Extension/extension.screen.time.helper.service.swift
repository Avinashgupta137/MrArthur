//
//  extension.screen.time.helper.service.swift
//  MrArthur
//
//  Created by Reille Sebastien on 04/10/2022.
//

import Foundation

struct QuartersFromSecondModel {
    var quarter1, quarter2, quarter3, quarter4: Int
}

struct QuartersOnGoingModel {
    var second, number, previousQuarterAmountSecond: Int
}

struct DateTimeZoneAndDescriptionModel {
    var description: String
    var dateTimeZone: String
}

class ExtensionScreenTimeHelperService {
    static func getQuartersFromSecond(second: Int) -> QuartersFromSecondModel {
        let ceilQuarter: Double = ceil(Double(second) / 4)
//        print("ceilQuarter: \(ceilQuarter)")
        let intCeil: Int = Int(ceilQuarter)
//        print("intCeil: \(intCeil)")
        let difference: Int = second - (intCeil * 3)
//        print("difference: \(difference)")
        return QuartersFromSecondModel(
            quarter1: intCeil,
            quarter2: intCeil,
            quarter3: intCeil,
            quarter4: difference
        )
    }
    
    static func divideTotalSecondInIntegerParts(totalSecond: Int, listLen: Int) -> Array<Int> {
        let ceilPart: Double = floor(Double(totalSecond) / Double(listLen))
        let intCeilPart: Int = Int(ceilPart)
        var list: Array<Int> = []

        if (totalSecond < listLen) {
            for _ in 1...totalSecond {
                list.append(1)
            }
        } else if (totalSecond % listLen == 0) {
            for _ in 1...listLen {
                list.append(intCeilPart)
            }
        } else {
            let diff = listLen - (totalSecond % listLen)
            for i in 0...listLen - 1 {
                if (i >= diff) {
                    list.append(intCeilPart + 1)
                } else {
                    list.append(intCeilPart)
                }
            }
        }
        return list
    }
    
    static func get15PercentRoundedTo5MinutesFromSecond(second: Int) -> Int {
        let time15Percent: Float = (Float(second) / 100) * 15
//        print("time15Percent: \(time15Percent)")
        let intTime15Percent: Int = Int(floor(time15Percent))
//        print("intTime15Percent: \(intTime15Percent) from \(second) second(s)")
        
        let num5minutesToSecond: Int = 300
        if (intTime15Percent <= num5minutesToSecond) {
            return intTime15Percent
        }

        let intSecondDividedBy300: Int = Int(second / 300)
        var rounded15percent = 300
        for i in 1...intSecondDividedBy300 {
            let numFloor = i * num5minutesToSecond
//            print("numFloor: \(numFloor)")
            let numCeil = (i+1) * num5minutesToSecond
//            print("numCeil: \(numCeil)")
            if (intTime15Percent >= numFloor && intTime15Percent <= numCeil) {
                rounded15percent = numCeil
//                print("rounded15percent: \(rounded15percent)")
                break
            }
        }

        return rounded15percent
    }
    
    static func getDateTimeZoneWithDescriptionFromNow() -> DateTimeZoneAndDescriptionModel {
        let date: Date = Date()
        return DateTimeZoneAndDescriptionModel(
            description: date.description(with: .current),
            dateTimeZone: DateService.getFormatedDateFromNow()
        )
    }
}
