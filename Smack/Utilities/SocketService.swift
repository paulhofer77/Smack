//
//  SocketService.swift
//  Smack
//
//  Created by Paul Hofer on 30.10.18.
//  Copyright © 2018 Hopeli. All rights reserved.
//
//
//import UIKit
//import SocketIO
//
//class SocketService: NSObject {
//
//    static let instance = SocketService()
//    
//    var manager: SocketManager
//    let socket: SocketIOClient
//    
//    override init() {
//        self.manager = SocketManager(socketURL: URL(string: "here is the BAse URL")!)
//        self.socket = manager.defaultSocket
//        super.init()
//    }
//    
//    //    MARK: - Opening/Closing Socket Connection
////    those 2 Function are called in the AppDelegate
//    
//    func establichConnection(){
//        socket.connect()
//    }
//    
//    func closeConnection(){
//        socket.disconnect()
//    }
//    
//    
//    //    MARK: - Adding a channel via Socket (emit a Object to the Server)
//    
//    func addChannel(channelName: String, channelDescription: String) {
//        
//        socket.emit("newChannel", channelName, channelDescription)
//    
//    }
//    
//    //    MARK: - Getting/Dedection a channel via Socket (on a Object from the Server)
////    this function must be called at the place where it has to change sth - in this case in the channel VC, because, there are the channels presented which will be updated
//    func getChannel() {
//        socket.on("channelCreated") { (dataArray, ack) in
//            
//            guard let channelName = dataArray[0] as? String else { return }
//            guard let channelDescription = dataArray[1] as? String else { return }
//            guard let newchannelId = dataArray[2] as? String else { return }
//            
//            let newChannel = Channel.init(channelTitle: channelName, channelDescription: channelDescription, channelId: newchannelId)
//            MessageService.instance.channels.append(newChannel)
//        }
//    }
//    
//    //    MARK: - Add a message via Socket
//    
//    func AddMessage(messageBody: String, userId: String, channelId: String) {
//        let user = UserDataService.instance
//        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
//    }
//    
//    
//    
//}
