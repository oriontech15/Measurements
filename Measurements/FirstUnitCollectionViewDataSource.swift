//
//  FirstUnitCollectionView.swift
//  Measurements
//
//  Created by Justin Smith on 6/24/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

protocol UpdateWithConvertFromValue {
    func updateLabelWithConvertFromValue(text: String)
}

class FirstUnitCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var convertFromDelegate: UpdateWithConvertFromValue?
    
    @IBOutlet weak var firstCollectionView: UICollectionView!
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstUnitCell", for: indexPath) as? FirstUnitCollectionViewCell else { return UICollectionViewCell() }
        
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
        
        let point = CGPoint(x: firstCollectionView.frame.width / 2 + firstCollectionView.contentOffset.x, y: firstCollectionView.frame.height / 2 + firstCollectionView.contentOffset.y)
        guard let indexPath = firstCollectionView.indexPathForItem(at: point) else { print("Could not get indexpath for item at point \(point)");return }
        
        guard let cell = firstCollectionView.cellForItem(at: indexPath) as? FirstUnitCollectionViewCell else { NSLog("Could not convert second cell");return }
        
        guard let text = cell.firstUnitTypeLabel.text else { NSLog("Could not get text from label"); return }
        
        self.convertFromDelegate?.updateLabelWithConvertFromValue(text: text)
    }}
