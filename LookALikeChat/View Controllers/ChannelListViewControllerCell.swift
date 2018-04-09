//
//  ChannelListViewControllerCell.swift
//  LookALikeChat
//
//  Created by Igor Smirnov on 21/03/2018.
//  Copyright © 2018 Complex Numbers. All rights reserved.
//

import UIKit

class ChannelListViewControllerCell: UITableViewCell {
    @IBOutlet weak var channelNameLabel: UILabel!
    
    @IBOutlet weak var channelOwnerLabel: UILabel!

    func setupCell(with model: ChannelModel) {
        channelNameLabel.text = model.name
        channelOwnerLabel.text = model.owner.nick
    }

}

class ChannelListViewControllerCreateChannelCell: UITableViewCell {

}
