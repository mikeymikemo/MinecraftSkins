//
//  SkinCollectionViewCell.swift
//  MCSkins
//
//  Created by Michael Montoya on 1/30/17.
//  Copyright © 2017 Michael Montoya. All rights reserved.
//

import UIKit

class SkinCollectionViewCell: UICollectionViewCell {
    
    
    weak var delegate: CollectionViewCellDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var skinNameTextField: UILabel!
    
    func updateWith(skin: Skin) {
        
        self.imageView.image = skin.image
        
        self.skinNameTextField.text = skin.name
    }
}
