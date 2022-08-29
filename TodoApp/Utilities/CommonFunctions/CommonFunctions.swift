//
//  CommonFunctions.swift
//  TodoApp
//
//  Created by Ahmad Qureshi on 12/07/22.
//

import Foundation
class CommonFunctions {
    static func titleHeader(date : String) -> String {
        let dateFormatter = DateFormatter()
        let dateArray = date.components(separatedBy: StringConstant.CommonStrings.space.rawValue)
        dateFormatter.dateFormat = StringConstant.CommonStrings.dateFormat.rawValue
        let currentDateArray = (dateFormatter.string(from: Date())).components(separatedBy: StringConstant.CommonStrings.space.rawValue)
        if !dateArray.isEmpty && !currentDateArray.isEmpty {
            if dateArray[2] == currentDateArray[2] {
                if (dateArray[1] == currentDateArray[1]) && (dateArray[0] == currentDateArray[0]) {
                    return StringConstant.CommonStrings.today.rawValue
                }
                return "\(dateArray[0]) \(dateArray[1])"
            } else {
                return "\(dateArray[0]) \(dateArray[1]) \(dateArray[2])"
            }
        } else {
            return String()
        }
    }
    static func sortDates(dates : inout [String]) {
        dates.sort { (lhs: String, rhs: String) -> Bool in
            let lhsArray = lhs.components(separatedBy: StringConstant.CommonStrings.space.rawValue)
            let rhsArray = rhs.components(separatedBy: StringConstant.CommonStrings.space.rawValue)
            if lhsArray[2] != rhsArray[2] {
                return lhsArray[2] > rhsArray[2]
            }  else if StringConstant.monthDict[lhsArray[1]] != StringConstant.monthDict[rhsArray[1]] {
                return StringConstant.monthDict[lhsArray[1]] ?? 0 > StringConstant.monthDict[rhsArray[1]] ?? 0
            }
            return lhs > rhs
        }
    }
}
