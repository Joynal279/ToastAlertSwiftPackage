![starscream](https://raw.githubusercontent.com/daltoniam/starscream/assets/starscream.jpg)

Starscream is a conforming WebSocket ([RFC 6455](https://datatracker.ietf.org/doc/html/rfc6455)) library in Swift.

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

Once imported package, now you can write code for toast message

```swift
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



* http://twitter.com/acmacalister
* http://austincherry.me
