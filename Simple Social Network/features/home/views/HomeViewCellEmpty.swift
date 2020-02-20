//
//  HomeViewCellEmpty.swift
//  Simple Social Network
//
//  Created by Adriano Song on 20/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeViewCellEmpty: View {
    
    var body: some View {
        HStack {
            Spacer()
            
            Text("home.screen.empty")
                .font(Font.system(size: 30, weight: .medium, design: .rounded))
                .foregroundColor(.black)
            
            Spacer()
        }
    }
}
