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
    var temp:Double?
    
    init(forecast:Forecast) {
        weather = forecast.weather.first
        temp = forecast.main?.temp
        dtTxt = forecast.dtTxt
    }
}
