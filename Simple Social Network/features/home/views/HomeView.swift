//
//  HomeView.swift
//  Simple Social Network
//
//  Created by Adriano Song on 12/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.babyBlue, .blueSky]),
                startPoint: .top,
                endPoint: .bottom)
            
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Welcome home")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.locale, .init(identifier: "en"))//pt-BR
    }
}
