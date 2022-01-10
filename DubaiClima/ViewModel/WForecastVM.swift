//
//  WForecastVM.swift
//  DubaiClima
//
//  Created by melaabd on 1/9/22.
//

import Foundation
import RealmSwift

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
        if let cityWeather = DBManager.shared.fetchData() {
            prepareWeatherData(cityWeather)
            loadRemoteWeatherData(false)
        } else {
            loadRemoteWeatherData()
        }
    }
    
    private func loadRemoteWeatherData(_ shouldShowProgress:Bool = true) {
        shouldShowProgress ? showProgress?() : nil
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
            onMain {
                DBManager.shared.replaceData(weather: cityWeather)
            }
        }
    }
    
    private func prepareWeatherData(_ weather: Weather) {
        detailsCellVM = DetailsCellVM(city: weather.city, forecast: weather.list.first!)
        daysForeCastCellsVM =  (weather.list.compactMap { $0.dateString }.removingDuplicates())
            .map { (date) -> DayForecastCellVM in
                let forecasts = weather.list.filter { $0.dateString == date }
                return DayForecastCellVM(forecasts: Array(forecasts))
            }
        
        bindingDelegate?.reloadData()
    }
}
