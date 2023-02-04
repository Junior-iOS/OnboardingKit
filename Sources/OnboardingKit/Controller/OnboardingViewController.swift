//
//  OnboardingViewController.swift
//  
//
//  Created by Junior Silva on 27/01/23.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let slides: [Slide]
    private let tintColor: UIColor
    
    public var nextButtonTapped: ((Int) -> Void)?
    public var getStartedButtonTapped: (() -> Void)?
    
    private lazy var transitionView: TransitionView = {
        let view = TransitionView(slides: slides, tintColor: tintColor)
        return view
    }()
    
    private lazy var buttonView: ButtonContainerView = {
        let button = ButtonContainerView(tintColor: tintColor)
        button.didTapNextbutton = { [weak self] in
            guard let self = self else { return }
            self.nextButtonTapped?(self.transitionView.slideIndex)
            self.transitionView.handleTap(direction: .right)
        }
        button.didTapGetStartedButton = getStartedButtonTapped
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [transitionView, buttonView])
        stack.axis = .vertical
        return stack
    }()
    
    public init(slides: [Slide], tintColor: UIColor = .systemCyan) {
        self.slides = slides
        self.tintColor = tintColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transitionView.start()
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        buttonView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView(_ :)))
        transitionView.addGestureRecognizer(tap)
    }
    
    @objc private func didTapView(_ tap: UITapGestureRecognizer) {
        let point = tap.location(in: view)
        let screenMiddlePoint = view.frame.size.width / 2
        
        point.x < screenMiddlePoint
        ? transitionView.handleTap(direction: .left)
        : transitionView.handleTap(direction: .right)
    }
    
    public func stopAnimation() {
        transitionView.stop()
    }
}
