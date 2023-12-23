//
//  ContentView.swift
//  ToastAlertSwiftPackageExample
//
//  Created by Joynal Abedin on 22/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var toast: ToastView? = nil
    
    var body: some View {
        ZStack(content: {
            VStack {
                Text("ShowToast")
            }
            .onTapGesture {
                toast = ToastView(type: .success, title: "Success", message: "This is success message", duration: 3.0)
                //toast = CustomToast(type: .error, title: "Error", message: "This is error message", duration: 5.0)
                //toast = CustomToast(type: .info, title: "Info", message: "This is info message", duration: 3.0)
                //toast = CustomToast(type: .warning, title: "Warning", message: "This is warning message")
            }
        })
        .toastView(toast: $toast)
    }
}

#Preview {
    ContentView()
}
