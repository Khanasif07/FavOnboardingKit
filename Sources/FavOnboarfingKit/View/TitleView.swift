//
//  File.swift
//  
//
//  Created by Asif Khan on 19/12/2024.
//

import UIKit
class TitleView: UIView{
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ArialRoundedMTBold", size: 28)
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError(" not been implemented...")
    }
    
    func setTitle(title: String){
        titleLable.text = title
    }
    
    private func layout(){
        addSubview(titleLable)
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.bottom.equalTo(snp.bottom).offset(-36)
            make.leading.equalTo(snp.leading).offset(36)
            make.trailing.equalTo(snp.trailing).offset(-36)
        }
    }
}
