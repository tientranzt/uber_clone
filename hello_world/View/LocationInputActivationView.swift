//
//  LocationInputActivationView.swift
//  hello_world
//
//  Created by tientran on 23/12/2020.
//

import UIKit
protocol LocationInputActivationViewDelegate : class {
    func presentLocationInputView()
}
class LocationInputActivationView : UIView {
    
    weak var delegate : LocationInputActivationViewDelegate?
    
    private let indicatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    private let placeholderLabel : UILabel = {
        let label = UILabel()
        label.text = "Where to ?"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .white
        addShadow()
        addSubview(indicatorView)
        indicatorView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 16)
        indicatorView.setDimensions(height: 6, width: 6)
        addSubview(placeholderLabel)
        placeholderLabel.centerY(inView: self, leftAnchor: indicatorView.rightAnchor, paddingLeft: 20)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleShowLocationInputView))
        addGestureRecognizer(tap)
    }
    
    @objc func handleShowLocationInputView() {
        delegate?.presentLocationInputView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
