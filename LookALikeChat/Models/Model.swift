//
//  Model.swift
//  LookALikeChat
//
//  Created by Igor Smirnov on 21/03/2018.
//  Copyright © 2018 Complex Numbers. All rights reserved.
//

import Foundation
import Firebase

protocol Model {

    var id : String { get set }
    var snapshot: [String : Any] { get }

    init?(snapshot: DataSnapshot)
}

func ==(left: Model, right: Model) -> Bool {
    return left.id == right.id
}

