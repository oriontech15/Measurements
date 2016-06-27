//
//  SecondUnitCollectionViewCell.swift
//  Measurements
//
//  Created by Justin Smith on 6/24/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class SecondUnitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var secondUnitTypeLabel: UILabel!
    
    func updateWithUnit(text: String) {
        self.secondUnitTypeLabel.text = text
    }
}
