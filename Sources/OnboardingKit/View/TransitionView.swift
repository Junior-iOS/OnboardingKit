//
//  TransictionView.swift
//  
//
//  Created by Junior Silva on 27/01/23.
//

import UIKit

class TransitionView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .systemBlue
    }
    
}
