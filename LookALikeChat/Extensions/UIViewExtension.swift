//
//  LALC+UIView.swift
//  LookALikeChat
//
//  Created by Igor Smirnov on 21/03/2018.
//  Copyright © 2018 Complex Numbers. All rights reserved.
//

import UIKit

extension UIView {

    func rounded() {
        layer.masksToBounds = true
        layer.cornerRadius = 6.0
    }

}
