![Toast And Alert@3x](https://github.com/Joynal279/ToastAlertSwiftPackage/assets/44470728/26094757-8f42-4500-847a-798ba3720d86)



## Features

- Show toast message (success, error, info, warning)
- Show alert message (with one & two button action)

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding ToastAlert as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/daltoniam/Starscream.git", from: "4.0.0")
]
```

### Import the framework

First thing is to import the package. See the Installation instructions on how to add the swift package manager to your project.

```swift
import ToastAlertSwiftPackage
```

### Write code for Toast Message

Once imported ToastAlertSwiftPackage, now you can write code for toast message

```swift
import SwiftUI
import ToastAlertSwiftPackage

//MARK: - ContentView
struct ContentView: View {
    
    /// `Properties`
    @State private var toast: ToastView? = nil
    
    var body: some View {
        ZStack {
            VStack {
                
                Button("Show Toast") { /// `Toast button`
                    toast = ToastView(type: .success, title: "Success", message: "This is success message", duration: 3.0)
                    //toast = CustomToast(type: .error, title: "Error", message: "This is error message", duration: 5.0)
                    //toast = CustomToast(type: .info, title: "Info", message: "This is info message", duration: 3.0)
                    //toast = CustomToast(type: .warning, title: "Warning", message: "This is warning message")
                }
                .buttonStyle(.borderedProminent)
                
            }//: end VStack
            .padding()
        }
        .toastView(toast: $toast)
        
    }
}
```

Here you can show toast message 4 way. There are 5 parameter where you can modify each others:
1. type
2. title
3. message
4. duration
5. yOffset

### Show Success toast
```swift
toast = ToastView(type: .success, title: "Success", message: "This is success message", duration: 3.0)
```

### Show Error toast
```swift
toast = ToastView(type: .error, title: "Error", message: "This is error message", duration: 3.0)
```

### Show Info toast
```swift
toast = ToastView(type: .info, title: "Info", message: "This is info message", duration: 3.0)
```

### Show Warning toast
```swift
toast = ToastView(type: .warning, title: "Warning", message: "This is warning message", duration: 3.0)
```

### Write code for Alert Message

Once imported ToastAlertSwiftPackage, now you can write code for `alert` message

```swift
import SwiftUI
import ToastAlertSwiftPackage

//MARK: - ContentView
struct ContentView: View {
    
    /// `Properties`
    @State private var presentAlert: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                
                Button("Show Alert") { /// `Alert button`
                    presentAlert = true
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
        
    }
}
```

Here you can show alert message 2 way. There are 2 parameter where you can modify each others:
1. title
2. message

### Show one button alert
```swift
CustomAlert(presentAlert: $presentAlert, alertType: .constant(.oneButton(title: "Do you want to delete?", message: "If you delete this file then you won’t please again check everything"))){
    withAnimation{
        presentAlert.toggle()
    }
    } rightButtonAction: {
        withAnimation{
    presentAlert.toggle()
        }
    }
```

### Show two button alert
```swift
CustomAlert(presentAlert: $presentAlert, alertType: .constant(.twoButton(title: "Do you want to delete?", message: "If you delete this file then you won’t please again check everything"))){
    withAnimation{
        presentAlert.toggle()
    }
    } rightButtonAction: {
        withAnimation{
    presentAlert.toggle()
        }
    }
```
* http://twitter.com/acmacalister
* http://austincherry.me
