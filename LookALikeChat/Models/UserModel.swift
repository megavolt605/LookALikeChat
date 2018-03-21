//
//  UserModel.swift
//  LookALikeChat
//
//  Created by Igor Smirnov on 21/03/2018.
//  Copyright © 2018 Complex Numbers. All rights reserved.
//

import Foundation
import Firebase

struct UserModel: Model {

    static var shared = UserModel(nick: "Default")
    let userlistReference = Database.database().reference().child("users")

    var id: String
    var nick: String
    var firstName: String?
    var lastName: String?
    var password: String?
    var avatar: URL?
    var avatarImage: UIImage?

    var snapshot: [String : Any] {
        var result: [String : Any] = ["nick": nick]
        result["firstName"] = firstName
        result["lastName"] = lastName
        result["password"] = password
        result["avatar"] = avatar
        return result
    }

    init(nick: String) {
        self.id = "Unknown"
        self.nick = nick
    }

    init?(snapshot: DataSnapshot) {
        guard
            let data = snapshot.value as? [String : Any],
            let nick = data["nick"] as? String
            else { return nil }
        id = snapshot.key
        self.nick = nick
        firstName = data["firstName"] as? String
        lastName = data["lastName"] as? String
        password = data["password"] as? String
        avatar = URL(string: data["avatar"] as? String ?? "")
    }

    func updateFirebase() {
        let query = userlistReference.queryEqual(toValue: nick, childKey: "nick")
        userlistReference.observe(DataEventType.childAdded) { snapshot in
            ///

            return
        }

    }

    func auth(_ callback: @escaping (_ success: Bool) -> Void) {
        Firebase.Auth.auth().signInAnonymously { (user, error) in
            guard error == nil else {
                print("Error auth user: \(error!.localizedDescription)")
                callback(false)
                return
            }
            self.updateFirebase()
            callback(true)
        }
    }

}
