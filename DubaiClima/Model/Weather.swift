//
//  Weather.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import Foundation

typealias WeatherAPICompletion = ((_ weather: Weather?, _ errorMsg:String?) -> Void)?

// MARK: - Weather
struct Weather: Codable {
    var cod: String
    var message, cnt: Int
    var list: [Forecast]
    var city: City
    
    static func getWeather(cityName:String = "Dubai", completion: WeatherAPICompletion = nil) {
        /// endpoint instance city
        let endpoint = EndPoint.weather(city: cityName)
        /// get the task for city weather
        let task = URLSession.shared.weatherTask(with: endpoint.url) { weather, error in
            completion?(weather, error)
        }
        task.resume()
    }
}

// MARK: - City
struct City: Codable {
    var id: Int?
    var name: String?
    var coord: Coord?
    var country: String?
    var population, timezone, sunrise, sunset: Int?
}

// MARK: - Coord
struct Coord: Codable {
    var lat, lon: Double
}

// MARK: - List
struct Forecast: Codable {
    var dt: Int
    var main: MainClass
    var weather: [WeatherElement]
    var clouds: Clouds
    var wind: Wind
    var visibility, pop: Int
    var sys: Sys
    var dtTxt: String
    var dateString:String? {
        return dtTxt.getDateStringWithTimeFormat()
    }
    
    var timeString:String? {
        return dtTxt.getTimeStringForDate()
    }
    
    var dayString:String? {
        return dateString?.getTodayWeekDay()
    }
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    var all: Int?
}

// MARK: - MainClass
struct MainClass: Codable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, seaLevel, grndLevel, humidity: Int?
    var tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Sys
struct Sys: Codable {
    var pod: Pod?
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    var id: Int?
    var main: MainEnum?
    var weatherDescription: Description?
    var icon: Icon?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum Icon: String, Codable {
    case the01D = "01d"
    case the01N = "01n"
    case the02N = "02n"
    case the03N = "03n"
    case the04N = "04n"
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

// MARK: - Wind
struct Wind: Codable {
    var speed: Double?
    var deg: Int?
    var gust: Double?
}
