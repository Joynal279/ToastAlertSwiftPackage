//
//  SwiftUIView.swift
//  
//
//  Created by Joynal Abedin on 22/12/23.
//

import SwiftUI

//MARK: - Custom Toast View
@available(iOS 14.0, *)
public struct CustomToastView: View {
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    public let toastType: CustomToastStyle
    public let toastTitle: String
    public let toastMessage: String
    public let onCancelTapped: (() -> Void)
        
    @available(iOS 14.0, *)
    public var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: toastType.iconFileName)
                    .foregroundColor(toastType.themeColor)
                
                VStack(alignment: .leading, spacing: .init(height: 5)) {
                    
                    Text(toastTitle)
                        .textVM(multiTextAlignment: .leading, font: .poppins(.semiBold, size: .init(height: 16)), foregroundStyle: colorScheme == .light ? Color.black : Color.white)
                    
                    Text(toastMessage)
                        .textVM(multiTextAlignment: .leading, font: .poppins(.regular, size: .init(height: 14)), foregroundStyle: colorScheme == .light ? Color.black : Color.white)
                        .foregroundColor(Color.black.opacity(0.6))
                        .lineLimit(4)
                    
                }//: end VStack
                
                Spacer(minLength: .init(height: 10))
                
                Button { /// dismiss button
                    onCancelTapped()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                }
            }
            .padding()
        }
        .background(BackgroundBlurView())
        .overlay(
            Rectangle()
                .fill(toastType.themeColor)
                .frame(width: 6)
                .clipped()
            , alignment: .leading
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(.init(height: 10))
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, .init(width: 20))
    }
    
}

//MARK: - Enum Model
@available(iOS 14.0, *)
public struct ToastView: Equatable {
    var type: CustomToastStyle
    var title: String
    var message: String
    var duration: Double = 3
    var yOffset: Double = -30
    
    public init(type: CustomToastStyle, title: String, message: String, duration: Double = 3.0, yOffset: Double = -30.0) {
        self.type = type
        self.title = title
        self.message = message
        self.duration = duration
        self.yOffset = yOffset
        
        PoppinsFont.registerFonts()
    }
}

//MARK: - Enum
@available(iOS 14.0, *)
public enum CustomToastStyle {
    case error
    case warning
    case success
    case info
}

@available(iOS 14.0, *)
extension CustomToastStyle {
    var themeColor: Color {
        switch self {
        case .error:
            return Color.red
        case .warning:
            return Color.orange
        case .success:
            return Color.green
        case .info:
            return Color.blue
        }
    }
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}

//MARK: - Custom Toast Modifier
@available(iOS 14.0, *)
struct CustomToastModifier: ViewModifier {
    @Binding var toast: ToastView?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: toast?.yOffset ?? -30)
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                CustomToastView(
                    toastType: toast.type,
                    toastTitle: toast.title,
                    toastMessage: toast.message, onCancelTapped: {
                        dismissToast()
                    })
            }
            .transition(.move(edge: .bottom))
        }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

//MARK: - View Extension
@available(iOS 14.0, *)
public extension View {
    func toastView(toast: Binding<ToastView?>) -> some View {
        self.modifier(CustomToastModifier(toast: toast))
    }
}

////MARK: - Preview
//@available(iOS 14.0, *)
//#Preview {
//    VStack {
//        CustomToastView(toastType: .error, toastTitle: "Error", toastMessage: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ") {}
//        
//        CustomToastView(toastType: .info, toastTitle: "Info", toastMessage: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ") {}
//        CustomToastView(toastType: .success, toastTitle: "Success", toastMessage: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ") {}
//        CustomToastView(toastType: .warning, toastTitle: "Warning", toastMessage: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ") {}
//    }
//}

