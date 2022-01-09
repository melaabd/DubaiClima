//
//  Utils.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//


import Foundation

typealias CompletionVoid = (()->Void)

/// Utility struct for helper methods used across the app
struct Utility {
    /// Static function for temprature measurement unit based on user's locale settings.
    /// Returns string with three possible values  "imperial", "metric", "Kelvin"
    static func getUserTempUnit() -> String {
        let locale = NSLocale.current as NSLocale
        var tempUnit = "Kelvin"
        if let unitStr = locale.object(forKey: NSLocale.Key(rawValue: Keys.kCFLocaleTemperatureUnitKey)) as? String {
            let localeTempUnit = unitStr.lowercased()
            switch localeTempUnit {
            case "fahrenheit":
                tempUnit = "imperial"
            case "celsius":
                tempUnit = "metric"
            default:
                tempUnit = "Kelvin"
            }
        }
        return tempUnit
    }
    /// Static function for temprature measurement unit symbol based on user's locale settings.
    /// Returns string with three possible values  "℉", "°C", "K"
    static func getUserTempUnitSymbol() -> String {
        let locale = NSLocale.current as NSLocale
        var tempUnit = "K"
        if let unitStr = locale.object(forKey: NSLocale.Key(rawValue: Keys.kCFLocaleTemperatureUnitKey)) as? String {
            let localeTempUnit = unitStr.lowercased()
            switch localeTempUnit {
            case "fahrenheit":
                tempUnit = "℉"
            case "celsius":
                tempUnit = "°C"
            default:
                tempUnit = "K"
            }
        }
        return tempUnit
    }
    
    /// Converts temprature value from Farenheit to Celcius
    /// - Parameter farenheit: double value of temprature in Farenheit
    static func changeFarenheitToCelcius(_ farenheit: Double?) -> Double? {
        guard let farenheit = farenheit else { return nil }
        let celcius = (farenheit - 32.0) * 5.0/9.0
        return celcius
    }
}

/// short cut for calling main thread
/// - Parameters:
///   - after: `Double`
///   - execute: `()->()`
func onMain(after: Double = 0, execute:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + after, execute: execute)
}

/// short cut for calling background thread
/// - Parameters:
///   - after: `Double`
///   - execute: `()->()`
func onGlobal(after: Double = 0, execute:@escaping ()->()) {
    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + after, execute: execute)
}
