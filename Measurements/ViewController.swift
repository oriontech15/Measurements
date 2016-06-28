//
//  ViewController.swift
//  Measurements
//
//  Created by Justin Smith on 6/22/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController, CustomButtonSelectionDelegate, UpdateWithConvertFromValue, UpdateWithConvertToValue, UITextFieldDelegate {
    
    var volumeButton: CustomButton!
    var speedButton: CustomButton!
    var durationButton: CustomButton!
    var temperatureButton: CustomButton!
    var lengthButton: CustomButton!
    var speedNameLabel: CustomLabel!
    var volumeNameLabel: CustomLabel!
    var temperatureNameLabel: CustomLabel!
    var durationNameLabel: CustomLabel!
    var lengthNameLabel: CustomLabel!
    var leftSeparatorView: UIView!
    var rightSeparatorView: UIView!
    
    @IBOutlet weak var toUnitNameLabel: CustomLabel!
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
        
        addSpeedButton()
        addVolumeButton()
        addLengthButton()
        addDurationButton()
        addTemperatureButton()
        
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
        
        labels = [volumeNameLabel, durationNameLabel, lengthNameLabel, speedNameLabel, temperatureNameLabel]
        buttons = [volumeButton, durationButton, lengthButton, speedButton, temperatureButton]
        
        self.view.bringSubview(toFront: fromLabelHolderView)
        self.view.bringSubview(toFront: toLabelHolderView)
        
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        super.preferredStatusBarStyle()
        
        return UIStatusBarStyle.lightContent
    }
    
    func addSeperatorViews() {
        self.leftSeparatorView = UIView(frame: CGRect(x: 0, y: 100, width: 50, height: 1))
        self.rightSeparatorView = UIView(frame: CGRect(x: 132, y: 100, width: UIScreen.main().bounds.width, height: 1))
        
        leftSeparatorView.backgroundColor = .white()
        rightSeparatorView.backgroundColor = .white()
        
        leftSeparatorView.alpha = 0.0
        rightSeparatorView.alpha = 0.0
        
        self.view.addSubview(leftSeparatorView)
        self.view.addSubview(rightSeparatorView)
    }
    
    func updateLabelWithConvertFromValue(text: String) {
        self.fromUnitNameLabel.text = text
        print(text)
    }
    
    func updateLabelWithConvertToValue(text: String) {
        self.toUnitNameLabel.text = text
        print(text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Start calculation here
    }
    
    @IBAction func userTouchedScreen(_ sender: AnyObject) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func userSwipedDown(_ sender: AnyObject) {
        
        self.view.endEditing(true)
    }
    
    func addVolumeButton() {
        self.volumeButton = CustomButton(frame: CGRect(x: (UIScreen.main().bounds.width / 2) - 41, y: (UIScreen.main().bounds.height / 2) - 141, width: 82, height: 82))
        volumeButton.setImage(#imageLiteral(resourceName: "Beaker"), for: UIControlState())
        volumeButton.delegate = self
        volumeButton.tag = 1
        
        self.volumeNameLabel = CustomLabel(frame: CGRect(x: volumeButton.center.x - 50, y: volumeButton.center.y + 50, width: 100, height: 22))
        
        volumeNameLabel.text = "Volume"
        volumeNameLabel.textAlignment = .center
        volumeNameLabel.textColor = .white()
        
        self.view.addSubview(volumeButton)
        self.view.addSubview(volumeNameLabel)
    }
    
    func addSpeedButton() {
        self.speedButton = CustomButton(frame: CGRect(x: (UIScreen.main().bounds.width / 2) - 141, y: (UIScreen.main().bounds.height / 2) - 51, width: 82, height: 82))
        speedButton.setImage(#imageLiteral(resourceName: "Speed"), for: UIControlState())
        speedButton.delegate = self
        speedButton.tag = 2
        
        self.speedNameLabel = CustomLabel(frame: CGRect(x: speedButton.center.x - 50, y: speedButton.center.y + 50, width: 100, height: 22))
        
        speedNameLabel.text = "Speed"
        speedNameLabel.textAlignment = .center
        speedNameLabel.textColor = .white()
        
        self.view.addSubview(speedButton)
        self.view.addSubview(speedNameLabel)
        
    }
    
    func addLengthButton() {
        self.lengthButton = CustomButton(frame: CGRect(x: (UIScreen.main().bounds.width / 2) + 59, y: (UIScreen.main().bounds.height / 2) - 51, width: 82, height: 82))
        lengthButton.setImage(#imageLiteral(resourceName: "Ruler"), for: UIControlState())
        lengthButton.delegate = self
        lengthButton.tag = 3
        
        self.lengthNameLabel = CustomLabel(frame: CGRect(x: lengthButton.center.x - 50, y: lengthButton.center.y + 50, width: 100, height: 22))
        
        lengthNameLabel.text = "Length"
        lengthNameLabel.textAlignment = .center
        lengthNameLabel.textColor = .white()
        
        self.view.addSubview(lengthButton)
        self.view.addSubview(lengthNameLabel)
    }
    
    func addDurationButton() {
        self.durationButton = CustomButton(frame: CGRect(x: (UIScreen.main().bounds.width / 2) - 101, y: (UIScreen.main().bounds.height / 2) + 69, width: 82, height: 82))
        durationButton.setImage(#imageLiteral(resourceName: "StopWatch"), for: UIControlState())
        durationButton.delegate = self
        durationButton.tag = 4
        
        self.durationNameLabel = CustomLabel(frame: CGRect(x: durationButton.center.x - 50, y: durationButton.center.y + 50, width: 100, height: 22))
        
        durationNameLabel.text = "Duration"
        durationNameLabel.textAlignment = .center
        durationNameLabel.textColor = .white()
        
        self.view.addSubview(durationButton)
        self.view.addSubview(durationNameLabel)
    }
    
    func addTemperatureButton() {
        self.temperatureButton = CustomButton(frame: CGRect(x: (UIScreen.main().bounds.width / 2) + 19, y: (UIScreen.main().bounds.height / 2) + 69, width: 82, height: 82))
        temperatureButton.setImage(#imageLiteral(resourceName: "Thermometer"), for: UIControlState())
        temperatureButton.delegate = self
        temperatureButton.tag = 5
        
        self.temperatureNameLabel = CustomLabel(frame: CGRect(x: temperatureButton.center.x - 50, y: temperatureButton.center.y + 50, width: 100, height: 22))
        
        temperatureNameLabel.text = "Temperature"
        temperatureNameLabel.textAlignment = .center
        temperatureNameLabel.textColor = .white()
        
        self.view.addSubview(temperatureButton)
        self.view.addSubview(temperatureNameLabel)
        
    }
    
    func selectionMade(sender: CustomButton) {
        switch sender.tag {
        case 1:
            // Volume
            
            if !sender.selection {
                
                UnitController.sharedController.unitSelected = .Volume
                
                unitTypeCollectionView.reloadData()
                secondUnitTypeCollectionView.reloadData()
                
                AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel, self.toValueView, self.fromValueView, self.toLabelHolderView, self.fromLabelHolderView, self.leftSeparatorView, self.rightSeparatorView], duration: 0.5, visible: true, completion: {
                    
                    self.valueTextField.attributedPlaceholder = AttributedString(string:"0",
                                                                                 attributes:[NSForegroundColorAttributeName: UIColor.white()])
                })
                
                let frame = CGRect(x: 50 + 82 + 10, y: 50, width: 180, height: 60)
                
                AnimationEngine.animateFrame(frame: frame, view: self.volumeNameLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                    
                    AnimationEngine.animateFrameScale(view: self.volumeNameLabel, spring: true, duration: 0.5, damping: 0.3, velocity: 0.8, scaleX: 1.8, scaleY: 1.8, completion: nil)
                })
                
                AnimationEngine.animateAlpha(views: [self.speedNameLabel, self.lengthNameLabel, self.durationNameLabel, self.temperatureNameLabel, self.speedButton, self.durationButton, self.temperatureButton, self.lengthButton], duration: 0.2, visible: false, completion: {
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: true, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView, self.toUnitNameLabel], duration: 0.5, visible: true, completion: {
                        
                    })
                })
                
                self.speedNameLabel.alpha = 0.0
                self.durationNameLabel.alpha = 0.0
                self.temperatureNameLabel.alpha = 0.0
                self.lengthNameLabel.alpha = 0.0
                
                volumeButton.selection = true
            } else {
                
                if let frame = volumeNameLabel.startingFrame {
                    
                    AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel, self.toValueView, self.fromValueView, self.toLabelHolderView, self.fromLabelHolderView, self.leftSeparatorView, self.rightSeparatorView], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: false, completion: {
                        
                        self.unitTypeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: [], animated: false)
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView, self.toUnitNameLabel], duration: 0.5, visible: false, completion: {
                        
                        self.secondUnitTypeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: [], animated: false)
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.volumeNameLabel], duration: 0.1, visible: false, completion: {
                        
                        AnimationEngine.animateFrameScale(view: self.volumeNameLabel, spring: true, duration: 0.5, delay: 0.1, damping: 0.3, velocity: 0.8, scaleX: 1.0, scaleY: 1.0, completion: {
                            
                            self.volumeNameLabel.frame = frame
                                
                            AnimationEngine.animateAlpha(views: [self.volumeNameLabel], duration: 0.2, visible: true, completion: nil)
                        })
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.speedNameLabel, self.lengthNameLabel, self.durationNameLabel, self.temperatureNameLabel, self.speedButton, self.durationButton, self.temperatureButton, self.lengthButton], duration: 0.7, visible: true, completion: {
                        
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
                
                AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel, self.toValueView, self.fromValueView, self.toLabelHolderView, self.fromLabelHolderView, self.leftSeparatorView, self.rightSeparatorView], duration: 0.5, visible: true, completion: {
                    
                    self.valueTextField.attributedPlaceholder = AttributedString(string:"0",
                                                                                 attributes:[NSForegroundColorAttributeName: UIColor.white()])
                })
                
                let frame = CGRect(x: 50 + 82 + 10, y: 50, width: 180, height: 60)
                AnimationEngine.animateFrame(frame: frame, view: self.speedNameLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                    AnimationEngine.animateFrameScale(view: self.speedNameLabel, spring: true, duration: 0.5, damping: 0.3, velocity: 0.8, scaleX: 1.8, scaleY: 1.8, completion: nil)
                })
                
                AnimationEngine.animateAlpha(views: [self.volumeNameLabel, self.lengthNameLabel, self.durationNameLabel, self.temperatureNameLabel, self.volumeButton, self.durationButton, self.temperatureButton, self.lengthButton], duration: 0.2, visible: false, completion: {
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: true, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView, self.toUnitNameLabel], duration: 0.5, visible: true, completion: {
                        
                    })
                })
                
                speedButton.selection = true
            } else {
                
                if let frame = speedNameLabel.startingFrame {
                    
                    AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel, self.toValueView, self.fromValueView, self.toLabelHolderView, self.fromLabelHolderView, self.leftSeparatorView, self.rightSeparatorView], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: false, completion: {
                        
                        self.unitTypeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: [], animated: false)
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView, self.toUnitNameLabel], duration: 0.5, visible: false, completion: {
                        
                        self.secondUnitTypeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: [], animated: false)
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.speedNameLabel], duration: 0.1, visible: false, completion: {
                        
                        AnimationEngine.animateFrameScale(view: self.speedNameLabel, spring: true, duration: 0.5, delay: 0.1, damping: 0.3, velocity: 0.8, scaleX: 1.0, scaleY: 1.0, completion: {
                            
                            self.speedNameLabel.frame = frame
                                
                            AnimationEngine.animateAlpha(views: [self.speedNameLabel], duration: 0.2, visible: true, completion: nil)
                        })
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.volumeNameLabel, self.lengthNameLabel, self.durationNameLabel, self.temperatureNameLabel, self.volumeButton, self.durationButton, self.temperatureButton, self.lengthButton], duration: 0.7, visible: true, completion: {
                        
                        
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
                
                AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel, self.toValueView, self.fromValueView, self.toLabelHolderView, self.fromLabelHolderView, self.leftSeparatorView, self.rightSeparatorView], duration: 0.5, visible: true, completion: {
                    
                    self.valueTextField.attributedPlaceholder = AttributedString(string:"0",
                                                                                 attributes:[NSForegroundColorAttributeName: UIColor.white()])
                })
                
                let frame = CGRect(x: 50 + 82 + 10, y: 50, width: 180, height: 60)
                AnimationEngine.animateFrame(frame: frame, view: self.lengthNameLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                    AnimationEngine.animateFrameScale(view: self.lengthNameLabel, spring: true, duration: 0.5, damping: 0.3, velocity: 0.8, scaleX: 1.8, scaleY: 1.8, completion: nil)
                })
                
                AnimationEngine.animateAlpha(views: [self.speedNameLabel, self.volumeNameLabel, self.durationNameLabel, self.temperatureNameLabel, self.speedButton, self.durationButton, self.temperatureButton, self.volumeButton], duration: 0.2, visible: false, completion: {
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: true, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView, self.toUnitNameLabel], duration: 0.5, visible: true, completion: {
                        
                    })
                })
                
                lengthButton.selection = true
            } else {
                
                if let frame = lengthNameLabel.startingFrame {
                    
                    AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel, self.toValueView, self.fromValueView, self.toLabelHolderView, self.fromLabelHolderView, self.leftSeparatorView, self.rightSeparatorView], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: false, completion: {
                        
                        self.unitTypeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: [], animated: false)
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView, self.toUnitNameLabel], duration: 0.5, visible: false, completion: {
                        
                        self.secondUnitTypeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: [], animated: false)
                        
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.lengthNameLabel], duration: 0.1, visible: false, completion: {
                        
                        AnimationEngine.animateFrameScale(view: self.lengthNameLabel, spring: true, duration: 0.5, delay: 0.1, damping: 0.3, velocity: 0.8, scaleX: 1.0, scaleY: 1.0, completion: {
                            
                            self.lengthNameLabel.frame = frame
                                
                            AnimationEngine.animateAlpha(views: [self.lengthNameLabel], duration: 0.2, visible: true, completion: nil)
                        })
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.speedNameLabel, self.volumeNameLabel, self.durationNameLabel, self.temperatureNameLabel, self.speedButton, self.durationButton, self.temperatureButton, self.volumeButton], duration: 0.7, visible: true, completion: {
                        
                        
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
                
                let frame = CGRect(x: 50 + 82 + 10, y: 50, width: 180, height: 60)
                
                AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel, self.toValueView, self.fromValueView, self.toLabelHolderView, self.fromLabelHolderView, self.leftSeparatorView, self.rightSeparatorView], duration: 0.5, visible: true, completion: {
                    
                    self.valueTextField.attributedPlaceholder = AttributedString(string:"0",
                                                                                 attributes:[NSForegroundColorAttributeName: UIColor.white()])
                })
                
                AnimationEngine.animateFrame(frame: frame, view: self.durationNameLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                    AnimationEngine.animateFrameScale(view: self.durationNameLabel, spring: true, duration: 0.5, damping: 0.3, velocity: 0.8, scaleX: 1.8, scaleY: 1.8, completion: nil)
                })
                
                AnimationEngine.animateAlpha(views: [self.speedNameLabel, self.lengthNameLabel, self.volumeNameLabel, self.temperatureNameLabel, self.speedButton, self.volumeButton, self.temperatureButton, self.lengthButton], duration: 0.2, visible: false, completion: {
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: true, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView, self.toUnitNameLabel], duration: 0.5, visible: true, completion: {
                        
                    })
                })
                
                durationButton.selection = true
            } else {
                
                if let frame = durationNameLabel.startingFrame {
                    
                    AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel, self.toValueView, self.fromValueView, self.toLabelHolderView, self.fromLabelHolderView, self.leftSeparatorView, self.rightSeparatorView], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: false, completion: {
                        
                        self.unitTypeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: [], animated: false)
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView, self.toUnitNameLabel], duration: 0.5, visible: false, completion: {
                        
                        self.secondUnitTypeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: [], animated: false)
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.durationNameLabel], duration: 0.1, visible: false, completion: {
                        
                        AnimationEngine.animateFrameScale(view: self.durationNameLabel, spring: true, duration: 0.5, delay: 0.1, damping: 0.3, velocity: 0.8, scaleX: 1.0, scaleY: 1.0, completion: {
                            
                            self.durationNameLabel.frame = frame
                                
                            AnimationEngine.animateAlpha(views: [self.durationNameLabel], duration: 0.2, visible: true, completion: nil)
                        })
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.speedNameLabel, self.lengthNameLabel, self.volumeNameLabel, self.temperatureNameLabel, self.speedButton, self.volumeButton, self.temperatureButton, self.lengthButton], duration: 0.7, visible: true, completion: {
                        
                        
                    })
                    
                    durationButton.selection = false
                }
            }
            
        case 5:
            
            if !sender.selection {
                
                UnitController.sharedController.unitSelected = .Temperature
                
                unitTypeCollectionView.reloadData()
                secondUnitTypeCollectionView.reloadData()
                
                AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel, self.toValueView, self.fromValueView, self.toLabelHolderView, self.fromLabelHolderView, self.leftSeparatorView, self.rightSeparatorView], duration: 0.5, visible: true, value: 1.0, completion: {
                    
                    self.valueTextField.attributedPlaceholder = AttributedString(string:"0",
                                                                                 attributes:[NSForegroundColorAttributeName: UIColor.white()])
                    
                })
                
                let frame = CGRect(x: 50 + 82 + 10, y: 50, width: 180, height: 60)
                AnimationEngine.animateFrame(frame: frame, view: self.temperatureNameLabel, spring: true, duration: 0.5, damping: 1.0, velocity: 0.8, completion: {
                    AnimationEngine.animateFrameScale(view: self.temperatureNameLabel, spring: true, duration: 0.5, damping: 0.3, velocity: 0.8, scaleX: 1.8, scaleY: 1.8, completion: nil)
                })
                
                AnimationEngine.animateAlpha(views: [self.speedNameLabel, self.lengthNameLabel, self.durationNameLabel, self.volumeNameLabel, self.speedButton, self.durationButton, self.volumeButton, self.lengthButton], duration: 0.2, visible: false, completion: {
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: true, completion: {
                        
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView, self.toUnitNameLabel], duration: 0.5, visible: true, completion: {
                        
                    })
                })
                
                temperatureButton.selection = true
            } else {
                
                if let frame = temperatureNameLabel.startingFrame {
                    
                    AnimationEngine.animateAlpha(views: [self.valueTextField, self.resultLabel, self.toValueView, self.fromValueView, self.toLabelHolderView, self.fromLabelHolderView, self.leftSeparatorView, self.rightSeparatorView], duration: 0.5, visible: false, completion: nil)
                    
                    AnimationEngine.animateAlpha(views: [self.unitTypeCollectionView, self.fromUnitNameLabel], duration: 0.5, visible: false, completion: {
                        
                        self.unitTypeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: [], animated: false)
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.secondUnitTypeCollectionView, self.toUnitNameLabel], duration: 0.5, visible: false, completion: {
                        
                        self.secondUnitTypeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: [], animated: false)
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.temperatureNameLabel], duration: 0.1, visible: false, completion: {
                        
                        AnimationEngine.animateFrameScale(view: self.temperatureNameLabel, spring: true, duration: 0.5, delay: 0.1, damping: 0.3, velocity: 0.8, scaleX: 1.0, scaleY: 1.0, completion: {
                            
                            self.temperatureNameLabel.frame = frame
                                
                            AnimationEngine.animateAlpha(views: [self.temperatureNameLabel], duration: 0.2, visible: true, completion: nil)
                        })
                    })
                    
                    AnimationEngine.animateAlpha(views: [self.speedNameLabel, self.lengthNameLabel, self.durationNameLabel, self.volumeNameLabel, self.speedButton, self.durationButton, self.volumeButton, self.lengthButton], duration: 0.2, visible: true, completion: nil)
                    
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

