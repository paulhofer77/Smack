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
    
    func findAllChannels() {
//        its a get request from the server so nothing is in the brackets
//        here there is the call to the server to get all channels
    }
    
    func populateChannel(channelName: String, channelDescript: String) {
        
        let channel = Channel.init(channelTitle: channelName, channelDescription: channelDescript)
        channels.append(channel)
        
    }
    
    
    
}
