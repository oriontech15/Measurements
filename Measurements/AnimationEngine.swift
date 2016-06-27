//
//  AnimationEngine.swift
//  Measurements
//
//  Created by Justin Smith on 6/23/16.
//  Copyright © 2016 Justin Smith. All rights reserved.
//

import Foundation
import UIKit

class AnimationEngine {
    
    static func animateAlpha(views: [UIView], duration: TimeInterval, visible: Bool, value: CGFloat = 1.0, completion: (() -> Void)?) {
        
        if visible {
            for view in views {
                UIView.animate(withDuration: duration) {
                    view.alpha = value
                }
            }
            completion?()
        } else {
            for view in views  {
                UIView.animate(withDuration: duration) {
                    view.alpha = 0.0
                }
            }
            completion?()
        }
    }
    
    static func animateImageChange(imageView: UIImageView, image: UIImage) {
        UIView.animate(withDuration: 1.0, animations: {
            imageView.image = image
        })
    }
    
    static func animateFrame(frame: CGRect,
                             view: UIView,
                             spring: Bool = true,
                             duration: TimeInterval = 1.0,
                             delay: TimeInterval = 0.0,
                             damping: CGFloat = 1.0,
                             velocity: CGFloat = 1.0,
                             options: UIViewAnimationOptions = [],
                             completion: (() -> Void)?) {
        
        if spring {
            
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: {
                view.frame = frame
                }, completion: { (_) -> Void in  completion?() })
        } else {
            
            UIView.animate(withDuration: duration, animations: {
                view.frame = frame
                }, completion: { (_) -> Void in  completion?() })
        }
    }
    
    static func animateFrameScale(view: UIView,
                                  spring: Bool,
                                  duration: TimeInterval = 1.0,
                                  delay: TimeInterval = 0.0,
                                  damping: CGFloat = 1.0,
                                  velocity: CGFloat = 1.0,
                                  options: UIViewAnimationOptions = [],
                                  scaleX: CGFloat,
                                  scaleY: CGFloat,
                                  completion: (() -> Void)?) {
        
        if spring {
            
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: {
                view.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                }, completion: { (_) -> Void in  completion?() })
        } else {
            
            UIView.animate(withDuration: duration, animations: {
                view.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                }, completion: { (_) -> Void in  completion?() })
        }
    }
}
