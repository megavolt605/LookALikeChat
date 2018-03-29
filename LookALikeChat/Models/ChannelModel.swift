//
//  ChannelModel.swift
//  LookALikeChat
//
//  Created by Igor Smirnov on 23/02/2018.
//  Copyright © 2018 Complex Numbers. All rights reserved.
//

import Foundation
import Firebase

struct ChannelModel: Model {

    var id : String
    var name: String
    var owner: UserModel

    init(id: String, name: String, owner: UserModel) {
        self.name = name
        self.owner = owner
        self.id = id
    }

    init?(key: String, snapshot: [String : Any]) {
        guard
            let name = snapshot["name"] as? String,
            let ownerId = snapshot["ownerId"] as? String,
            let owner = UserListModel.shared.users.userBy(id: ownerId)
        else { return nil }

        let id = key

        self = ChannelModel(id: id, name: name, owner: owner)
    }

    var snapshot: [String : Any] {
        return ["name": name, "owner": owner]
    }

}
