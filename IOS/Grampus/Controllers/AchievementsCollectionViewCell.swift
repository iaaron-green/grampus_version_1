//
//  AchievementsCollectionViewCell.swift
//  Grampus
//
//  Created by Тимур Кошевой on 6/18/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

class AchievementsCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var _achievementsImageView: UIImageView!
    @IBOutlet weak var _achievementsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _achievementsLabel.text = "1234"
    }
    
}
