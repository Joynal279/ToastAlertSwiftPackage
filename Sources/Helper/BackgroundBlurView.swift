//
//  SwiftUIView.swift
//  
//
//  Created by Joynal Abedin on 23/12/23.
//

import SwiftUI

//MARK: - BackgroundBlurView
@available(iOS 14.0, *)
struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
