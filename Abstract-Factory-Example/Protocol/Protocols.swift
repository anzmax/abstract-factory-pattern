
import UIKit
import UserNotifications

protocol Alert {
    func show(in viewController: UIViewController)
}

protocol Notification {
    func send()
}

protocol NotificationFactory {
    func createAlert(title: String, message: String) -> Alert
    func createNotification(title: String, body: String) -> Notification
}



