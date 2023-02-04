//
//  TitleView.swift
//  
//
//  Created by Junior Silva on 28/01/23.
//

import UIKit

class TitleView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = themeFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let themeFont: UIFont

    init(font: UIFont) {
        self.themeFont = font
        super.init(frame: .zero)
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitleLabel(text: String) {
        titleLabel.text = text
    }
    
    private func layoutView() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.bottom.equalTo(snp.bottom).offset(-36)
            make.leading.equalTo(snp.leading).offset(36)
            make.trailing.equalTo(snp.trailing).offset(-36)
        }
    }
    
}
