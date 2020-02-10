//
//  CustomEmailField.swift
//  Simple Social Network
//
//  Created by Adriano Song on 10/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomEmailField: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: () -> Void = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField(
                "",
                text: $text,
                onEditingChanged: editingChanged,
                onCommit: commit)
            .foregroundColor(.white)
            .keyboardType(.emailAddress)
        }
    }
}
