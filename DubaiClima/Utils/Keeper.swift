//
//  Keeper.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import Foundation

enum Unit: String, CaseIterable {
    case celsius
    case fahrenheit
}

class Keeper: NSObject {
    
    // shared instance of userdefaults
    static let def = UserDefaults.standard
    
    ///Save Unit
    class func saveUnit(value: Unit){
        def.setValue(value.rawValue, forKey: Keys.temperatureUnitKey)
        def.synchronize()
    }
    
    // return value from userdefault with casting
    static var temperatureUnit: Unit? {
        get {
            if let value = def.value(forKey: Keys.temperatureUnitKey) as? String {
                return Unit(rawValue: value)
            } else {
                return Unit.celsius
            }
        }
    }
    
    
    /// clear userdefaults keys
    class func clearUserData() {
        def.removeObject(forKey: Keys.temperatureUnitKey)
        def.synchronize()
    }
    
}

