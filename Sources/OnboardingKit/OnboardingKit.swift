import UIKit

public class OnboardingKit {
    
    private let slides: [Slide]
    private let tintColor: UIColor
    
    private lazy var onboardingViewController: OnboardingViewController = {
        let viewController = OnboardingViewController(slides: slides, tintColor: tintColor)
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }()
    
    public init(slides: [Slide], tintColor: UIColor = .systemCyan) {
        self.slides = slides
        self.tintColor = tintColor
    }
    
    public func launchOnboarding(controller: UIViewController) {
        controller.present(onboardingViewController, animated: true)
    }
    
    public func dismissOnboarding() {
        
    }
    
}
