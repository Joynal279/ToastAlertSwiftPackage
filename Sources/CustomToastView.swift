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
    
    @Environment(\.colorScheme) public var colorScheme: ColorScheme
    public var toastType: CustomToastStyle
    public var toastTitle: String
    public var toastMessage: String
    //var onCancelTapped: (() -> Void)
    
//    public init(toastType: CustomToastStyle, toastTitle: String, toastMessage: String){
//        self.toastType = toastType
//        self.toastTitle = toastTitle
//        self.toastMessage = toastMessage
//        PoppinsFont.registerFonts()
//    }
    
    @available(iOS 14.0, *)
    public var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: toastType.iconFileName)
                    .foregroundColor(toastType.themeColor)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(toastTitle)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .font(.poppins(.bold, size: 16))
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                    
                    Text(toastMessage)
                        .multilineTextAlignment(.leading)
                        .font(.custom("", fixedSize: 14))
                        .foregroundColor(colorScheme == .light ? Color.black.opacity(0.6) : Color.white.opacity(0.6))
                        .lineLimit(4)
                }//: end VStack
                
                Spacer(minLength: 10)
                
                Button { /// dismiss button
                    //onCancelTapped()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
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
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 20)
    }
    
}

//MARK: - Enum Model
@available(iOS 14.0, *)
public struct ToastView: Equatable {
    public var type: CustomToastStyle
    public var title: String
    public var message: String
    public var duration: Double = 3
    public var yOffset: Double = -30
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
public extension CustomToastStyle {
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
public struct CustomToastModifier: ViewModifier {
    @Binding public var toast: ToastView?
    @State public var workItem: DispatchWorkItem?
    
    public func body(content: Content) -> some View {
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
    
    @ViewBuilder public func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                CustomToastView(
                    toastType: toast.type,
                    toastTitle: toast.title,
                    toastMessage: toast.message)
            }
            .transition(.move(edge: .bottom))
        }
    }
    
    public func showToast() {
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
    
    public func dismissToast() {
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

//MARK: - BackgroundBlurView
@available(iOS 14.0, *)
public struct BackgroundBlurView: UIViewRepresentable {
    public func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {}
}
