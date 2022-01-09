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
    
    required init(forecasts:[Forecast]) {
        self.day = forecasts.first?.dayString
        hoursForecastVM = forecasts.map{HourForecastCellVM(forecast: $0)}
    }
}
