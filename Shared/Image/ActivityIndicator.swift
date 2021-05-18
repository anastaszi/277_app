//
//  ActivityIndicator.swift
//  FashionTrends (iOS)
//
//  Created by Anastasia Zimina on 5/17/21.
//
import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var shouldAnimate: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(shouldAnimate: .constant(true))
    }
}
