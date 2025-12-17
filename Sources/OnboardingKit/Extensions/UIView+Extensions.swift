//
//  File.swift
//  OnboardingKit
//
//  Created by NJ Development on 16/12/25.
//

import Foundation
import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

    static var identifier: String {
        String(describing: self)
    }
}
