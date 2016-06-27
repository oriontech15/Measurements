//
//  FirstUnitCollectionViewCell.swift
//  Measurements
//
//  Created by Justin Smith on 6/24/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

class FirstUnitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var firstUnitTypeLabel: UILabel!
    
    func updateWithUnit(text: String) {
        self.firstUnitTypeLabel.text = text
    }
}
