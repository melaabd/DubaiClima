//
//  BGTaskScheduler.swift
//  DubaiClima
//
//  Created by melaabd on 1/11/22.
//

import UIKit
import BackgroundTasks


// MARK: - implement back ground tasks
extension AppDelegate {
    
    func registerBackgroundTasks() {
        // Use the identifier which represents your needs
        BGTaskScheduler.shared.register(forTaskWithIdentifier: Keys.bgAppRefreshTaskKey, using: nil) { [weak self] (task) in
            task.expirationHandler = {
                task.setTaskCompleted(success: false)
            }
            self?.refreshWeatherData {
                task.setTaskCompleted(success: true)
            }
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        submitBackgroundTasks()
    }
    
    func submitBackgroundTasks() {
        let timeDelay = 10.0
        do {
            let bgRefreshTaskRequest = BGAppRefreshTaskRequest(identifier: Keys.bgAppRefreshTaskKey)
            bgRefreshTaskRequest.earliestBeginDate = Date(timeIntervalSinceNow: timeDelay)
            try BGTaskScheduler.shared.submit(bgRefreshTaskRequest)
            print("Submitted task request")
        } catch {
            print("Failed to submit BGTask")
        }
    }
    
    private func refreshWeatherData(_ completion: CompletionVoid?) {
        Weather.getWeather() {weather, errorMsg in
            guard errorMsg == nil else {
                completion?()
                return
            }
            guard let cityWeather = weather else {
                completion?()
                return
            }
            if let forecast = cityWeather.list.first {
                NotificationManager.shared.scheduleNotification(details: DetailsCellVM(city: cityWeather.city, forecast: forecast))
            }
            onMain {
                DBManager.shared.replaceData(weather: cityWeather)
            }
            completion?()
        }
    }
    
}
