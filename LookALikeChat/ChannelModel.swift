//
//  ChannelModel.swift
//  LookALikeChat
//
//  Created by Igor Smirnov on 23/02/2018.
//  Copyright © 2018 Complex Numbers. All rights reserved.
//

import Foundation

struct ChannelModel {

    var id : String
    var name: String
    var owner: String

    init(id: String, name: String, owner: String) {
        self.name = name
        self.owner = owner
        self.id = id
    }

    init(name: String, owner: String) {
        self.name = name
        self.owner = owner
        self.id = UUID().uuidString
    }

}
