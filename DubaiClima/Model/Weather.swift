//
//  Weather.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import Foundation
import RealmSwift

typealias WeatherAPICompletion = ((_ weather: Weather?, _ errorMsg:String?) -> Void)?

// MARK: - Weather
class Weather: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var cod: String?
    @objc dynamic var message:Int = 0
    @objc dynamic var cnt: Int = 0
    @objc dynamic var city: City?
    let list = List<Forecast>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cod = try container.decode(String.self, forKey: .cod)
        message = try container.decode(Int.self, forKey: .message)
        cnt = try container.decode(Int.self, forKey: .cnt)
        city = try container.decode(City.self, forKey: .city)
        let forecastArray = try container.decode([Forecast].self, forKey: .list)
        list.append(objectsIn: forecastArray)
    }
    
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
class City: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var coord: Coord? = nil
    @objc dynamic var country: String
    @objc dynamic var population: Int
    @objc dynamic var timezone: Int
    @objc dynamic var sunrise: Int
    @objc dynamic var sunset: Int
    
}

// MARK: - Coord
class Coord: Object, Codable {
    @objc dynamic var lat:Double
    @objc dynamic var lon: Double
}

// MARK: - List
class Forecast: Object, Codable {
    
    @objc dynamic var dt: Int = 0
    @objc dynamic var main: MainClass? = nil
    @objc dynamic var clouds: Clouds? = nil
    @objc dynamic var wind: Wind? = nil
    @objc dynamic var visibility = 0, pop: Int = 0
    @objc dynamic var sys: Sys? = nil
    @objc dynamic var dtTxt: String = ""
    let weather = List<WeatherElement>()
    
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
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dtTxt = try container.decode(String.self, forKey: .dtTxt)
        dt = try container.decode(Int.self, forKey: .dt)
        main = try container.decode(MainClass.self, forKey: .main)
        clouds = try container.decode(Clouds.self, forKey: .clouds)
        wind = try container.decode(Wind.self, forKey: .wind)
        visibility = try container.decode(Int.self, forKey: .visibility)
        pop = try container.decode(Int.self, forKey: .pop)
        sys = try container.decode(Sys.self, forKey: .sys)
        let weatherArray = try container.decode([WeatherElement].self, forKey: .weather)
        weather.append(objectsIn: weatherArray)
    }
}

// MARK: - Clouds
class Clouds: Object, Codable {
    @objc dynamic var all: Int
}

// MARK: - MainClass
class MainClass:Object, Codable {
    @objc dynamic var temp, feelsLike, tempMin, tempMax: Double
    @objc dynamic var pressure, seaLevel, grndLevel, humidity: Int
    @objc dynamic var tempKf: Double

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
class Sys:Object, Codable {
    @objc dynamic var pod: String = ""
}

// MARK: - WeatherElement
class WeatherElement:Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var main:String = ""
    @objc dynamic var weatherDescription:String = ""
    @objc dynamic var icon:String = ""
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
class Wind: Object, Codable {
    @objc dynamic var speed: Double
    @objc dynamic var deg: Int
    @objc dynamic var gust: Double
}
