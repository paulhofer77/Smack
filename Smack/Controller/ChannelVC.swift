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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
        
    }
    

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        
        
    }
    

}
