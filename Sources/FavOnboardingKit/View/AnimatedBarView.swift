//
//  File.swift
//  
//
//  Created by Asif Khan on 19/12/2024.
//

import UIKit
import Combine
class AnimatedBarView: UIView{
    
    enum State{
        case clear
        case animating
        case filled
    }
    
    @Published private var state: State = .clear
    private var subscriber = Set<AnyCancellable>()
    private var animator : UIViewPropertyAnimator!
    private let barColor: UIColor
    
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
    
    init(barColor: UIColor){
        self.barColor = barColor
        super.init(frame: .zero)
        setupAnimator()
        layout()
        observe()
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    
    private func setupAnimator(){
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .easeInOut, animations: {
            self.foregroundBarView.transform = .identity
        })
    }
    
    private func observe(){
        $state.sink { [unowned self] state in
            switch state{
            case .clear:
                self.setupAnimator()
                self.foregroundBarView.alpha = 0.0
                self.animator.stopAnimation(false)
            case .animating:
                self.foregroundBarView.transform = .init(scaleX: 0, y: 1.0)
                self.foregroundBarView.transform = .init(translationX: -frame.size.width, y: 0)
                self.foregroundBarView.alpha = 1.0
                self.animator.startAnimation()
            case .filled:
                self.animator.stopAnimation(true)
                self.foregroundBarView.transform = .identity
            }
        }.store(in: &subscriber)
    }
    
    private func layout(){
        addSubview(backgroundBarView)
        backgroundBarView.addSubview(foregroundBarView)
        
        backgroundBarView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        foregroundBarView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundBarView)
        }
    }
    
    func startAnimating(){
        state = .animating
    }
    
    func reset(){
        state = .clear
    }
    
    func complete(){
        state = .filled
    }
    
    required init?(coder: NSCoder) {
        fatalError(" not been implemented...")
    }
}
