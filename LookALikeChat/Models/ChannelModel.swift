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
    var owner: String

    init(id: String, name: String, owner: String) {
        self.name = name
        self.owner = owner
        self.id = id
    }

    init?(snapshot: DataSnapshot) {
        guard
            let data = snapshot.value as? [String : Any],
            let name = data["name"] as? String,
            let owner = data["owner"] as? String
            else { return nil }

        let id = snapshot.key
        self = ChannelModel(id: id, name: name, owner: owner)
    }

    var snapshot: [String : Any] {
        return ["name": name, "owner": owner]
    }

}
