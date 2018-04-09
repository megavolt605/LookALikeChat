//
//  UserModel.swift
//  LookALikeChat
//
//  Created by Igor Smirnov on 21/03/2018.
//  Copyright © 2018 Complex Numbers. All rights reserved.
//

import Foundation
import Firebase

class UserModel: Model, Equatable {

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

    required init?(key: String, snapshot: [String : Any]) {
        guard
            let nick = snapshot["nick"] as? String
            else { return nil }
        id = key
        self.nick = nick
        loadFrom(key: key, snapshot: snapshot)
    }

    func loadFrom(key: String, snapshot: [String : Any]) {
        id = key
        firstName = snapshot["firstName"] as? String
        lastName = snapshot["lastName"] as? String
        password = snapshot["password"] as? String
        avatar = URL(string: snapshot["avatar"] as? String ?? "")
    }

    func updateFirebase() {
        let query = userlistReference.queryOrdered(byChild: "nick").queryEqual(toValue: nick)
        query.observeSingleEvent(of: DataEventType.value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                self.loadFrom(key: snapshot.key, snapshot: data)
            } else {
                let userNode = self.userlistReference.childByAutoId()
                userNode.setValue(self.snapshot)
            }
            //print(self.firstName)
            return
        }

    }

    func auth(name: String, _ callback: @escaping (Bool) -> Void) {
        nick = name
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

    static func ==(lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }
}
