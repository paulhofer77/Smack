//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Paul Hofer on 28.10.18.
//  Copyright © 2018 Hopeli. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    
    //    MARK: - Variables
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    //MARK: - Outlets
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
    }

    @IBAction func closePressed(_ sender: UIButton) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    //MARK: - Picking Avatar and Setting the Background Color
    @IBAction func pickBAckgroundColorPressed(_ sender: UIButton) {
    }
    
    @IBAction func pickAvatarPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    //MARK: - Register User
    @IBAction func createAccountPressed(_ sender: UIButton) {
        guard let name = userNameTextfield.text , userNameTextfield.text != "" else { return }
        guard let email = emailTextfield.text , emailTextfield.text != "" else { return }
        guard let password = passwordTextfield.text , passwordTextfield.text != "" else { return }
        
//        and with those 2 VAriables the new USer will be Registered in a specific Funtion (e.g. with firebase
        
    }
    
    
    
}
