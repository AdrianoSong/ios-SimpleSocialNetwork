//
//  LoadingView.swift
//  Simple Social Network
//
//  Created by Adriano Song on 17/02/20.
//  Copyright © 2020 Adriano Song. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<CustomActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(
        _ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<CustomActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {

                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)

                VStack {
                    Text("loading.view.title")
                        .font(Font.system(size: 22, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                    CustomActivityIndicator(isAnimating: .constant(true), style: .large)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)

            }
        }
    }
}
