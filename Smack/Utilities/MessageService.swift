//
//  MessageService.swift
//  Smack
//
//  Created by Paul Hofer on 30.10.18.
//  Copyright © 2018 Hopeli. All rights reserved.
//

import Foundation

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel: Channel?
    var unreadChannels = [String]()
    
    var messages = [Message]()
    
    
    //    MARK: - Funtions fpr Channels
    func findAllChannels() {
//        its a get request from the server so nothing is in the brackets
//        here there is the call to the server to get all channels
//        here is normally a different Notification 
    }
    

    func populateChannel(channelName: String, channelDescript: String, channelID: String) {
        
        let channel = Channel.init(channelTitle: channelName, channelDescription: channelDescript, channelId: channelID)
        channels.append(channel)
        
    }
    
    func clearChannels(){
        channels.removeAll()
    }
    
    
     //    MARK: - Funtions fpr Message
    
    func findAllMessagesForChannel(channelId: String){
        //        its a get request from the server so nothing is in the brackets
        //        here there is the call to the server to get all channels
        //        here is normally a different Notification
    }
    
    //    helper function because i dont have the database
    func createMessage(message: String, channelid: String, userName: String, userAvatar: String, userAvatarColor: String, id: String, timestamp: String){
//        clearMessages()
        let newMessage = Message.init(message: message, userName: userName, channelID: channelid, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timestamp: timestamp)
        messages.append(newMessage)

    }


    
    func clearMessages(){
        messages.removeAll()
    }
    
    
}
