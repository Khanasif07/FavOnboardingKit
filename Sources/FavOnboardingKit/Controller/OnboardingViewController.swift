//
//  OnboardingViewController.swift
//  
//
//  Created by Asif Khan on 19/12/2024.
//

import UIKit
import SnapKit
class OnboardingViewController: UIViewController {
    
    private let slides : [Slide]
    private let tintColor: UIColor
    private let themeFont: UIFont
    
    var nextButtonDidTap: ((Int) -> Void)?
    var getStartedButtonDidTap: (() -> Void)?
    
    private lazy var transitionView: TransitionView = {
        let view = TransitionView(barTintColor: tintColor, slides: slides, themeFont: themeFont)
        return view
    }()
    
    private lazy var buttonContainerView: ButtonContainerView = {
        let view = ButtonContainerView(tintColor: self.tintColor)
        view.nextBtnDidTap = { [weak self] in
            self?.nextButtonDidTap?(self?.transitionView.slidesIndex ?? 0)
            self?.transitionView.handleTap(direction: .right)
        }
        view.getStartedBtnDidTap = {
            
            self.getStartedButtonDidTap?()
        }
        return view
    }()
    
    private lazy var stackview: UIStackView = {
        let view = UIStackView(arrangedSubviews: [transitionView,buttonContainerView])
        view.axis = .vertical
        return view
    }()
    
    
    public init(slides: [Slide], tintColor: UIColor,themeFont: UIFont){
        self.slides = slides
        self.tintColor = tintColor
        self.themeFont = themeFont
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        transitionView.start()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpGesture()
    }
    
    func stopAnimation(){
        transitionView.stop()
    }
    
    private func setupViews(){
       
        view.addSubview(stackview)
        stackview.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        buttonContainerView.snp.makeConstraints { make in
            make.height.equalTo(120)
        }
    }
    
    private func setUpGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTap(_:)))
        transitionView.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewDidTap(_ tap: UITapGestureRecognizer){
        let point = tap.location(in: view)
        let midPoint  = view.frame.size.width/2
        if point.x > midPoint{
            transitionView.handleTap(direction: .right)
        }else{
            transitionView.handleTap(direction: .left)
        }
        print(point)
    }
}
