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
    
    /// Reference to firebase "channels" database child
    let channelistReference = Database.database().reference().child("channels")

    /// List of channels
    var model: [ChannelModel] = []

//    let storage = Storage.storage()

    override func viewDidLoad() {
        super.viewDidLoad()

        // add changed rows
        channelistReference.observe(DataEventType.childAdded) { snapshot in
            guard let channel = ChannelModel(snapshot: snapshot) else { return }

            // update tableview
            self.tableView.beginUpdates()
            self.model.append(channel)
            self.tableView.insertRows(at: [IndexPath(row: self.model.count - 1, section: 0)], with: .fade)
            self.tableView.endUpdates()
            print(snapshot)
        }

        // reload changed rows
        channelistReference.observe(DataEventType.childChanged) { snapshot in
            print(snapshot)
            guard
                let channel = ChannelModel(snapshot: snapshot),
                let index = (self.model.index { return $0 == channel })
                else { return }

            // update tableview
            self.tableView.beginUpdates()
            self.model[index] = channel
            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            self.tableView.endUpdates()
        }

        // delete rows
        channelistReference.observe(DataEventType.childRemoved) { snapshot in
            print(snapshot)
            let id = snapshot.key
            guard let index = (self.model.index { return $0.id == id }) else { return }

            // update tableview
            self.tableView.beginUpdates()
            self.model.remove(at: index)
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            self.tableView.endUpdates()
        }

        //        let imageRef = storage.reference(forURL: "gs://look-a-like-chat.appspot.com/images/channels/swift.png")
        //        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
        //            print(data?.count)
        //        }

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

    // make table view editable with "delete" button
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = model[indexPath.row]
        channelistReference.child(item.id).removeValue()
    }

}

