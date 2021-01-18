//
//  LocationCell.swift
//  hello_world
//
//  Created by tientran on 25/12/2020.
//

import UIKit

class LocationCell: UITableViewCell {

    private let titleLable : UILabel = {
        let label = UILabel()
        label.text = "Main Street Can Tho city"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let addressLable : UILabel = {
        let label = UILabel()
        label.text = "this this sub description"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [titleLable, addressLable])
        stack.distribution = .fillEqually
        stack.axis =  .vertical
        stack.spacing = 1
        
        addSubview(stack)
        stack.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
