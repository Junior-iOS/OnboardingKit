import UIKit

public protocol OnboardingKitDelegate: AnyObject {
    func didTapNextButton(at index: Int)
    func didTapGetStarted()
}

public class OnboardingKit {
    
    private let slides: [Slide]
    private let tintColor: UIColor
    private let themeFont: UIFont
    
    public weak var delegate: OnboardingKitDelegate?
    private var rootVC: UIViewController?
    
    private lazy var onboardingViewController: OnboardingViewController = {
        let viewController = OnboardingViewController(slides: slides, tintColor: tintColor, font: themeFont)
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
    
    public init(slides: [Slide],
                tintColor: UIColor = .systemCyan,
                font: UIFont = UIFont(name: "ArialRoundedMTBold", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .bold)) {
        self.slides = slides
        self.tintColor = tintColor
        self.themeFont = font
    }
    
    public func launchOnboarding(controller: UIViewController) {
        rootVC = controller
        rootVC?.present(onboardingViewController, animated: true)
    }
    
    public func dismissOnboarding() {
        onboardingViewController.stopAnimation()
        if rootVC?.presentedViewController == onboardingViewController {
            onboardingViewController.dismiss(animated: true)
        }
    }
}
