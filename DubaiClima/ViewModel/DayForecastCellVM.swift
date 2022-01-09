//
//  ForecastCellVM.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import Foundation

class DayForecastCellVM {
    
    var day:String?
    var hoursForecastVM:[HourForecastCellVM]?
    
    required init(day:String, forecasts:[Forecast]) {
        self.day = day
        hoursForecastVM = forecasts.map{HourForecastCellVM(forecast: $0)}
    }
}
