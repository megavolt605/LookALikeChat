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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func auth(as name: String, email: String) {
        //try? Firebase.Auth.auth().signOut()
        Firebase.Auth.auth().signInAnonymously { (user, error) in
            guard error == nil else {
                print("Error auth user: \(error!.localizedDescription)")
                return
            }

//            let viewController = ChannelListViewController()
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "ChannelListViewController") as? ChannelListViewController {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }

    @IBAction func authAsSashaAction(_ sender: Any) {
        auth(as: "Sasha", email: "sasha@gmail.com")
    }

    @IBAction func authAsLudaAction(_ sender: Any) {
        auth(as: "Luda", email: "luda@gmail.com")
    }
}

