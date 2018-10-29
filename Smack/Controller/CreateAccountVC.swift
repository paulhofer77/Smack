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
    var backgroundColor: UIColor?
    
    //MARK: - Outlets
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    

        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && backgroundColor == nil {
                userImage.backgroundColor = UIColor.lightGray
            }
        }
    }

    @IBAction func closePressed(_ sender: UIButton) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    //MARK: - Picking Avatar and Setting the Background Color
    @IBAction func pickBAckgroundColorPressed(_ sender: UIButton) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        avatarColor = "[\(r), \(g),\(b), 1]"
        backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
//        spinner.isHidden = false
//        spinner.startAnimating()
        
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        UIView.animate(withDuration: 0.2) {
            self.userImage.backgroundColor = self.backgroundColor
//            self.spinner.stopAnimating()
//            self.spinner.isHidden = true
        }
    }
    
    func setupView() {
        spinner.isHidden = true
        userNameTextfield.attributedPlaceholder = NSAttributedString(string: "User Name", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
        emailTextfield.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
        passwordTextfield.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : smackPurplePlaceholder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap () {
        view.endEditing(true)
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
