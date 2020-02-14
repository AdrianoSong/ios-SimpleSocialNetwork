//
//  BaseField.swift
//  Simple Social Network
//
//  Created by Adriano Song on 13/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

struct BaseField: View {
    
    var placeholder: Text
    var imageName: String = ""
    var imageSizes: (width: CGFloat, height: CGFloat) = (20, 20)
    var imageRightSpacing: CGFloat = 16
    var keyboardType: UIKeyboardType = .default
    var captalization: UITextAutocapitalizationType = .none
    @Binding var text: String
    var isSecureField: Bool = false
    var editingChanged: (Bool) -> Void = { _ in }
    var commit: () -> Void = { }
    
    var body: some View {
        HStack(spacing: imageRightSpacing) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: imageSizes.width, height: imageSizes.height)
                .foregroundColor(.white)
                .padding(.leading, 30)
            
            defineTextField()
        }
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
        .background(Color.blueBG)
        .cornerRadius(40)
        .padding(.horizontal, 16)
    }
    
    fileprivate func defineTextField() -> some View {
        
        return ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            
            if isSecureField {
                SecureField("", text: $text)
                .foregroundColor(.white)
            } else {
                TextField(
                    "",
                    text: $text,
                    onEditingChanged: editingChanged,
                    onCommit: commit)
                .foregroundColor(.white)
                .keyboardType(keyboardType)
                .autocapitalization(captalization)
            }
        }
    }
}
