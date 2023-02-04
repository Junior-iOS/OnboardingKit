# OnboardingKit

    OnboardingKit provides an onboarding flow that is simple and easy to implement.

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)

## Requirements

- iOS 15.0 or later
- Xcode 13.0 or later
- Swift 5.0 or later


## Installation
There are two ways to use OnboardingKit in your project:
- using Swift Package Manager
- manual install (build frameworks or embed Xcode Project)

### Swift Package Manager

To integrate OnboardingKit into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Junior-iOS/OnboardingKit.git", .upToNextMajor(from: "1.0.0"))
]
```

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

### Manually

If you prefer not to use Swift Package Manager, you can integrate OnboardingKit into your project manually.

---

## Usage

### Quick Start

```swift
import UIKit
import OnboardingKit

class ViewController: UIViewController {
    
    private var onboardingKit: OnboardingKit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentOnboardingKit()
    }
    
    private func presentOnboardingKit() {
        DispatchQueue.main.async {
            self.onboardingKit = OnboardingKit(
                slides: [
                    Slide(image: UIImage(named: "macStudio")!, title: "Stunningly compact. Extensive connectivity. Outrageous performance. Ready to dive in?"),
                    Slide(image: UIImage(named: "iPad")!, title: "Supercharged by the Apple M1 chip. 12MP Ultra Wide front camera with Center Stage."),
                    Slide(image: UIImage(named: "airPodMax")!, title: "Introducing AirPods Max — The ultimate personal listening experience is here."),
                    Slide(image: UIImage(named: "macMini")!, title: "Mac mini with M2 packs the speed you need to get more done faster."),
                    Slide(image: UIImage(named: "macBook")!, title: "Supercharged by M2 Pro or M2 Max, MacBook Pro takes its power and efficiency further than ever."),
                ],
                tintColor: UIColor(red: 220/255, green: 20/255, blue: 60/255, alpha: 1)
            )
            
            self.onboardingKit?.delegate = self
            self.onboardingKit?.launchOnboarding(controller: self)
        }
    }
    
    private func createWindowScene(with viewController: UIViewController) {
        let foregroundScenes = UIApplication.shared.connectedScenes.filter({
            $0.activationState == .foregroundActive
        })
        
        let window = foregroundScenes
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?
            .windows
            .filter({ $0.isKeyWindow })
            .first
        
        guard let uiWindow = window else { return }
        uiWindow.rootViewController = viewController
        
        UIView.transition(with: uiWindow, duration: 0.3, options: [.transitionCrossDissolve], animations: nil)
    }
}
```

## Credits

- NJ Development® by Junior Silva

