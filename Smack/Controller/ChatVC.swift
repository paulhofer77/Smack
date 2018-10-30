//
//  ChatVC.swift
//  Smack
//
//  Created by Paul Hofer on 28.10.18.
//  Copyright © 2018 Hopeli. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    //    MARK: - Outlets
    
    @IBOutlet weak var typingUsersLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var isTyping = false
    var channelForLabel = "Hardcoded Text"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendButton.isHidden = true
        
        tableview.estimatedRowHeight = 80
        tableview.rowHeight = UITableView.automaticDimension
        
        
        tableview.delegate = self
        tableview.dataSource = self
        
        MessageService.instance.populateChannel(channelName: "TestCell1", channelDescript: "This is Hardcoded Text for the First Test Cell", channelID: "0001")
        MessageService.instance.populateChannel(channelName: "TestCell2", channelDescript: "This is Hardcoded Text for the Second Test Cell", channelID: "0002")
        
        onLoginGetMessage()
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userAndDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
////        SocketService.instance.getMessage { (newMessage) in
//            if newMessage.channelID == MessageService.instance.selectedChannel?.channelId {
////                and if we are logged In
//                MessageService.instance.messages.append(newMessage)
//                self.tableview.reloadData()
//                if MessageService.instance.messages.count > 0 {
//                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
//                    self.tableview.scrollToRow(at: endIndex, at: .bottom, animated: false)
//
//                }
//            }
//        }
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
       
        
        
    }
    
    @objc func userAndDataDidChange(_ notif: Notification) {
        channelNameLabel.text = "Test if Notif works here too"
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
        getMessages()
    }
    
    func updateWithChannel(){
        let channelForLabel = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLabel.text = "#\(channelForLabel)"
    }
    
    func onLoginGetMessage(){
        if MessageService.instance.channels.count > 0 {
            MessageService.instance.selectedChannel = MessageService.instance.channels[0]
            self.updateWithChannel()
        }else {
            self.channelNameLabel.text = "no Channels yet"
        }
    }
    
    func getMessages() {
//        normally we would check at the server if for the channelId specific Messages, here i just hardcode some with the channel Ids from the HArdcoded Channels
//        guard let channelID = MessageService.instance.selectedChannel?.channelId else { return }
//        MessageService.instance.createMessage(message: "First Message", channelid: "0001", userName: "Paul", userAvatar: "dark1", userAvatarColor: "[0.73948557, 0.9875, 0.0957, 1]", id: "00001", timestamp: "30.10.2018")
//        MessageService.instance.createMessage(message: "Second Message", channelid: "0001", userName: "Paul", userAvatar: "dark1", userAvatarColor: "[0.9324, 0.30945, 0.9834, 1]", id: "00002", timestamp: "30.10.2018")
//        MessageService.instance.createMessage(message: "Third Message", channelid: "0002", userName: "Andreja", userAvatar: "dark8", userAvatarColor: "[0.9327, 0.309435, 0.934, 1]", id: "00002", timestamp: "30.10.2018")
        
        tableview.reloadData()
        
//        SocketService.instance.getTypingUser { (typingUser) in
//            guard let channelId = MessageService.instance.selectedChannel?.channelId else {return}
//            var names = ""
//            var numberOfTypers = 0
//
//            for (typingUser, channel) in typingUser {
//                if typingUser != UserDataService.instance.name && channel == channelId {
//                    if names == "" {
//                        names = typingUser
//                    }else {
//                        names = "\(names), \(typingUser)"
//                    }
//                    numberOfTypers += 1
//                }
//            }
        
//            if numberOfTypers > 0 {
////                and if we are logged in
//                var verb = "is"
//                if numberOfTypers > 1 {
//                    verb = "are"
//                }
//                self.typingUsersLabel.text = "\(names) \(verb) typing"
//            }else {
//                self.typingUsersLabel.text = ""
//            }
//        }
        
    }

   
    
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
//        check if somebody is loggedIn
        
        guard let channelID =  MessageService.instance.selectedChannel?.channelId else {return}
        guard let message = messageTextfield.text else { return }
        MessageService.instance.createMessage(message: message, channelid: channelID, userName: "Thomas", userAvatar: "light17", userAvatarColor: "[0.07327, 0.309435, 0.934, 1]", id: "00003", timestamp: "30.10.2018")
        
        print(MessageService.instance.messages)
        self.messageTextfield.text = ""
        self.messageTextfield.resignFirstResponder()
        SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelID)
        
        tableview.reloadData()
        let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
        tableview.scrollToRow(at: endIndex, at: .bottom, animated: false)
        
    }
    
    
    @IBAction func messageTextfieldEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.channelId else {return}
        
        if messageTextfield.text == "" {
            isTyping = false
            sendButton.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
        } else if isTyping == false {
            sendButton.isHidden = false
            SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
            isTyping = true
        }
        
        
    }
    
    
    
    //    MARK: - Table View Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
}
