//
//  SwiftUIView.swift
//  
//
//  Created by Joynal Abedin on 23/12/23.
//

import SwiftUI

@available(iOS 14.0, *)
struct BackgroundCleanerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
