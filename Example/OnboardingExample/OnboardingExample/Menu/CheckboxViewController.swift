//
//  CheckboxViewController.swift
//  OnboardingExample
//
//  Created by NJ Development on 18/12/25.
//

import UIKit
import OnboardingKit

class CheckboxViewController: UIViewController {
    
    private lazy var checkboxButton: ToggleCheckBox = {
        let button = ToggleCheckBox()
        button.tintColor = Colors.primaryBlueBase
        button.layer.borderColor = Colors.primaryBlueBase.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(checkboxButton)
        
        NSLayoutConstraint.activate([
            checkboxButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkboxButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            checkboxButton.heightAnchor.constraint(equalToConstant: 50),
            checkboxButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
