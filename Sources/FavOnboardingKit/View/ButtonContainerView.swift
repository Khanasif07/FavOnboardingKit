//
//  File.swift
//  
//
//  Created by Asif Khan on 19/12/2024.
//

import UIKit
class ButtonContainerView: UIView{
    
    var nextBtnDidTap:(()-> Void)?
    var getStartedBtnDidTap:(()-> Void)?
    
    private let viewTintColor: UIColor
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(viewTintColor, for: .normal)
        button.layer.borderWidth = 2.0
        button.layer.borderColor = viewTintColor.cgColor
        button.layer.cornerRadius = 12.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(nextButtontapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = viewTintColor
        button.layer.borderWidth = 2.0
        button.layer.borderColor = viewTintColor.cgColor
        button.layer.cornerRadius = 12.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.shadowColor = viewTintColor.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = .init(width: 4, height: 4)
        button.addTarget(self, action: #selector(getStartedButtontapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var statckView : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nextButton,getStartedButton])
        sv.spacing = 24
        sv.axis = .horizontal
        return sv
    }()
    
    init(tintColor:UIColor){
        self.viewTintColor = tintColor
        super.init(frame: .zero)
        layout()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        layout()
//    }
//    
    required init?(coder: NSCoder) {
        fatalError(" not been implemented...")
    }
    
    public func layout(){
        backgroundColor = .white
        addSubview(statckView)
        statckView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 24, left: 24, bottom: 36, right: 24))
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(getStartedButton.snp.width).multipliedBy(0.5)
        }
    }
    
    @objc func nextButtontapped(){
        nextBtnDidTap?()
    }
    
    @objc func getStartedButtontapped(){
        getStartedBtnDidTap?()
    }
}
