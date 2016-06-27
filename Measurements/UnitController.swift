//
//  UnitController.swift
//  Measurements
//
//  Created by Justin Smith on 6/24/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

class UnitController {
    
    static let sharedController = UnitController()
    
    enum UnitSelected {
        case Temperature
        case Speed
        case Duration
        case Volume
        case Length
    }
    
    var unitSelected = UnitSelected.Volume
    
    static func getUnitsForTemperature() -> [UnitTemperature] {
        return [UnitTemperature.celsius,
                UnitTemperature.fahrenheit,
                UnitTemperature.kelvin]
    }
    
    static func getUnitsForSpeed() -> [UnitSpeed] {
        return [UnitSpeed.kilometersPerHour,
                UnitSpeed.knots,
                UnitSpeed.metersPerSecond,
                UnitSpeed.milesPerHour]
    }
    
    static func getUnitsForDuration() -> [UnitDuration] {
        return [UnitDuration.hours,
                UnitDuration.minutes,
                UnitDuration.seconds]
    }
    
    static func getUnitsForVolume() -> [UnitVolume] {
        return [UnitVolume.acreFeet,
                UnitVolume.bushels,
                UnitVolume.centiliters,
                UnitVolume.cubicCentimeters,
                UnitVolume.cubicDecimeters,
                UnitVolume.cubicFeet,
                UnitVolume.cubicInches,
                UnitVolume.cubicKilometers,
                UnitVolume.cubicMeters,
                UnitVolume.cubicMiles,
                UnitVolume.cubicMillimeters,
                UnitVolume.cubicYards,
                UnitVolume.cups,
                UnitVolume.deciliters,
                UnitVolume.fluidOunces,
                UnitVolume.gallons,
                UnitVolume.imperialFluidOunces,
                UnitVolume.imperialGallons,
                UnitVolume.imperialPints,
                UnitVolume.imperialQuarts,
                UnitVolume.imperialTablespoons,
                UnitVolume.imperialTeaspoons,
                UnitVolume.kiloliters,
                UnitVolume.liters,
                UnitVolume.megaliters,
                UnitVolume.metricCups,
                UnitVolume.milliliters,
                UnitVolume.pints,
                UnitVolume.quarts,
                UnitVolume.tablespoons,
                UnitVolume.teaspoons]
    }
    
    static func getUnitsLength() -> [UnitLength] {
        return [UnitLength.astronomicalUnits,
                UnitLength.centimeters,
                UnitLength.decameters,
                UnitLength.decimeters,
                UnitLength.fathoms,
                UnitLength.feet,
                UnitLength.furlongs,
                UnitLength.hectometers,
                UnitLength.inches,
                UnitLength.kilometers,
                UnitLength.lightyears,
                UnitLength.megameters,
                UnitLength.meters,
                UnitLength.micrometers,
                UnitLength.miles,
                UnitLength.millimeters,
                UnitLength.nanometers,
                UnitLength.nauticalMiles,
                UnitLength.parsecs,
                UnitLength.picometers,
                UnitLength.scandinavianMiles,
                UnitLength.yards]
    }
    
    static func convertTemperature(value: Double, convertFrom: UnitTemperature, convertTo: UnitTemperature) -> Measurement<UnitTemperature> {
        var temperature = Measurement(value: value, unit: convertFrom)
        
        temperature.convert(to: convertTo)
        
        return temperature
    }
    
    static func convertSpeed(value: Double, convertFrom: UnitSpeed, convertTo: UnitSpeed) -> Measurement<UnitSpeed> {
        var speed = Measurement(value: value, unit: convertFrom)
        
        speed.convert(to: convertTo)
        
        return speed
    }
    
    static func convertLength(value: Double, convertFrom: UnitLength, convertTo: UnitLength) -> Measurement<UnitLength> {
        var length = Measurement(value: value, unit: convertFrom)
        
        length.convert(to: convertTo)
        
        return length
    }
    
    static func convertDuration(value: Double, convertFrom: UnitDuration, convertTo: UnitDuration) -> Measurement<UnitDuration> {
        var duration = Measurement(value: value, unit: convertFrom)
        
        duration.convert(to: convertTo)
        
        return duration
    }
    
    static func convertVolume(value: Double, convertFrom: UnitVolume, convertTo: UnitVolume) -> Measurement<UnitVolume> {
        var volume = Measurement(value: value, unit: convertFrom)
        
        volume.convert(to: convertTo)
        
        return volume
    }
}



