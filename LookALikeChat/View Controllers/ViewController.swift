//
//  ViewController.swift
//  LookALikeChat
//
//  Created by Igor Smirnov on 23/02/2018.
//  Copyright © 2018 Complex Numbers. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var anonymousLoginButton: UIButton!
    @IBOutlet weak var instructionsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        instructionsLabel.rounded()
        signinButton.rounded()
        registerButton.rounded()
        anonymousLoginButton.rounded()
        NotificationCenter.default.addObserver(forName: .AllUsersLoaded, object: nil, queue: nil) { _ in
            DispatchQueue.main.async {
                self.signinButton.isEnabled = true
                self.registerButton.isEnabled = true
                self.anonymousLoginButton.isEnabled = true
            }
            NotificationCenter.default.removeObserver(self) // ???
        }
        UserModel.shared.auth(name: "Unknown") { success in
            if success {
                UserListModel.instantiate()
            }
        }
    }

    @IBAction func signinButtonAction(_ sender: Any) {
        guard let login = loginTextField.text else { return }
        UserModel.shared.auth(name: login) { success in
            if success {
                self.segueToChannelList()
            }
        }
    }

    @IBAction func registerButtonAction(_ sender: Any) {
    }

    @IBAction func anonymousLoginButtonAction(_ sender: Any) {
        UserModel.shared.auth(name: "Anonumous") { success in
            if success {
                self.segueToChannelList()
            }
        }
    }

    func segueToChannelList() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ChannelListViewController") as? ChannelListViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

}

