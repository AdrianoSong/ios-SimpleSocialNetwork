//
//  LoginButton.swift
//  Simple Social Network
//
//  Created by Adriano Song on 10/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

struct LoginButton: View {
    
    var title: Text
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: {
            self.action?()
        }) {
            HStack {
                title.foregroundColor(.blueSky)
            }.frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
            }
        .background(Color.white)
        .cornerRadius(40)
        .padding(.horizontal, 16)
    }
}
