import UIKit

class BasicAlert: Alert {
    private var title: String
    private var message: String

    init(title: String, message: String) {
        self.title = title
        self.message = message
    }

    func show(in viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alertController, animated: true)
    }
}

class LocalNotification: Notification {
    private var title: String
    private var body: String

    init(title: String, body: String) {
        self.title = title
        self.body = body
    }

    func send() {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding local notification: \(error)")
            }
        }
    }
}
