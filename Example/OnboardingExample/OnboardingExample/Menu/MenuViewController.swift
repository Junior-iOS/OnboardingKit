//
//  ViewController.swift
//  OnboardingExample
//
//  Created by NJ Development on 16/12/25.
//

import UIKit
import OnboardingKit

final class MenuViewController: UIViewController {
    private let menuView = MenuView()
    
    override func loadView() {
        view = menuView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.delegate = self
    }
}

extension MenuViewController: MenuViewProtocol {
    func didTapOnCheckbox() {
        navigationController?.present(CheckboxViewController(), animated: true)
    }
    
    func didTapOnboarding() {
        let onboardingView = OnboardingView()
        let steps: [(image: UIImage?, text: String)] = [
            (nil, "Bem vindo ao Reminder"),
            (nil, "Para cadastrar seus remédios é super simples"),
            (nil, "Selecione o horário e o medicamento que deseja tomar"),
            (nil, "Iremos te lembrar quando estiver a tempo"),
        ]
        
        onboardingView.presentOnboarding(on: view, with: steps)
    }
}
