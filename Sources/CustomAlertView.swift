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
            return 150
        case .twoButton:
            return 150
        }
    }
    
}

/// A boolean State variable is required in order to present the view.
@available(iOS 14.0, *)
public struct CustomAlert: View {
    
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
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(height: 25)
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                    .padding(.horizontal, 16)
                
                // alert message
                Text(alertType.message())
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
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
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        
                    case .twoButton:
                        // left button
                        Button {
                            leftButtonAction?()
                        } label: {
                            Text(alertType.leftActionText)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
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
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.pink)
                                .multilineTextAlignment(.center)
                                .padding(15)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 55)
                .padding([.horizontal, .bottom], 0)
                
            }
            .frame(width: 270, height: alertType.height())
            .background(
                Color.white
            )
            .cornerRadius(4)
        }
        .zIndex(2)
    }
}
