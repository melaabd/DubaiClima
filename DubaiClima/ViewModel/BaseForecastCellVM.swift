//
//  BaseForecastCellVM.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import Foundation


class BaseForecastCellVM {
    
    var dtTxt:String?
    var weather:WeatherElement?
    var temp:String?
    
    init(forecast:Forecast) {
        weather = forecast.weather.first
        temp = forecast.main.temp.format(f: "0.2")
        dtTxt = forecast.dtTxt
    }
}
