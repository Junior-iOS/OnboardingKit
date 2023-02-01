//
//  ProgressBarView.swift
//  
//
//  Created by Junior Silva on 28/01/23.
//

import UIKit
import SnapKit
import Combine

class ProgressBarView: UIView {
    
    enum State {
        case clear
        case animating
        case filled
    }
    
    private lazy var backgroundBarView: UIView = {
        let view = UIView()
        view.backgroundColor = barColor.withAlphaComponent(0.2)
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var foregroundBarView: UIView = {
        let view = UIView()
        view.backgroundColor = barColor
        view.alpha = 0.0
        return view
    }()
    
    private let barColor: UIColor
    private var animator: UIViewPropertyAnimator!
    
    @Published private var state: State = .clear
    private var subscriber = Set<AnyCancellable>()

    init(barColor: UIColor) {
        self.barColor = barColor
        super.init(frame: .zero)
        layoutViews()
        setupAnimator()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func layoutViews() {
        addSubview(backgroundBarView)
        backgroundBarView.addSubview(foregroundBarView)
        
        backgroundBarView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        foregroundBarView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundBarView)
        }
    }
    
    private func setupAnimator() {
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .easeInOut, animations: {
            self.foregroundBarView.transform = .identity
        })
    }
    
    private func observe() {
        $state.sink { [unowned self] state in
            switch state {
            case .clear:
                setupAnimator()
                foregroundBarView.alpha = 0
                animator.stopAnimation(false)
            case .animating:
                foregroundBarView.transform = .init(scaleX: 0, y: 1.0)
                foregroundBarView.transform = .init(translationX: -frame.size.width, y: 0)
                foregroundBarView.alpha = 1
                animator.startAnimation()
            case .filled:
                animator.stopAnimation(true)
                foregroundBarView.transform = .identity
            }
        }.store(in: &subscriber)
    }
    
    public func startAnimating() {
        state = .animating
    }
    
    public func reset() {
        state = .clear
    }
    
    public func complete() {
        state = .filled
    }
}
