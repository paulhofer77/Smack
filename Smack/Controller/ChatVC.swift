//
//  ChatVC.swift
//  Smack
//
//  Created by Paul Hofer on 28.10.18.
//  Copyright © 2018 Hopeli. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //    MARK: - Outlets
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    @IBOutlet weak var messageTextfield: UITextField!
    
    var channelForLabel = "Hardcoded Text"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        MessageService.instance.createMessage(message: "First Message", channelid: "0001", userName: "Paul", userAvatar: "dark1", userAvatarColor: "[0.73948557, 0.9875, 0.0957, 1]", id: "00001", timestamp: "30.10.2018")
        MessageService.instance.createMessage(message: "Second Message", channelid: "0001", userName: "Paul", userAvatar: "dark1", userAvatarColor: "[0.9324, 0.30945, 0.9834, 1]", id: "00002", timestamp: "30.10.2018")
        MessageService.instance.createMessage(message: "Third Message", channelid: "0002", userName: "Andreja", userAvatar: "dark8", userAvatarColor: "[0.9327, 0.309435, 0.934, 1]", id: "00002", timestamp: "30.10.2018")
       
        
        
    }

    
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
//        check if somebody is loggedIn
        
        guard let channelID =  MessageService.instance.selectedChannel?.channelId else {return}
        guard let message = messageTextfield.text else { return }
        MessageService.instance.createMessage(message: message, channelid: channelID, userName: "Thomas", userAvatar: "light17", userAvatarColor: "[0.07327, 0.309435, 0.934, 1]", id: "00003", timestamp: "30.10.2018")
        
        print(MessageService.instance.messages)
        self.messageTextfield.text = ""
        self.messageTextfield.resignFirstResponder()
        
        
        
    }
    
    
}
