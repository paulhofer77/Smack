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
        loginButton.setTitle("TEst for NOTIF", for: .normal)
        userImage.image = UIImage(named: "profileDefault")
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
//        usually check if someone is logged in and then sho the Profile VC
        
//      modal presentation of 
        let profile = ProfileVC()
        profile.modalPresentationStyle = .custom
        present(profile, animated: true, completion: nil)
        
//        perform Segue here if no User is logged in
//        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        
        
    }
    

}
