//
//  File.swift
//  OnboardingKit
//
//  Created by NJ Development on 18/12/25.
//

import Foundation
import UIKit

public protocol NJButtonProtocol: AnyObject {
    func didTap()
}

public final class NJButton: UIButton {
    public weak var delegate: NJButtonProtocol?
    private var iconPosition: NSLayoutConstraint.Axis?
    private var customWidth: CGFloat?
    
    public init(title: String, backgroundColor: UIColor = Colors.primaryRedBase) {
        super.init(frame: .zero)
        setupButton(
            title: title,
            icon: nil,
            iconPosition: nil,
            backgroundColor: backgroundColor,
            width: nil
        )
    }
    
    public init(title: String, icon: UIImage, iconPosition: NSLayoutConstraint.Axis, backgroundColor: UIColor = Colors.primaryRedBase) {
        super.init(frame: .zero)
        setupButton(
            title: title,
            icon: icon,
            iconPosition: iconPosition,
            backgroundColor: backgroundColor,
            width: nil
        )
    }
    
    public init(title: String, width: CGFloat, backgroundColor: UIColor = Colors.primaryRedBase) {
        super.init(frame: .zero)
        setupButton(
            title: title,
            icon: nil,
            iconPosition: nil,
            backgroundColor: backgroundColor,
            width: width
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupButton(
        title: String,
        icon: UIImage?,
        iconPosition: NSLayoutConstraint.Axis?,
        backgroundColor: UIColor = Colors.primaryRedBase,
        width: CGFloat?
    ) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = Typography.subHeading
        self.setTitleColor(Colors.gray800, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = Metrics.medium
        self.isEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let icon = icon, let position = iconPosition {
            self.setImage(icon, for: .normal)
            self.tintColor = .white
            self.iconPosition = position
            adjustIconPosition(with: position)
        }
        
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func adjustIconPosition(with position: NSLayoutConstraint.Axis) {
        self.imageEdgeInsets = iconPosition == .horizontal
        ? UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        : UIEdgeInsets(top: 0, left: 0, bottom: -8, right: 0)
    }
    
    @objc private func didTapButton() {
        delegate?.didTap()
    }
}
