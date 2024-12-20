//
//  File.swift
//  
//
//  Created by Asif Khan on 19/12/2024.
//

import UIKit
class TransitionView: UIView{
    
    private var timer: DispatchSourceTimer?
    private let slides: [Slide]
    private var barTintColor: UIColor
    private var index: Int = -1
    var slidesIndex: Int{
        return index
    }
    
    init(barTintColor:UIColor,slides: [Slide]){
        self.slides = slides
        self.barTintColor = barTintColor
        super.init(frame: .zero)
        layout()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
    
    required init?(coder: NSCoder) {
        fatalError(" not been implemented...")
    }
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var barStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 10
        sv.distribution = .fillEqually
        barViews.forEach { barView in
            sv.addArrangedSubview(barView)
        }
        return sv
    }()
    
    private lazy var barViews: [AnimatedBarView] = {
        var views : [AnimatedBarView] = []
        slides.forEach { _ in
            let barView = AnimatedBarView(barColor: barTintColor)
            views.append(barView)
        }
        return views
    }()
    
    private let titleView: TitleView = {
        let view = TitleView()
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [imageView,titleView])
        sv.distribution = .fill
        sv.axis = .vertical
        return sv
    }()
    
  
    
    func start(){
        buildTimerIfNeeded()
        timer?.resume()
    }
    
    func stop(){
        timer?.cancel()
        timer = nil
    }
    
    func buildTimerIfNeeded(){
        guard timer == nil else { return}
        timer = DispatchSource.makeTimerSource()
        timer?.schedule(deadline: .now(),repeating: .seconds(3),leeway: .seconds(1))
        timer?.setEventHandler(handler: { [weak self] in
            DispatchQueue.main.async {
                self?.showNext()
                print("show next")
            }
        })
    }
    
    func showNext(){
        let nextImage : UIImage
        let nextTitle: String
        let nextBarView: AnimatedBarView
        // if index is last show first
        //else show next
        if slides.indices.contains(index + 1){
            nextImage = slides[index + 1].image
            nextTitle = slides[index + 1].title
            nextBarView = barViews[index + 1]
            index += 1
        }else{
            nextImage = slides[0].image
            nextTitle = slides[0].title
            nextBarView = barViews[0]
            index = 0
        }
        UIView.transition(with: self.imageView, duration: 0.5,options: .transitionCrossDissolve) {
            self.imageView.image = nextImage
            self.titleView.setTitle(title: nextTitle)
            nextBarView.startAnimating()
        }
    }
    
    public func layout(){
        self.addSubview(stackView)
        self.addSubview(barStackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        barStackView.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.top.equalTo(snp.topMargin)
            make.height.equalTo(4)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(stackView.snp.height).multipliedBy(0.8)
        }
    }
    
    func handleTap(direction: Direction){
        switch direction{
        case .left:
            barViews[index].reset()
            if barViews.indices.contains(index - 1){
                barViews[index - 1].reset()
            }
            index -= 2
        case .right:
            barViews[index].complete()
        }
        timer?.cancel()
        timer = nil
        start()
    }
}
