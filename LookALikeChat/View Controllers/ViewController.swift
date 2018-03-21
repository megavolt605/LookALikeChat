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
    }

    @IBAction func signinButtonAction(_ sender: Any) {
        guard let login = loginTextField.text else { return }
        auth(as: login)
    }

    @IBAction func registerButtonAction(_ sender: Any) {
    }

    @IBAction func anonymousLoginButtonAction(_ sender: Any) {
        auth(as: "Anonumous")
    }

    func auth(as name: String) {
        UserModel.shared.nick = name
        UserModel.shared.auth { [weak self] success in
            guard let s = self else { return }
            if success {
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                if let viewController = storyboard.instantiateViewController(withIdentifier: "ChannelListViewController") as? ChannelListViewController {
                    s.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
    }

}

