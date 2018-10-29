//
//  ChannelVC.swift
//  Smack
//
//  Created by Paul Hofer on 28.10.18.
//  Copyright © 2018 Hopeli. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    //    Mark: - Outlet
    
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    @IBOutlet weak var userImage: CircleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userAndDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
       self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        
    }
    

    @objc func userAndDataDidChange(_ notif: Notification) {
        loginButton.setTitle("Test for Notif", for: .normal)
        userImage.image = UIImage(named: "dark1")
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        
        
    }
    

}
