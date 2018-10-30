//
//  AddChannelVC.swift
//  Smack
//
//  Created by Paul Hofer on 30.10.18.
//  Copyright © 2018 Hopeli. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    
    @IBOutlet weak var nameTextfield: UITextField!
    
    @IBOutlet weak var descriptionTextfield: UITextField!
    
    @IBOutlet weak var backgroundView: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
      
    }

    
    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        backgroundView.addGestureRecognizer(closeTouch)
        
        nameTextfield.attributedPlaceholder = NSAttributedString(string: "Channel Name", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
        descriptionTextfield.attributedPlaceholder = NSAttributedString(string: "Channel Description", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
        
        
    }
    
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createChannelPressed(_ sender: Any) {
        
        guard let channelName = nameTextfield.text , nameTextfield.text != "" else { return }
        guard let channelDescription = descriptionTextfield.text , descriptionTextfield.text != "" else { return }
        let randomeChannelId = arc4random_uniform(1000)
        let channelID = "\(randomeChannelId)"
        print(channelID)
        
//        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription)
//        self.dismiss(animated: true, completion: nil)
        
        MessageService.instance.populateChannel(channelName: channelName, channelDescript: channelDescription, channelID: channelID)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func closeModelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
