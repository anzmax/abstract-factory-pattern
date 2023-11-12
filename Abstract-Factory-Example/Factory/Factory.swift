import UIKit

class BasicNotificationFactory: NotificationFactory {

    func createAlert(title: String, message: String) -> Alert {
        return BasicAlert(title: title, message: message)
    }

    func createNotification(title: String, body: String) -> Notification {
        return LocalNotification(title: title, body: body)
    }
}
