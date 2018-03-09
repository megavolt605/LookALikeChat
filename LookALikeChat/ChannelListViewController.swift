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

        channelistReference.observe(DataEventType.childAdded) { snapshot in
            guard
                let data = snapshot.value as? [String : AnyObject],
                let name = data["name"] as? String,
                let owner = data["owner"] as? String
                else { return }
            let id = snapshot.key
            let channelModel = ChannelModel(id: id, name: name, owner: owner)

            //self.tableView.reloadData()

            self.tableView.beginUpdates()
            self.model.append(channelModel)
            self.tableView.insertRows(at: [IndexPath(row: self.model.count - 1, section: 0)], with: .fade)
            self.tableView.endUpdates()
            print(snapshot)
        }

        channelistReference.observe(DataEventType.childChanged) { snapshot in
            print(snapshot)
            guard
                let data = snapshot.value as? [String : AnyObject],
                let name = data["name"] as? String,
                let owner = data["owner"] as? String
                else { return }

            let id = snapshot.key
            guard let index = (self.model.index { return $0.id == id }) else { return }
            //self.tableView.reloadData()

            self.tableView.beginUpdates()

            var item = self.model[index]
            item.name = name
            item.owner = owner
            self.model[index] = item

            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            self.tableView.endUpdates()
        }

        channelistReference.observe(DataEventType.childRemoved) { snapshot in
            print(snapshot)
            let id = snapshot.key
            guard let index = (self.model.index { return $0.id == id }) else { return }

            self.tableView.beginUpdates()
            self.model.remove(at: index)
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            self.tableView.endUpdates()
        }
    }

}

extension ChannelListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChannelListViewControllerCell
        let item = model[indexPath.row]
        cell.channelNameLabel.text = item.name
        return cell
    }

}

extension ChannelListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = model[indexPath.row]
        channelistReference.child(item.id).removeValue()
    }

}

class ChannelListViewControllerCell: UITableViewCell {
    @IBOutlet weak var channelNameLabel: UILabel!

}

class ChannelListViewControllerCreateChannelCell: UITableViewCell {

}
