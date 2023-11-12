import UIKit

class ViewController: UIViewController {

    var factory: NotificationFactory = BasicNotificationFactory()
    
    lazy var alertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show notification", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(showAlertButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        requestNotificationPermission()
        UNUserNotificationCenter.current().delegate = self
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(alertButton)
    }
    
    private func setupConstraints() {
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    //request permission to send local notifications to the user
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permission to send notifications has been received.")
            } else if let error = error {
                print("Error requesting permission to send notifications: \(error)")
            }
        }
    }

    @objc func showAlertButtonTapped() {
        let alert = factory.createAlert(title: "Attention", message: "This is an example of an abstract factory.")
        alert.show(in: self)
        
        let notification = factory.createNotification(title: "Hello", body: "This is a local notification.")
        notification.send()
    }
}

extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //show a notification even when the application is in the foreground
        completionHandler([.banner, .list, .sound])
    }
}
