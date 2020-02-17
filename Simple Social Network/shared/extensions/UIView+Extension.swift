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
    
    static func windowFlipTranstion(window: UIWindow,
                                    viewController: UIViewController?,
                                    completion: (() -> Void)? = nil) {
        
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionFlipFromLeft,
                          animations: {
                            window.rootViewController = viewController
                            
        }, completion: { (_) in
            completion?()
        })
    }
}
