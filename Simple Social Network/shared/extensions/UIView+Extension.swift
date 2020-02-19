//
//  UIView+Extensions.swift
//  Simple Social Network
//
//  Created by Adriano Song on 17/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

extension UIView {
    
    enum FlipTransition {
        case left
        case right
    }
    
    static func windowFlipTranstion(window: UIWindow,
                                    flipTranstion: FlipTransition = .left,
                                    viewController: UIViewController?,
                                    completion: (() -> Void)? = nil) {
        
        let animTransition = getFlipAnimation(flipTranstion: flipTranstion)
        
        UIView.transition(with: window,
                          duration: 0.35,
                          options: animTransition,
                          animations: {
                            window.rootViewController = viewController
                            
        }, completion: { (_) in
            completion?()
        })
    }
    
    fileprivate static func getFlipAnimation(flipTranstion: FlipTransition) -> UIView.AnimationOptions {
        switch flipTranstion {
        case .left:
            return .transitionFlipFromLeft
        default:
            return .transitionFlipFromRight
        }
    }
}
