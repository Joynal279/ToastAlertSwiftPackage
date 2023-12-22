//
//  File.swift
//
//
//  Created by Joynal Abedin on 22/12/23.
//

import SwiftUI

public enum Poppins: String, CaseIterable {
    case regular = "Poppins-Regular"
    case medium = "Poppins-Medium"
    case semiBold = "Poppins-SemiBold"
    case bold = "Poppins-Bold"
}

@available(iOS 14.0, *)
extension Font {
    public static func poppins(_ poppins: Poppins, size: CGFloat) -> Font {
        return .custom(poppins.rawValue, size: size, relativeTo: .body)
    }
}

public struct PoppinsFont {
    public static func registerFonts(){
        Poppins.allCases.forEach {
            registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: "ttf")
        }
    }
    
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension), let fontDataProvider = CGDataProvider(url: fontURL as CFURL), let font = CGFont(fontDataProvider) else {
            fatalError("couldn't create font from filename")
        }
        
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}



