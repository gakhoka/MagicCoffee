//
//  PushNotifications.swift
//  MagicCoffee
//
//  Created by Giorgi Gakhokidze on 13.02.25.
//

import UserNotifications

class PushNotifications {
    
    func showNotification(_ prepareTime: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Your order is ready! ☕"
        content.body = "Please collect"
        content.sound = .default
        
        let triggerTime = TimeInterval(prepareTime.timeIntervalSinceNow)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(1, triggerTime), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { [weak self] error in
            guard self != nil else { return }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}
