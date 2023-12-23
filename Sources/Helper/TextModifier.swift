//
//  SwiftUIView.swift
//  
//
//  Created by Joynal Abedin on 23/12/23.
//

import SwiftUI

///Text `modifier`
@available(iOS 14.0, *)
struct TextModifier: ViewModifier {
    
    let multiTextAlignment: TextAlignment
    let font: Font
    let foregroundColor: Color
    let lineLimit: Int
    
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(multiTextAlignment)
            .font(font)
            .foregroundColor(foregroundColor)
            .lineLimit(lineLimit)
    }
}

///View extension
@available(iOS 14.0, *)
extension View {
    
    func textVM(
        multiTextAlignment: TextAlignment,
        font: Font,
        foregroundColor: Color,
        lineLimit: Int = 0
        
    ) -> some View {
        
        modifier(TextModifier(
            multiTextAlignment: multiTextAlignment,
            font: font,
            foregroundColor: foregroundColor,
            lineLimit: lineLimit
        ))
        
    }
}

