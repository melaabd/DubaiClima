//
//  DetailsCellVM.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import Foundation

class DetailsCellVM: BaseForecastCellVM {
    
    var cityName:String?
    var minTemp:String?
    var maxTemp:String?
    var dateString:String? {
        return dtTxt?.dateFromString()?.dateStringWithoutTime()
    }
    
    required init(city:City, forecast:Forecast) {
        super.init(forecast: forecast)
        
        cityName = city.name
        minTemp = forecast.main.tempMin.format(f: "0.2")
        maxTemp = forecast.main.tempMax.format(f: "0.2")
    }
    
}
