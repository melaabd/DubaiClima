//
//  WForecastVM.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import Foundation

/// Binding delegate to connect between VC and VM
protocol BindingVVMDelegate: AnyObject {
    func reloadData()
    func notifyFailure(msg: String)
}

class WForecastVM {
    
    weak var bindingDelegate:BindingVVMDelegate?
    var showProgress: CompletionVoid?
    var hideProgress: CompletionVoid?
    
    var daysForeCastCellsVM:[DayForecastCellVM]?
    var detailsCellVM:DetailsCellVM?
    
    func loadWeatherData() {
        showProgress?()
        Weather.getWeather() { [weak self] weather, errorMsg in
            self?.hideProgress?()
            guard errorMsg == nil else {
                self?.bindingDelegate?.notifyFailure(msg: errorMsg!)
                return
            }
            guard let cityWeather = weather else {
                self?.bindingDelegate?.notifyFailure(msg: "Something went wrong..")
                return
            }
            self?.prepareWeatherData(cityWeather)
        }
    }
    
    private func prepareWeatherData(_ weather: Weather) {
        detailsCellVM = DetailsCellVM(city: weather.city, forecast: weather.list.first!)
        daysForeCastCellsVM =  (weather.list.compactMap { $0.dateString }.removingDuplicates())
            .map { (date) -> DayForecastCellVM in
            let forecasts = weather.list.filter { $0.dateString == date }
            return DayForecastCellVM(day: date, forecasts: forecasts)
        }
        
        bindingDelegate?.reloadData()
    }
}
