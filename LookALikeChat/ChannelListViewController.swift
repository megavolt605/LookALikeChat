//
//  ChannelListViewController.swift
//  LookALikeChat
//
//  Created by Igor Smirnov on 23/02/2018.
//  Copyright © 2018 Complex Numbers. All rights reserved.
//

import UIKit
import Firebase

class ChannelListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let channelistReference = Database.database().reference().child("channels")

    var model: [ChannelModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self

//        let channel = channlistReference.childByAutoId()
//        let channelData = ["name": "test2", "owner": "sasha"]
//        channel.setValue(channelData)

        channelistReference.queryOrdered(byChild: "name").observe(DataEventType.childAdded) { snapshot in
            if let data = snapshot.value as? [String : AnyObject] {
                let channelModel = ChannelModel(name: data["name"] as! String, owner: data["owner"] as! String)
                self.model.append(channelModel)
            }
            print(snapshot)
        }

        channelistReference.observe(DataEventType.childChanged) { snapshot in
            print(snapshot)
        }
    }

}

extension ChannelListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChannelListViewControllerCell
        return cell
    }

}

class ChannelListViewControllerCell: UITableViewCell {

}

class ChannelListViewControllerCreateChannelCell: UITableViewCell {

}
