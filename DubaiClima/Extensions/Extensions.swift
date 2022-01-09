//
//  DoupleExtension.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import Foundation



extension String {

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
    
    func getTodayWeekDay()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:self) ?? Date()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: date)
        return weekDay
    }
}
extension Double {
    
    /// Returns string for double to required decimal places
    /// - Parameter f: String with required number of decimal places, for  example "0.2" for two decimal places
    func format() -> String {
        return "\(String(format: "%.2f", self)) ℉"
    }
    
    /// Converts temprature value from Farenheit to Celcius
    /// - Parameter farenheit: double value of temprature in Farenheit
    func celciusFormat() -> String {
        let celcius = (self - 32.0) * 5.0/9.0
        return "\(String(format: "%.1f", celcius)) °C"
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
