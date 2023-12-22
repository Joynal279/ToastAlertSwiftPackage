//
//  CustomToastView.swift
//  PriceBDApp
//
//  Created by Joynal Abedin on 7/11/23.
//

import SwiftUI

//MARK: - Custom Toast View
@available(iOS 14.0, *)
public struct ToastViewDemo: View {
    
    @State var toast: ToastView? = nil
    
    public init(){
        PoppinsFont.registerFonts()
    }
    
    public var body: some View {
        ZStack {
            Text("Hello world toast")
                .font(.poppins(.bold, size: 18))
                .onTapGesture {
                    toast = ToastView(type: .success, title: "Success", message: "This is success message", duration: 3.0)
                }
        }
        .toastView(toast: $toast)
        .onAppear {
            
        }
    }
}

