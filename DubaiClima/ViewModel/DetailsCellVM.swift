//
//  DetailsCellVM.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import Foundation

class DetailsCellVM: BaseForecastCellVM {
    
    var cityName:String?
    var minTemp:Double?
    var maxTemp:Double?
    
    required init(city:City, forecast:Forecast) {
        super.init(forecast: forecast)
        
        cityName = city.name
        minTemp = forecast.main.tempMin
        maxTemp = forecast.main.tempMax
    }
    
}
