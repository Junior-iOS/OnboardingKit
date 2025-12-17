# OnboardingKit

Reusable UIKit onboarding component distributed as a Swift Package.

## Installation

Add via Swift Package Manager:
https://github.com/Junior-iOS/OnboardingKit 

## Usage

```swift
import OnboardingKit

let onboarding = OnboardingView()
onboarding.presentOnboarding(
    on: view,
    with: ["Welcome", "Create reminders", "Stay productive"]
)
