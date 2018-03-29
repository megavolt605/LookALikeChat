//
//  UserListModel.swift
//  LookALikeChat
//
//  Created by Igor Smirnov on 29/03/2018.
//  Copyright © 2018 Complex Numbers. All rights reserved.
//

import Foundation
import Firebase

extension Notification.Name {
    static let AllUsersLoaded = Notification.Name(rawValue: "LLAC_AllUsersLoaded")
}

class UserListModel {
    static let shared = UserListModel()

    var users: [UserModel] = []
    let userlistReference = Database.database().reference().child("users")

    static func instantiate() {
        let _ = shared
    }

    init() {
        userlistReference.observe(DataEventType.value) { snapshot in
            guard let data = snapshot.value as? [String: Any] else { return }
            data.keys.forEach { key in
                guard
                    let userData = data[key] as? [String: Any],
                    let user = UserModel(key: key, snapshot: userData)
                else { return }

                self.users.append(user)
            }

            NotificationCenter.default.post(name: .AllUsersLoaded, object: nil)
        }
    }

}

extension Array where Element: UserModel {
    func userBy(id: String) -> Element? {
        return self.filter { return $0.id == id }.first
    }
}
