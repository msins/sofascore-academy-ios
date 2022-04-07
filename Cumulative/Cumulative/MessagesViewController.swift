//
//  TableViewController.swift
//  Cumilative
//
//  Created by Marko Sinkovic on 05.04.2022..
//

import UIKit

struct Message: Identifiable, Hashable {
    var id: UUID = UUID()
    var text: String
    var sender: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
}

func createDummyMessages() -> [Message] {
    let senders = ["Marko", "Karlo", "Danijel", "Bruno"]
    
    return (1...100).map {
        return Message(text: "Message \($0)", sender: senders.randomElement()!)
    }
}

class MessagesViewController: UITableViewController {
    
    private var messages = createDummyMessages()
    private var sentBy = Dictionary<String, [Message]>()
    private var sortedSenders = [String]()
    
    private var selectedMessages = Set<Message>()
    
    enum CellIdentifiers {
        static let custom = "custom"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sentBy = Dictionary(grouping: messages, by: { message in message.sender })
        sortedSenders = sentBy.keys.sorted()
        
        view.backgroundColor = .background
        
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.custom)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sortedSenders.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedSenders[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentBy[sortedSenders[section]]!.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.custom) as! MessageTableViewCell
        
        let message = getMessage(indexPath)
        
        cell.bind(
            message: message,
            isSelected: selectedMessages.contains(message)
        )
        
        return cell
    }
    
    override func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if let messageCell = cell as? MessageTableViewCell {
                
                let selectedMessage = getMessage(indexPath)
        
                if selectedMessages.contains(selectedMessage) {
                    messageCell.deselect()
                    selectedMessages.remove(selectedMessage)
                } else {
                    messageCell.select()
                    selectedMessages.insert(selectedMessage)
                }
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func getMessage(_ indexPath: IndexPath) -> Message {
        let messagesBySender = sentBy[sortedSenders[indexPath.section]]
        return messagesBySender![indexPath.row]
    }
}
