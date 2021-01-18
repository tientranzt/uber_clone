//
//  LocationInputView.swift
//  hello_world
//
//  Created by tientran on 24/12/2020.
//

import UIKit

protocol LocationInputViewDelegate : class {
    func dismissLocationView()
}

class LocationInputView : UIView {
    
    weak var delegate : LocationInputViewDelegate?
    
    private let backButton : UIButton = {
        let button =  UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp-1").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
        
    }()
    
    var user : User? {
        didSet {
            titleLabel.text = user?.fullName as? String
        }
    }
   
    private let titleLabel : UILabel = {
        let lable = UILabel()
        lable.textColor = .darkGray
        lable.font = UIFont.systemFont(ofSize: 14)
        
        return lable
    }()
    
    
    
    private let startLocationIndicatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let linkingView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private let destinationLocationIndicatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var startLocationTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Current location"
        tf.backgroundColor = .systemGroupedBackground
        tf.isEnabled = false
        tf.font =  UIFont.systemFont(ofSize: 14)
        let paddingView = UIView()
        paddingView.setDimensions(height: 8, width: 16 )
        
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    private lazy var destinationLocationTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter the destination"
        tf.backgroundColor = .lightGray
        tf.returnKeyType = .search
        tf.font =  UIFont.systemFont(ofSize: 14)
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 8, width: 16 )
        
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(backButton)
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 44, paddingLeft: 12, width: 24, height: 24)
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: backButton)
        titleLabel.centerX(inView: self)
        
        addSubview(startLocationTextField)
        startLocationTextField.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 30, paddingRight: 30, height: 30)
        
        addSubview(destinationLocationTextField)
        destinationLocationTextField.anchor(top: startLocationTextField.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 30, paddingRight: 30, height: 30)
        
        addSubview(startLocationIndicatorView)
        startLocationIndicatorView.centerY(inView: startLocationTextField, leftAnchor: leftAnchor, paddingLeft: 16)
        startLocationIndicatorView.setDimensions(height: 6, width: 6)
        startLocationIndicatorView.layer.cornerRadius = 6 / 2
        
        addSubview(destinationLocationIndicatorView)
        destinationLocationIndicatorView.centerY(inView: destinationLocationTextField, leftAnchor: leftAnchor, paddingLeft: 16)
        destinationLocationIndicatorView.setDimensions(height: 6, width: 6)
        destinationLocationIndicatorView.layer.cornerRadius = 6 / 2
        
        addSubview(linkingView)
        linkingView.centerX(inView: startLocationIndicatorView)
        linkingView.anchor(top: startLocationIndicatorView.bottomAnchor, bottom: destinationLocationIndicatorView.topAnchor, paddingTop: 6, paddingBottom: 6, width: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleBackButton()  {
        delegate?.dismissLocationView()
    }
    
  
    
    
}


