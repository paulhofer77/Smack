//
//  AvatarCell.swift
//  Smack
//
//  Created by Paul Hofer on 29.10.18.
//  Copyright © 2018 Hopeli. All rights reserved.
//

import UIKit


enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImagr: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        
    }
    
    func configureCell(index: Int, type: AvatarType) {
        if type == AvatarType.dark {
            avatarImagr.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }else {
            avatarImagr.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
        
    }
    
    
    func setupView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
    
    
    
}
