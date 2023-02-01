//
//  TransictionView.swift
//  
//
//  Created by Junior Silva on 27/01/23.
//

import UIKit

class TransitionView: UIView {
    
    private lazy var progressBars: [ProgressBarView] = {
        var views: [ProgressBarView] = []
        slides.forEach { _ in
            views.append(ProgressBarView(barColor: viewTintColor))
        }
        return views
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleView: TitleView = {
        let view = TitleView()
        return view
    }()
    
    private lazy var progressBarStackView: UIStackView = {
        let stack = UIStackView()
        progressBars.forEach { progressBarView in
            stack.addArrangedSubview(progressBarView)
        }
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, titleView])
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    private let slides: [Slide]
    private let viewTintColor: UIColor
    
    private var timer: DispatchSourceTimer?
    private var index: Int = -1

    init(slides: [Slide], tintColor: UIColor) {
        self.slides = slides
        self.viewTintColor = tintColor
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(stackView)
        addSubview(progressBarStackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        progressBarStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.topMargin)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.height.equalTo(4)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(stackView.snp.height).multipliedBy(0.8)
        }
    }
    
    func start() {
        buildtimerIfNeeded()
        timer?.resume()
    }
    
    func stop() {
        timer?.cancel()
        timer = nil
    }
    
    private func buildtimerIfNeeded() {
        guard timer == nil else { return }
        timer = DispatchSource.makeTimerSource()
        timer?.schedule(deadline: .now(), repeating: .seconds(3), leeway: .seconds(1))
        timer?.setEventHandler(handler: { [weak self] in
            DispatchQueue.main.async {
                self?.showNext()
            }
        })
    }
    
    private func showNext() {
        let nextImage: UIImage
        let nextTitle: String
        let nextBarView: ProgressBarView
        
        if slides.indices.contains(index + 1) {
            nextImage = slides[index + 1].image
            nextTitle = slides[index + 1].title
            nextBarView = progressBars[index + 1]
            index += 1
        } else {
            progressBars.forEach({ $0.reset() })
            nextImage = slides[0].image
            nextTitle = slides[0].title
            nextBarView = progressBars[0]
            index = 0
        }
        
        UIView.transition(with: imageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.imageView.image = nextImage
        })
        
        titleView.setTitleLabel(text: nextTitle)
        nextBarView.startAnimating()
    }
    
    public func handleTap(direction: Direction) {
        switch direction {
        case .left:
            progressBars[index].reset()
            
            if progressBars.indices.contains(index - 1) {
                progressBars[index - 1].reset()
            }
            index -= 2
        case .right:
            progressBars[index].complete()
        }
        
        timer?.cancel()
        timer = nil
        start()
    }
}
