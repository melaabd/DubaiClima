//
//  NotificationManager.swift
//  DubaiClima
//
//  Created by melaabd on 1/11/22.
//

import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    
    static let shared = NotificationManager()
    
    /// ask for user permition to send a notification
    /// - Parameter completion: `Bool` for user choice
    func requestAuthorization(completion: @escaping  (Bool) -> Void) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _  in
                completion(granted)
            }
    }
    
    
    /// schedule local notification with custom data
    /// - Parameter details: `DetailsCellVM` a view model to hold forecastdata
    func scheduleNotification(details:DetailsCellVM) {
        let content = UNMutableNotificationContent()
        content.title = "DubaiClima"
        content.body = """
        Weather now in \(details.cityName ?? "Dubai") is \(details.weather?.weatherDescription ?? "Clear Sky")
        with \((Keeper.temperatureUnit == .fahrenheit ?  details.temp?.format() : details.temp?.celciusFormat()) ?? "")
        """
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30.0, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
}
