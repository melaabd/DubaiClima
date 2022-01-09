//
//  HourForecastCellVM.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import Foundation


class HourForecastCellVM: BaseForecastCellVM {
   
    
    var timeString:String? {
        dtTxt?.getTimeStringForDate()
    }
    
    required override init(forecast: Forecast) {
        super.init(forecast: forecast)
        
    }
}
