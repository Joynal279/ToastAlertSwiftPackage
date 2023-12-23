//
//  SwiftUIView.swift
//
//
//  Created by Joynal Abedin on 23/12/23.
//

import SwiftUI
import Combine
import SwiftUI

/// Alert type
public enum AlertType {
    
    case oneButton(title: String = "One button title", message: String = "One button description message")
    case twoButton(title: String = "Two button title", message: String = "Two button description message")
    
    func title() -> String {
        switch self {
        case .oneButton(title: let title, _):
            return title
            
        case .twoButton(title: let title, _):
            return title
        }
    }
    
    func message() -> String {
        switch self {
        case .oneButton(_, message: let message):
            return message
            
        case .twoButton(_, message: let message):
            return message
        }
    }
    
    /// Left button action text for the alert view
    var leftActionText: String {
        switch self {
        case .oneButton:
            return "OK"
        case .twoButton:
            return "Cancel"
        }
    }
    
    /// Right button action text for the alert view
    var rightActionText: String {
        switch self {
        case .oneButton:
            return "OK"
        case .twoButton:
            return "Yes"
        }
    }
    
    func height() -> CGFloat {
        switch self {
        case .oneButton:
            return .init(height: 150)
        case .twoButton:
            return .init(height: 150)
        }
    }
    
}

/// A boolean State variable is required in order to present the view.
@available(iOS 14.0, *)
public struct CustomAlert: View {
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    /// Flag used to dismiss the alert on the presenting view
    @Binding var presentAlert: Bool
    
    /// The alert type being shown
    @Binding var alertType: AlertType
    
    var leftButtonAction: (() -> ())?
    var rightButtonAction: (() -> ())?
    
    let verticalButtonsHeight: CGFloat = 80
    
    public init(presentAlert: Binding<Bool>, alertType: Binding<AlertType>, isShowVerticalButtons: Bool = false, leftButtonAction: ( () -> Void)? = nil, rightButtonAction: ( () -> Void)? = nil) {
        self._presentAlert = presentAlert
        self._alertType = alertType
        self.leftButtonAction = leftButtonAction
        self.rightButtonAction = rightButtonAction
    }
    
    public var body: some View {
        
        ZStack {
            
            // faded background
            Color.black.opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                
                // alert title
                Text(alertType.title())
                    .textVM(multiTextAlignment: .center, font: .poppins(.semiBold, size: .init(height: 16)), foregroundStyle: colorScheme == .light ? Color.black : Color.white)
                    .frame(height: .init(height: 25))
                    .padding(.top, .init(height: 16))
                    .padding(.bottom, .init(height: 8))
                    .padding(.horizontal, .init(width: 16))
                
                // alert message
                Text(alertType.message())
                    .textVM(multiTextAlignment: .center, font: .poppins(.regular, size: .init(height: 14)), foregroundStyle: colorScheme == .light ? Color.black : Color.white)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .padding(.horizontal, .init(width: 16))
                    .padding(.bottom, .init(height: 16))
                    .minimumScaleFactor(0.5)
                
                Divider()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)
                    .padding(.all, 0)
                
                HStack(spacing: 0) {
                    
                    switch alertType {
                    case .oneButton:
                        // left button
                        Button {
                            leftButtonAction?()
                        } label: {
                            Text(alertType.leftActionText)
                                .textVM(multiTextAlignment: .center, font: .poppins(.medium, size: .init(height: 16)), foregroundStyle: colorScheme == .light ? Color.blue : Color.blue)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        
                    case .twoButton:
                        // left button
                        Button {
                            leftButtonAction?()
                        } label: {
                            Text(alertType.leftActionText)
                                .textVM(multiTextAlignment: .center, font: .poppins(.medium, size: .init(height: 16)), foregroundStyle: colorScheme == .light ? Color.black : Color.white)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        Divider()
                            .frame(minWidth: 0, maxWidth: 0.5, minHeight: 0, maxHeight: .infinity)
                        
                        // right button (default)
                        Button {
                            rightButtonAction?()
                        } label: {
                            Text(alertType.rightActionText)
                                .textVM(multiTextAlignment: .center, font: .poppins(.medium, size: .init(height: 16)), foregroundStyle: colorScheme == .light ? Color.blue : Color.blue)
                                .padding(.init(height: 15))
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .init(height: 55))
                .padding([.horizontal, .bottom], 0)
                
            }
            .frame(width: .init(height: 270), height: alertType.height())
            .background(
                BackgroundBlurView()
            )
            .cornerRadius(.init(height: 10))
        }
        .zIndex(2)
    }
}
