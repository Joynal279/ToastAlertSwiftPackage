//
//  ContentView.swift
//  ToastAlertSwiftPackageExample
//
//  Created by Joynal Abedin on 22/12/23.
//

import SwiftUI
import ToastAlertSwiftPackage

//MARK: - ContentView
struct ContentView: View {
    
    /// `Properties`
    @State private var toast: ToastView? = nil
    @State private var presentAlert: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                
                Button("Show Alert") { /// `Alert button`
                    presentAlert = true
                }
                .buttonStyle(.borderedProminent)
                
                Button("Show Toast") { /// `Toast button`
                    toast = ToastView(type: .success, title: "Success", message: "This is success message", duration: 3.0)
                    //toast = CustomToast(type: .error, title: "Error", message: "This is error message", duration: 5.0)
                    //toast = CustomToast(type: .info, title: "Info", message: "This is info message", duration: 3.0)
                    //toast = CustomToast(type: .warning, title: "Warning", message: "This is warning message")
                }
                .buttonStyle(.borderedProminent)
                
            }//: end VStack
            .padding()
            
            /// `Present Alert`
            if presentAlert{
                //CustomAlert(presentAlert: $presentAlert, alertType: .constant(.oneButton(title: "Do you want to delete?", message: "If you delete this file then you won’t please again check everything"))){ withAnimation{  presentAlert.toggle() }
                //} rightButtonAction: { withAnimation{ presentAlert.toggle() } }
                
                CustomAlert(presentAlert: $presentAlert, alertType: .constant(.twoButton(title: "Do you want to delete?", message: "If you delete this file then you won’t please again check everything"))){
                    withAnimation{
                        presentAlert.toggle()
                    }
                } rightButtonAction: {
                    withAnimation{
                        presentAlert.toggle()
                    }
                }
            }//: End present alert
        }
        .toastView(toast: $toast)
        
    }
}

//MARK: - Preview
#Preview {
    ContentView()
}
