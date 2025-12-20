//
//  OnboardingView.swift
//  Reminder
//
//  Created by NJ Development on 16/12/25.
//

import Foundation
import UIKit

public final class OnboardingView: UIView {
    private var steps: [(image: UIImage?, text: String)] = []
    private var currentStep = 0
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray100.withAlphaComponent(0.6)
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.tintColor = Colors.gray700
        view.alpha = 0
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Typography.heading
        label.textColor = Colors.gray700
        label.alpha = 0
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.setTitleColor(Colors.primaryRedBase, for: .normal)
        button.addTarget(self, action: #selector(didTapNextStep), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubviews(backgroundView, imageView, messageLabel, nextButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Metrics.medium),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            
            nextButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Metrics.medium),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    public func presentOnboarding(on view: UIView, with steps: [(image: UIImage?, text: String)]) {
        self.steps = steps
        self.currentStep = 0
        updateSteps()

        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        updateSteps()
    }
    
    private func updateSteps(animated: Bool = true) {
        let step = steps[currentStep]
        imageView.image = step.image
        messageLabel.text = step.text
        
        if animated {
            animateTextEntry()
        } else {
            messageLabel.alpha = 1
            messageLabel.transform = .identity
            imageView.alpha = 1
            imageView.transform = .identity
        }
    }
    
    private func animateTextEntry() {
        messageLabel.alpha = 0
        messageLabel.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        imageView.alpha = 0
        imageView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.messageLabel.alpha = 1
            self.messageLabel.transform = .identity
            self.imageView.alpha = 1
            self.imageView.transform = .identity
        }
    }
    
    @objc private func didTapNextStep() {
        guard currentStep < steps.count - 1 else {
            dismiss()
            return
        }
        
        currentStep += 1
        updateSteps()
    }
    
    private func dismiss() {
        removeFromSuperview()
    }
}
