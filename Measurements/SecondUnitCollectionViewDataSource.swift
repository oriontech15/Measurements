//
//  SecondUnitCollectionViewDataSource.swift
//  Measurements
//
//  Created by Justin Smith on 6/24/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

protocol UpdateWithConvertToValue: class {
    func updateLabelWithConvertToValue(text: String)
}

class SecondUnitCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    weak var convertToDelegate: UpdateWithConvertToValue?
    
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch UnitController.sharedController.unitSelected {
        case .Volume:
            return UnitController.getUnitsForVolume().count
        case .Speed:
            return UnitController.getUnitsForSpeed().count
        case .Length:
            return UnitController.getUnitsLength().count
        case .Duration:
            return UnitController.getUnitsForDuration().count
        case .Temperature:
            return UnitController.getUnitsForTemperature().count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondUnitCell", for: indexPath) as? SecondUnitCollectionViewCell else {return UICollectionViewCell() }
        
        switch UnitController.sharedController.unitSelected {
        case .Volume:
            var units = UnitController.getUnitsForVolume()
            let unit = units[indexPath.row]
            let unitFormatter = MeasurementFormatter()
            unitFormatter.unitOptions = .providedUnit
            let string = unitFormatter.string(from: unit)
            cell.updateWithUnit(text: "\(string)")
        case .Speed:
            var units = UnitController.getUnitsForSpeed()
            let unit = units[indexPath.row]
            let unitFormatter = MeasurementFormatter()
            unitFormatter.unitOptions = .providedUnit
            let string = unitFormatter.string(from: unit)
            cell.updateWithUnit(text: "\(string)")
        case .Length:
            var units = UnitController.getUnitsLength()
            let unit = units[indexPath.row]
            let unitFormatter = MeasurementFormatter()
            unitFormatter.unitOptions = .providedUnit
            let string = unitFormatter.string(from: unit)
            cell.updateWithUnit(text: "\(string)")
        case .Duration:
            var units = UnitController.getUnitsForDuration()
            let unit = units[indexPath.row]
            let unitFormatter = MeasurementFormatter()
            unitFormatter.unitOptions = .providedUnit
            let string = unitFormatter.string(from: unit)
            cell.updateWithUnit(text: "\(string)")
        case .Temperature:
            var units = UnitController.getUnitsForTemperature()
            let unit = units[indexPath.row]
            let unitFormatter = MeasurementFormatter()
            unitFormatter.unitOptions = .providedUnit
            let string = unitFormatter.string(from: unit)
            cell.updateWithUnit(text: "\(string)")        }
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let point = CGPoint(x: secondCollectionView.frame.width / 2 + secondCollectionView.contentOffset.x, y: secondCollectionView.frame.height / 2 + secondCollectionView.contentOffset.y)
        guard let indexPath = secondCollectionView.indexPathForItem(at: point) else { print("Could not get indexpath for item at point: \(point)"); return }
        
        guard let cell = secondCollectionView.cellForItem(at: indexPath) as? SecondUnitCollectionViewCell else { print("Could not convert second cell");return }
        
        guard let text = cell.secondUnitTypeLabel.text else { print("Could not get text from label"); return }
        
        self.convertToDelegate?.updateLabelWithConvertToValue(text: text)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(0, (UIScreen.main().bounds.width / 2) - 40, 0, 0)
//    }
}
