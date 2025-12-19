//
//  MenuView.swift
//  OnboardingExample
//
//  Created by NJ Development on 17/12/25.
//

import Foundation
import UIKit
import OnboardingKit

protocol MenuViewProtocol: AnyObject {
    func didTapOnboarding()
    func didTapOnCheckbox()
}

final class MenuView: UIView {
    lazy var delegate: MenuViewProtocol? = nil
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Example Menu"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var onboardingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Onboarding", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Metrics.medium
        button.addTarget(self, action: #selector(didTapOnboarding), for: .touchUpInside)
        return button
    }()
    
    private lazy var checkboxButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Checkbox", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Metrics.medium
        button.addTarget(self, action: #selector(didTapOnCheckbox), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupView() {
        backgroundColor = .systemBackground
        addSubviews(titleLabel, onboardingButton, checkboxButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.small),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            onboardingButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            onboardingButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            onboardingButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            onboardingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            onboardingButton.heightAnchor.constraint(equalToConstant: 50),
            
            checkboxButton.topAnchor.constraint(equalTo: onboardingButton.bottomAnchor, constant: Metrics.medium),
            checkboxButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            checkboxButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            checkboxButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didTapOnboarding() {
        delegate?.didTapOnboarding()
    }
    
    @objc private func didTapOnCheckbox() {
        delegate?.didTapOnCheckbox()
    }
}
