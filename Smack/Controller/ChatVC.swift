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
        
       
        
        
    }

    
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
//        check if somebody is loggedIn
        
        guard let channelID =  MessageService.instance.selectedChannel?.channelId else {return}
        guard let message = messageTextfield.text else { return }
        MessageService.instance.createMessage(message: message, channelid: channelID, userName: "Thomas", userAvatar: "light17", userAvatarColor: "[0.07327, 0.309435, 0.934, 1]", id: "00003", timestamp: "30.10.2018")
        
        print(MessageService.instance.messages)
        self.messageTextfield.text = ""
        self.messageTextfield.resignFirstResponder()
        
        tableview.reloadData()
        let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
        tableview.scrollToRow(at: endIndex, at: .bottom, animated: false)
        
    }
    
    
    @IBAction func messageTextfieldEditing(_ sender: Any) {
        if messageTextfield.text == "" {
            isTyping = false
            sendButton.isHidden = true
        } else if isTyping == false {
            sendButton.isHidden = false
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
