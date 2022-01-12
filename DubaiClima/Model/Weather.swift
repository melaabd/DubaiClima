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
        
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            cod = try container.decode(String.self, forKey: .cod)
            message = try container.decode(Int.self, forKey: .message)
            cnt = try container.decode(Int.self, forKey: .cnt)
            city = try container.decode(City.self, forKey: .city)
            let forecastArray = try container.decode([Forecast].self, forKey: .list)
            list.append(objectsIn: forecastArray)
        } catch let jsonError as NSError {
            print("parsing issue with Weather Model: - \(jsonError.localizedDescription)")
        }
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
    @objc dynamic var population, timezone,sunrise, sunset : Int
}

// MARK: - Coord
class Coord: Object, Codable {
    @objc dynamic var lat:Double
    @objc dynamic var lon: Double
}

// MARK: - List
class Forecast: Object, Codable {
    
    @objc dynamic var dt: Int = 0
    @objc dynamic var main: Main? = nil
    let weather = List<WeatherElement>()
    @objc dynamic var clouds: Clouds? = nil
    @objc dynamic var wind: Wind? = nil
    @objc dynamic var visibility = 0
    @objc dynamic var dtTxt: String = ""
    
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
        case dt, main, weather, clouds, wind, visibility
        case dtTxt = "dt_txt"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            dtTxt = try container.decode(String.self, forKey: .dtTxt)
            dt = try container.decode(Int.self, forKey: .dt)
            main = try container.decode(Main.self, forKey: .main)
            clouds = try container.decode(Clouds.self, forKey: .clouds)
            wind = try container.decode(Wind.self, forKey: .wind)
            visibility = try container.decode(Int.self, forKey: .visibility)
            let weatherArray = try container.decode([WeatherElement].self, forKey: .weather)
            weather.append(objectsIn: weatherArray)
        } catch let jsonError as NSError {
            print("parsing issue with Forecast Model: - \(jsonError.localizedDescription)")
        }
    }
}

// MARK: - Clouds
class Clouds: Object, Codable {
    @objc dynamic var all: Int
}

// MARK: - MainClass
class Main:Object, Codable {
    @objc dynamic var temp = 0.0, feelsLike = 0.0, tempMin = 0.0, tempMax: Double = 0.0
    @objc dynamic var pressure = 0, seaLevel = 0, grndLevel = 0, humidity: Int = 0
    @objc dynamic var tempKf: Double = 0.0

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
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            temp = try container.decode(Double.self, forKey: .temp)
            feelsLike = try container.decode(Double.self, forKey: .feelsLike)
            tempMin = try container.decode(Double.self, forKey: .tempMin)
            tempMax = try container.decode(Double.self, forKey: .tempMax)
            tempKf = try container.decode(Double.self, forKey: .tempKf)
            pressure = try container.decode(Int.self, forKey: .pressure)
            seaLevel = try container.decode(Int.self, forKey: .seaLevel)
            grndLevel = try container.decode(Int.self, forKey: .grndLevel)
            humidity = try container.decode(Int.self, forKey: .humidity)
            
        } catch let jsonError as NSError {
            print("parsing issue with Main Model: - \(jsonError.localizedDescription)")
        }
    }
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
