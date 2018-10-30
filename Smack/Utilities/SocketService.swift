//
//  SocketService.swift
//  Smack
//
//  Created by Paul Hofer on 30.10.18.
//  Copyright © 2018 Hopeli. All rights reserved.
//
//
import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    var manager: SocketManager
    let socket: SocketIOClient
    
    override init() {
        self.manager = SocketManager(socketURL: URL(string: "here is the BAse URL")!)
        self.socket = manager.defaultSocket
        super.init()
    }
    
    //    MARK: - Opening/Closing Socket Connection
//    those 2 Function are called in the AppDelegate
    
    func establichConnection(){
        socket.connect()
    }
    
    func closeConnection(){
        socket.disconnect()
    }
    
    
    //    MARK: - Adding a channel via Socket (emit a Object to the Server)
    
    func addChannel(channelName: String, channelDescription: String) {
        
        socket.emit("newChannel", channelName, channelDescription)
    
    }
    
    //    MARK: - Getting/Dedection a channel via Socket (on a Object from the Server)
//    this function must be called at the place where it has to change sth - in this case in the channel VC, because, there are the channels presented which will be updated
    func getChannel() {
        socket.on("channelCreated") { (dataArray, ack) in
            
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let newchannelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel.init(channelTitle: channelName, channelDescription: channelDescription, channelId: newchannelId)
            MessageService.instance.channels.append(newChannel)
        }
    }
    
    //    MARK: - Add a message via Socket
    
    func AddMessage(messageBody: String, userId: String, channelId: String) {
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
    }
    
    //    MARK: - Getting/Dedection a message via Socket (on a Object from the Server)
    
    func getMessage() {
        
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else { return }
            guard let userId = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let messagId = dataArray[6] as? String else { return }
            guard let timestamp = dataArray[7] as? String else { return }
            
            if channelId == MessageService.instance.selectedChannel?.channelId {
//                and check if we are logged in
                
                let newMessage = Message.init(message: messageBody, userName: userName, channelID: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: messagId, timestamp: timestamp)
                MessageService.instance.messages.append(newMessage)
                
            }else {
//               nothing should happen
            }
            
            
        }
    }
    
}
