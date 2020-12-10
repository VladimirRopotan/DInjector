# DInjector
 Library for Dependency Injection in Swift
 
- [Requirements](#requirements)
- [Installation](#installation)
- [Documentation]()
- [Usages](#usages)
- [Example](#example)
- [License](#license)


## Requirements

- iOS 10.0+
- Xcode 11+
- Swift 5.0+

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate DInjector into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'DInjector', '~> 0.1'
```

## Usages

First, create your modules in which the objects you want to provide will be written, and implement InjectorModule. In this example, we create module for FirstScreen, and provide viewModel

```swift
import DInjector

class FirstScreenModule: InjectorModule {
    
    @Provide
    var viewModel = { _ in ViewModel() }
    
}
```

Next, need implement AppInjectorProtocol. By standard, DInjector will check the AppDelegate for implementation AppInjectorProtocol, and if AppDelegate doesn't implement AppInjectorProtocol, will be throw fatalError. We implement AppInjectorProtocol and set value for injector, causing static func 'setup', and pass our module object

```swift
import DInjector

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AppInjectorProtocol {
    
    var injector: Injector = Injector.setup(modules: FirstScreenModule())
    
```

All that remains is to inject the viewModel into the ViewController

```swift
import DInjector

class ViewController: UIViewController {

    @Inject
    var viewModel: ViewModel
    
```

Now can use viewmodel 

## Example
You can see [Example project](https://github.com/VladimirRopotan/DInjector/tree/main/Example)

## License

DInjector is released under the MIT license. [See LICENSE](https://github.com/VladimirRopotan/DInjector/blob/main/LICENSE) for details.

