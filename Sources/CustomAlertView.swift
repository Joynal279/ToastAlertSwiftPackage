//
//  SwiftUIView.swift
//  
//
//  Created by Joynal Abedin on 23/12/23.
//

import SwiftUI

//MARK: - CustomAlertView
@available(iOS 14.0, *)
public struct CustomAlertView: View {
    
    let bgColor: Color
    let fontColor: Color
    let title: String
    let message: String
    let dismissButton: CustomAlertButton?
    let primaryButton: CustomAlertButton?
    let secondaryButton: CustomAlertButton?
    
    @Environment(\.presentationMode) private var dismiss
    
    public var body: some View {
        ZStack {
            alertView
        }
        .ignoresSafeArea()
    }
    
    // MARK: Private
    var alertView: some View {
        VStack(spacing: .init(height: 20)) {
            titleView
            messageView
            buttonsView
        }
        .padding(.init(height: 24))
        .frame(width: .init(width: 320))
        .background(Color.white)
        .cornerRadius(.init(height: 12))
        .shadow(color: Color.black.opacity(0.2), radius: 16, x: 0, y: 12)
    }
    
    @ViewBuilder
    var titleView: some View {
        if !title.isEmpty {
            Text(title)
                .textVM(multiTextAlignment: .center, font: .poppins(.medium, size: .init(height: 18)), foregroundStyle: Color.black)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    @ViewBuilder
    var messageView: some View {
        if !message.isEmpty {
            Text(message)
                .textVM(multiTextAlignment: .center, font: .poppins(.regular, size: .init(height: 16)), foregroundStyle: Color.gray)
                .lineSpacing(3)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var buttonsView: some View {
        HStack(spacing: 12) {
            if dismissButton != nil {
                dismissButtonView
                
            } else if primaryButton != nil, secondaryButton != nil {
                secondaryButtonView
                primaryButtonView
            }
        }
        .padding(.top, .init(height: 10))
    }
    
    @ViewBuilder
    var primaryButtonView: some View {
        if let button = primaryButton {
            CustomAlertButton(bgColor: button.bgColor, fontColor: button.fontColor, title: button.title) {
                button.action?()
                dismiss.wrappedValue.dismiss()
            }
        }
    }
    
    @ViewBuilder
    var secondaryButtonView: some View {
        if let button = secondaryButton {
            CustomAlertButton(bgColor: button.bgColor, fontColor: button.fontColor, title: button.title) {
                button.action?()
                dismiss.wrappedValue.dismiss()
            }
        }
    }
    
    @ViewBuilder
    var dismissButtonView: some View {
        if let button = dismissButton {
            CustomAlertButton(bgColor: button.bgColor, fontColor: button.fontColor, title: button.title) {
                button.action?()
                dismiss.wrappedValue.dismiss()
            }
        }
    }
    
}


//MARK: - CustomAlertButton
@available(iOS 14.0, *)
public struct CustomAlertButton: View {
    
    let bgColor: Color
    let fontColor: Color
    let title: LocalizedStringKey
    var action: (() -> Void)? = nil
    
    public var body: some View {
        Button {
            action?()
            
        } label: {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .textVM(multiTextAlignment: .center, font: .poppins(.medium, size: .init(height: 14)), foregroundStyle: fontColor)
                .padding(.horizontal, .init(width: 10))
        }
        .frame(width: .init(width: 130), height: .init(height: 40))
        .background(bgColor)
        .cornerRadius(.init(height: 20))
    }
}


//MARK: - CustomAlertModifier
@available(iOS 14.0, *)
struct CustomAlertModifier {
    
    @Binding private var isPresented: Bool
    
    private let bgColor: Color
    private let fontColor: Color
    private let title: String
    private let message: String
    private let dismissButton: CustomAlertButton?
    private let primaryButton: CustomAlertButton?
    private let secondaryButton: CustomAlertButton?
}

@available(iOS 14.0, *)
extension CustomAlertModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                ZStack{
                    Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
                    CustomAlertView(bgColor: bgColor, fontColor: fontColor, title: title, message: message, dismissButton: dismissButton, primaryButton: primaryButton, secondaryButton: secondaryButton)
                }
                .ignoresSafeArea(.all)
                .background(BackgroundCleanerView())
            }
            .ignoresSafeArea(.all)
    }
}

@available(iOS 14.0, *)
extension CustomAlertModifier {
    
    init(bgColor: Color = Color.blue, fontColor: Color = Color.white, title: String = "", message: String = "", dismissButton: CustomAlertButton, isPresented: Binding<Bool>) {
        self.bgColor = bgColor
        self.fontColor = fontColor
        self.title = title
        self.message = message
        self.dismissButton = dismissButton
        
        self.primaryButton = nil
        self.secondaryButton = nil
        
        _isPresented = isPresented
    }
    
    init(bgColor: Color = Color.blue, fontColor: Color = Color.white, title: String = "", message: String = "", primaryButton: CustomAlertButton, secondaryButton: CustomAlertButton, isPresented: Binding<Bool>) {
        self.bgColor = bgColor
        self.fontColor = fontColor
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        
        self.dismissButton = nil
        
        _isPresented = isPresented
    }
}

//MARK: - Extension
@available(iOS 14.0, *)
extension View {
    
    func alert(bgColor: Color = Color.gray, fontColor: Color = Color.white, title: String = "", message: String = "", dismissButton: CustomAlertButton = CustomAlertButton(bgColor: .gray, fontColor: .white, title: "Ok"), isPresented: Binding<Bool>) -> some View {
        let title = NSLocalizedString(title, comment: "")
        let message = NSLocalizedString(message, comment: "")
        
        return modifier(CustomAlertModifier(bgColor: bgColor, fontColor: fontColor, title: title, message: message, dismissButton: dismissButton, isPresented: isPresented))
    }
    
    func alert(bgColor: Color = .gray, fontColor: Color = .white, title: String = "", message: String = "", primaryButton: CustomAlertButton, secondaryButton: CustomAlertButton, isPresented: Binding<Bool>) -> some View {
        let title = NSLocalizedString(title, comment: "")
        let message = NSLocalizedString(message, comment: "")
        
        return modifier(CustomAlertModifier(bgColor: bgColor, fontColor: fontColor, title: title, message: message, primaryButton: primaryButton, secondaryButton: secondaryButton, isPresented: isPresented))
    }
}

/// `Alert`
@available(iOS 14.0, *)
struct DemoView: View {
    
    @State private var isAlertPresented = true
    
    var body: some View {
        ZStack {
            Button {
                isAlertPresented = true
                
            } label: {
                Text("Alert test")
            }
        }
        .alert(title: "Message deleted successfully", message: "You won't able to undo this message beacuse of this mesaage already deleted without no issue . thank you.",
               primaryButton: CustomAlertButton(bgColor: .blue, fontColor: .white, title: "Yes", action: { }),
               secondaryButton: CustomAlertButton(bgColor: .gray, fontColor: .white, title: "No", action: {  }),
               isPresented: $isAlertPresented)
        
        //        .alert(title: "Message deleted successfully", message: "You won't able to undo this message beacuse of this mesaage already deleted without no issue . thank you.",
        //               dismissButton: CustomAlertButton(bgColor: .buttonOrangeColorEB7638, fontColor: .white, title: "Ok", action: {  }),
        //               isPresented: $isAlertPresented)
    }
}

//MARK: - Preview
//#Preview {
//    DemoView()
//}
