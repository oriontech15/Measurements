//
//  ViewController.swift
//  Measurements
//
//  Created by Justin Smith on 6/22/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController, CustomButtonSelectionDelegate, UpdateWithConvertFromValue, UpdateWithConvertToValue {
    
    @IBOutlet weak var volumeButton: CustomButton!
    @IBOutlet weak var speedButton: CustomButton!
    @IBOutlet weak var durationButton: CustomButton!
    @IBOutlet weak var temperatureButton: CustomButton!
    @IBOutlet weak var lengthButton: CustomButton!
    @IBOutlet weak var speedLabel: CustomLabel!
    @IBOutlet weak var volumeLabel: CustomLabel!
    @IBOutlet weak var temperatureLabel: CustomLabel!
    @IBOutlet weak var durationLabel: CustomLabel!
    @IBOutlet weak var lengthLabel: CustomLabel!
    @IBOutlet weak var unitTypeCollectionView: UICollectionView!
    @IBOutlet weak var secondUnitTypeCollectionView: UICollectionView!
    @IBOutlet weak var fromUnitNameLabel: CustomLabel!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var fromValueView: UIView!
    @IBOutlet weak var toValueView: UIView!
    @IBOutlet weak var toLabelHolderView: UIView!
    @IBOutlet weak var fromLabelHolderView: UIView!
        
    var startingFramesSet: Bool = false
    var buttons: [CustomButton] = []
    var labels: [CustomLabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        unitTypeCollectionView.layer.borderWidth = 1
        unitTypeCollectionView.layer.borderColor = UIColor.white().cgColor
        
        secondUnitTypeCollectionView.layer.borderWidth = 1
        secondUnitTypeCollectionView.layer.borderColor = UIColor.white().cgColor
        if let datasource = unitTypeCollectionView.dataSource as? FirstUnitCollectionViewDataSource {
            datasource.convertFromDelegate = self
        }
        
        if let datasource = secondUnitTypeCollectionView.dataSource as? SecondUnitCollectionViewDataSource {
            datasource.convertToDelegate = self
        }
        
        fromLabelHolderView.layer.cornerRadius = 20
        toLabelHolderView.layer.cornerRadius = 20
        
        fromValueView.layer.cornerRadius = 45
        toValueView.layer.cornerRadius = 45
        
        volumeButton.delegate = self
        speedButton.delegate = self
        durationButton.delegate = self
        temperatureButton.delegate = self
        lengthButton.delegate = self
        
        labels = [volumeLabel, durationLabel, lengthLabel, speedLabel, temperatureLabel]
        buttons = [volumeButton, durationButton, lengthButton, speedButton, temperatureButton]
        
        addSeperatorViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for label in self.labels  {
            
            if label.startingFrame == nil {
                label.startingFrame = label.frame
            }
        }
        
        for button in self.buttons {
            
            if button.startingFrame == nil {
                button.startingFrame = button.frame
            }
        }
    }
    
    func addSeperatorViews() {
        let leftView = UIView(frame: CGRect(x: 0, y: 100, width: 50, height: 1))
        let rightView = UIView(frame: CGRect(x: 132, y: 100, width: UIScreen.main().bounds.width, height: 1))
        
        leftView.backgroundColor = .white()
        rightView.backgroundColor = .white()
        
        self.view.addSubview(leftView)
        self.view.addSubview(rightView)
    }
    
    func updateLabelWithConvertFromValue(text: String) {
        self.fromUnitNameLabel.text = text
        print(text)
    }
    
    func updateLabelWithConvertToValue(text: String) {
        print(text)
    }
    
    
    @IBAction func userTouchedScreen(_ sender: AnyObject) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func userSwipedDown(_ sender: AnyObject) {
        
        self.view.endEditing(true)
    }
    
    func selectionMade(sender: CustomButton) {
        switch sender.tag {
        case 1:
            // Volume
            
            if !sender.selection {
                
                
                
                UnitController.sharedController.unitSelected = .Volume
                
                unitTypeCollectionView.reloadData()
                secondUnitTypeCollectionView.reloadData()
                            
                AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel], duration: 0.5, visible: true, completion: {
                    
                    self.valueTextField.attributedPlaceholder = AttributedString(string:"0",
                                                                                 attributes:[NSForegroundColorAttributeName: UIColor.white()])
                })
                
                let frame = CGRect(x: 50 + 82 + 10, y: 50, width: 180, height: 60)
                
                AnimationEngine.animateFrame(frame: frame, view: self.volumeLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                                    
                    AnimationEngine.animateFrameScale(view: self.volumeLabel, spring: true, duration: 0.5, damping: 0.3, velocity: 0.8, scaleX: 1.8, scaleY: 1.8, completion: nil)
                })
                
                AnimationEngine.animateAlpha(views: [self.speedLabel, self.lengthLabel, self.durationLabel, self.temperatureLabel, self.speedButton, self.durationButton, self.temperatureButton, self.lengthButton], duration: 0.2, visible: false, completion: {
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: true, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView], duration: 0.5, visible: true, completion: {
                        
                    })
                })
                
                volumeButton.selection = true
            } else {
                
                if let frame = volumeLabel.startingFrame {
                    
                    AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView], duration: 0.5, visible: false, completion: {
                        
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.volumeLabel], duration: 0.3, visible: false, completion: {
                        
                        AnimationEngine.animateFrameScale(view: self.volumeLabel, spring: true, duration: 0.5, delay: 0.1, damping: 0.3, velocity: 0.8, scaleX: 1.0, scaleY: 1.0, completion: {
                            
                            AnimationEngine.animateFrame(frame: frame, view: self.volumeLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                                
                                AnimationEngine.animateAlpha(views: [self.volumeLabel], duration: 0.2, visible: true, completion: nil)
                            })
                        })
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.speedLabel, self.lengthLabel, self.durationLabel, self.temperatureLabel, self.speedButton, self.durationButton, self.temperatureButton, self.lengthButton], duration: 0.7, visible: true, completion: {
                        
                    })
                    
                    volumeButton.selection = false
                }
            }
            
        case 2:
            // Speed
            
            if !sender.selection {

                UnitController.sharedController.unitSelected = .Speed
                
                unitTypeCollectionView.reloadData()
                secondUnitTypeCollectionView.reloadData()
                
                AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel], duration: 0.5, visible: true, completion: {
                    
                    self.valueTextField.attributedPlaceholder = AttributedString(string:"0",
                                                                                 attributes:[NSForegroundColorAttributeName: UIColor.white()])
                })
                
                let frame = CGRect(x: 50 + 82 + 10, y: 110, width: 180, height: 60)
                AnimationEngine.animateFrame(frame: frame, view: self.speedLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                    AnimationEngine.animateFrameScale(view: self.speedLabel, spring: true, duration: 0.5, damping: 0.3, velocity: 0.8, scaleX: 1.8, scaleY: 1.8, completion: nil)
                })
                
                AnimationEngine.animateAlpha(views: [self.volumeLabel, self.lengthLabel, self.durationLabel, self.temperatureLabel, self.volumeButton, self.durationButton, self.temperatureButton, self.lengthButton], duration: 0.2, visible: false, completion: {
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: true, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView], duration: 0.5, visible: true, completion: {
                        
                    })
                })
                
                speedButton.selection = true
            } else {
                
                if let frame = speedLabel.startingFrame {
                    
                    AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView], duration: 0.5, visible: false, completion: {
                        
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.speedLabel], duration: 0.3, visible: false, completion: {
                        
                        AnimationEngine.animateFrameScale(view: self.speedLabel, spring: true, duration: 0.5, delay: 0.1, damping: 0.3, velocity: 0.8, scaleX: 1.0, scaleY: 1.0, completion: {
                            
                            AnimationEngine.animateFrame(frame: frame, view: self.speedLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                                
                                AnimationEngine.animateAlpha(views: [self.speedLabel], duration: 0.2, visible: true, completion: nil)
                            })
                        })
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.volumeLabel, self.lengthLabel, self.durationLabel, self.temperatureLabel, self.volumeButton, self.durationButton, self.temperatureButton, self.lengthButton], duration: 0.7, visible: true, completion: {
                        
                        
                    })
                    
                    speedButton.selection = false
                }
            }
            
        case 3:
            // Length
            
            if !sender.selection {

                UnitController.sharedController.unitSelected = .Length
                
                unitTypeCollectionView.reloadData()
                secondUnitTypeCollectionView.reloadData()
                
                AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel], duration: 0.5, visible: true, completion: {
                    
                    self.valueTextField.attributedPlaceholder = AttributedString(string:"0",
                                                                                 attributes:[NSForegroundColorAttributeName: UIColor.white()])
                })

                let frame = CGRect(x: 50 + 82 + 10, y: 110, width: 180, height: 60)
                AnimationEngine.animateFrame(frame: frame, view: self.lengthLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                    AnimationEngine.animateFrameScale(view: self.lengthLabel, spring: true, duration: 0.5, damping: 0.3, velocity: 0.8, scaleX: 1.8, scaleY: 1.8, completion: nil)
                })
                
                AnimationEngine.animateAlpha(views: [self.speedLabel, self.volumeLabel, self.durationLabel, self.temperatureLabel, self.speedButton, self.durationButton, self.temperatureButton, self.volumeButton], duration: 0.2, visible: false, completion: {
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: true, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView], duration: 0.5, visible: true, completion: {
                        
                    })
                })
                
                lengthButton.selection = true
            } else {
                
                if let frame = lengthLabel.startingFrame {
                    
                    AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView], duration: 0.5, visible: false, completion: {
                        
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.lengthLabel], duration: 0.3, visible: false, completion: {
                        
                        AnimationEngine.animateFrameScale(view: self.lengthLabel, spring: true, duration: 0.5, delay: 0.1, damping: 0.3, velocity: 0.8, scaleX: 1.0, scaleY: 1.0, completion: {
                            
                            AnimationEngine.animateFrame(frame: frame, view: self.lengthLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                                
                                AnimationEngine.animateAlpha(views: [self.lengthLabel], duration: 0.2, visible: true, completion: nil)
                            })
                        })
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.speedLabel, self.volumeLabel, self.durationLabel, self.temperatureLabel, self.speedButton, self.durationButton, self.temperatureButton, self.volumeButton], duration: 0.7, visible: true, completion: {
                        
                        
                    })
                    
                    lengthButton.selection = false
                }
            }
            
        case 4:
            // Duration
            
            if !sender.selection {
                
                UnitController.sharedController.unitSelected = .Duration
                
                unitTypeCollectionView.reloadData()
                secondUnitTypeCollectionView.reloadData()
                
                let frame = CGRect(x: 50 + 82 + 10, y: 110, width: 180, height: 60)
                
                AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel], duration: 0.5, visible: true, completion: {
                    
                    self.valueTextField.attributedPlaceholder = AttributedString(string:"0",
                                                                                 attributes:[NSForegroundColorAttributeName: UIColor.white()])
                })

                AnimationEngine.animateFrame(frame: frame, view: self.durationLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                    AnimationEngine.animateFrameScale(view: self.durationLabel, spring: true, duration: 0.5, damping: 0.3, velocity: 0.8, scaleX: 1.8, scaleY: 1.8, completion: nil)
                })
                
                AnimationEngine.animateAlpha(views: [self.speedLabel, self.lengthLabel, self.volumeLabel, self.temperatureLabel, self.speedButton, self.volumeButton, self.temperatureButton, self.lengthButton], duration: 0.2, visible: false, completion: {
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: true, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView], duration: 0.5, visible: true, completion: {
                        
                    })
                })
                
                durationButton.selection = true
            } else {
                
                if let frame = durationLabel.startingFrame {
                    
                    AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView], duration: 0.5, visible: false, completion: {
                        
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.durationLabel], duration: 0.3, visible: false, completion: {
                        
                        AnimationEngine.animateFrameScale(view: self.durationLabel, spring: true, duration: 0.5, delay: 0.1, damping: 0.3, velocity: 0.8, scaleX: 1.0, scaleY: 1.0, completion: {
                            
                            AnimationEngine.animateFrame(frame: frame, view: self.durationLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                                
                                AnimationEngine.animateAlpha(views: [self.durationLabel], duration: 0.2, visible: true, completion: nil)
                            })
                        })
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.speedLabel, self.lengthLabel, self.volumeLabel, self.temperatureLabel, self.speedButton, self.volumeButton, self.temperatureButton, self.lengthButton], duration: 0.7, visible: true, completion: {
                        
                        
                    })
                    
                    durationButton.selection = false
                }
            }
            
        case 5:
            if !sender.selection {
                
                UnitController.sharedController.unitSelected = .Temperature
                
                unitTypeCollectionView.reloadData()
                secondUnitTypeCollectionView.reloadData()
                
                AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel], duration: 0.5, visible: true, value: 0.8, completion: {
                
                    self.valueTextField.attributedPlaceholder = AttributedString(string:"0",
                                                                           attributes:[NSForegroundColorAttributeName: UIColor.white()])
                    
                })
                
                let frame = CGRect(x: 50 + 82 + 10, y: 110, width: 180, height: 60)
                AnimationEngine.animateFrame(frame: frame, view: self.temperatureLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                    AnimationEngine.animateFrameScale(view: self.temperatureLabel, spring: true, duration: 0.5, damping: 0.3, velocity: 0.8, scaleX: 1.8, scaleY: 1.8, completion: nil)
                })
                
                AnimationEngine.animateAlpha(views: [self.speedLabel, self.lengthLabel, self.durationLabel, self.volumeLabel, self.speedButton, self.durationButton, self.volumeButton, self.lengthButton], duration: 0.2, visible: false, completion: {
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: true, completion: {
                    
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView], duration: 0.5, visible: true, completion: {
                    
                    })
                })
                
                temperatureButton.selection = true
            } else {
                
                if let frame = temperatureLabel.startingFrame {
                    
                    AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView], duration: 0.5, visible: false, completion: {
                        
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.temperatureLabel], duration: 0.3, visible: false, completion: {
                        
                        AnimationEngine.animateFrameScale(view: self.temperatureLabel, spring: true, duration: 0.5, delay: 0.1, damping: 0.3, velocity: 0.8, scaleX: 1.0, scaleY: 1.0, completion: {
                            
                            AnimationEngine.animateFrame(frame: frame, view: self.temperatureLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                                
                                AnimationEngine.animateAlpha(views: [self.temperatureLabel], duration: 0.7, visible: true, completion: nil)
                            })
                        })
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.speedLabel, self.lengthLabel, self.durationLabel, self.volumeLabel, self.speedButton, self.durationButton, self.volumeButton, self.lengthButton], duration: 0.2, visible: true, completion: nil)
                    
                    temperatureButton.selection = false
                }
            }
            
        default:
            break
        }
    }
    
    
    
//    func measureTemp() {
//        var temperature = Measurement(value: 73, unit: UnitTemperature.fahrenheit)
//        print("\n\(round( 10 * temperature.value) / 10) ºF")
//        temperature.convert(to: UnitTemperature.celsius)
//        print(temperature)
//        
//        temperature.convert(to: UnitTemperature.celsius)
//        print("\n\(round( 10 * temperature.value) / 10) ºC")
//    }
//    
//    func measureCups() {
//        var cups = Measurement(value: 10, unit: UnitVolume.cups)
//        print("\n\(round(10 * cups.value) / 10) Cups")
//        cups.convert(to: UnitVolume.gallons)
//        print("\n\(round(10 * cups.value) / 10) Gallons")
//        cups.convert(to: UnitVolume.fluidOunces)
//        print("\n\(round(10 * cups.value) / 10) Fluid Ounces")
//        cups.convert(to: UnitVolume.pints)
//        print("\n\(round(10 * cups.value) / 10) Pints")
//    }
}

