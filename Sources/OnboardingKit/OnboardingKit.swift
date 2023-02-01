import UIKit

public protocol OnboardingKitDelegate: AnyObject {
    func didTapNextButton(at index: Int)
    func didTapGetStarted()
}

public class OnboardingKit {
    
    private let slides: [Slide]
    private let tintColor: UIColor
    
    public weak var delegate: OnboardingKitDelegate?
    
    private lazy var onboardingViewController: OnboardingViewController = {
        let viewController = OnboardingViewController(slides: slides, tintColor: tintColor)
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        viewController.nextButtonTapped = { [weak self] index in
            self?.delegate?.didTapNextButton(at: index)
        }
        viewController.getStartedButtonTapped = { [weak self] in
            self?.delegate?.didTapGetStarted()
        }
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
