//
//  DoupleExtension.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import Foundation


extension Date {
    /// Returns string for date without time components in formate *YYYY-MM-dd*
    func dateStringWithoutTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: self)
    }
    /// Returns string for time without date components in formate *h:mm a*
    func timeStringWithoutDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
}
extension String {
    /// Returns date for string without time components in formate *YYYY-MM-dd*.
    /// Returns nil if string is not a valid date convertable
    func dateFromString() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "YYYY-MM-dd h:mm a"
        return dateFormatter.date(from: self)
    }
    
    func getDateStringWithTimeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from:self) ?? Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func getTimeStringForDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from:self) ?? Date()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
extension Double {
    
    /// Returns string for double to required decimal places
    /// - Parameter f: String with required number of decimal places, for  example "0.2" for two decimal places
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
