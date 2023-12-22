//
//  CustomToastView.swift
//  PriceBDApp
//
//  Created by Joynal Abedin on 7/11/23.
//

import SwiftUI

//MARK: - Custom Toast View
@available(iOS 14.0, *)
public struct ToastView: View {
    
    public init(){}
    
    public var body: some View {
        ZStack {
            Text("Hello world toast")
                .font(.poppins(.bold, size: 18))
        }
        .onAppear {
            PoppinsFont.registerFonts()
        }
    }
}

