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
    
    static let def = UserDefaults.standard
    
    ///Save Unit
    class func saveUnit(value: Unit){
        def.setValue(value.rawValue, forKey: Keys.temperatureUnitKey)
        def.synchronize()
    }
    
    static var temperatureUnit: Unit? {
        get {
            if let value = def.value(forKey: Keys.temperatureUnitKey) as? String {
                return Unit(rawValue: value)
            } else {
                return Unit.celsius
            }
        }
    }
    
    
    class func clearUserData() {
        def.removeObject(forKey: Keys.temperatureUnitKey)
        def.synchronize()
    }
    
}

