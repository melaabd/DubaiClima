//
//  DoupleExtension.swift
//  DubaiClima
//
//  Created by melaabd on 1/11/22.
//

import Foundation

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
