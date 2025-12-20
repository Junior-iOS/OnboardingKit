//
//  File.swift
//  OnboardingKit
//
//  Created by NJ Development on 17/12/25.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
public final class ToggleCheckBox: UIButton {
    private var isChecked: Bool = false
    private let checkedImage = UIImage(systemName: "checkmark.square")
    private let uncheckedImage = UIImage(systemName: "square")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.setImage(uncheckedImage, for: .normal)
        addTarget(self, action: #selector(toggleChecked), for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    @objc private func toggleChecked() {
        isChecked.toggle()
        setImage(isChecked ? checkedImage : uncheckedImage, for: .normal)
    }

    public func hasCheckedState() -> Bool {
        isChecked
    }
}
