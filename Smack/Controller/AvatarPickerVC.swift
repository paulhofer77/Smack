//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Paul Hofer on 29.10.18.
//  Copyright © 2018 Hopeli. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    //    MARK: - Variabke
    var avatarType = AvatarType.dark

    //    MARK: - Outklets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    //    MARK: - Collection View Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
            cell.configureCell(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    //    MARK: - Buttons Pressed Action
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = AvatarType.dark
        }else if segmentControl.selectedSegmentIndex == 1 {
            avatarType = AvatarType.light
        }
        collectionView.reloadData()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}










