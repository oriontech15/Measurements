//
//  CustomButton.swift
//  Measurements
//
//  Created by Justin Smith on 6/22/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit

protocol CustomButtonSelectionDelegate: class {
    func selectionMade(sender: CustomButton)
}

@IBDesignable
class CustomButton: UIButton {

    weak var delegate: CustomButtonSelectionDelegate?
    var selection: Bool = false
    var startingFrame: CGRect?
    
    override func prepareForInterfaceBuilder() {
        setupButton()
    }
    
    override func awakeFromNib() {
        setupButton()
        
        self.addTarget(self, action: #selector(moveToPosition), for: .touchUpInside)
    }
    
    func setupButton() {
        self.layer.cornerRadius = 82.0 / 2
        self.layer.borderColor = UIColor.white().cgColor
        self.layer.borderWidth = 1.3
    }
    
    func moveToPosition() {
        self.delegate?.selectionMade(sender: self)
        if self.selection {
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                self.frame = CGRect(x: 50, y: 30, width: 82, height: 82)
                }, completion: nil)
        } else {
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                    self.frame = self.startingFrame!
                }, completion: nil)
        }
    }
}
