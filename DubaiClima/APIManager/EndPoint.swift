//
//  Constants.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import Foundation
enum EndPoint {
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    
    case weather(city:String)
    
    /// return endPoint's path `String`
    private var path : String {
        switch self {
        case .weather(let city):
            return "forecast?q=\(city)"
        }
    }
    
    var url:URL {
        guard let url = URL(string: "\(EndPoint.baseUrl)\(path)&appid=\(Keys.apiKey)&units=imperial") else {fatalError("Invalid Base URL.")}
        return url
    }
}
