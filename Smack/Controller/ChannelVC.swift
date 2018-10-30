//
//  ChannelVC.swift
//  Smack
//
//  Created by Paul Hofer on 28.10.18.
//  Copyright © 2018 Hopeli. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    //    Mark: - Outlet
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    @IBOutlet weak var userImage: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userAndDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelDidChange(_:)), name: NOTIF_CHANNELS_DID_CHANGE, object: nil)
        
        
       self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        
        
//        SocketService.instance.getChannel()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableview.reloadData()
    }

    @objc func userAndDataDidChange(_ notif: Notification) {
        loginButton.setTitle("TEst for NOTIF", for: .normal)
        userImage.image = UIImage(named: "profileDefault")
        tableview.reloadData()
    }
    
    @objc func channelDidChange(_ notif: Notification) {
        tableview.reloadData()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
//        usually check if someone is logged in and then sho the Profile VC
        
//      modal presentation of Profil VC
        let profile = ProfileVC()
        profile.modalPresentationStyle = .custom
        present(profile, animated: true, completion: nil)
        
//        perform Segue here if no User is logged in
//        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        
        
    }
    
    @IBAction func addChannelPressed(_ sender: Any) {
//        including a check if a user is logged in
        let channel = AddChannelVC()
        channel.modalPresentationStyle = .custom
        present(channel, animated: true, completion: nil)
    }
    
    
    
    
    
    //    MARK: - TableView MEthods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
            
        }else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        self.revealViewController()?.revealToggle(animated: true)
    }
    

}
