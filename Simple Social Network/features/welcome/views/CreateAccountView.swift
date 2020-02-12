//
//  CreateAccountView.swift
//  Simple Social Network
//
//  Created by Adriano Song on 12/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

struct CreateAccountView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.babyBlue, .blueSky]),
                startPoint: .top,
                endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("i ma here to create")
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Dissmiss Here")
                }
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView().environment(\.locale, .init(identifier: "en"))//pt-BR
    }
}
