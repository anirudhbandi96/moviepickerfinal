//
//  CustomSearchTextField.swift
//  MoviePickerFinal
//
//  Created by Anirudh Bandi on 4/20/18.
//  Copyright © 2018 Anirudh Bandi. All rights reserved.
//

import UIKit
class CustomSearchTextField: UITextField {
    
    private var padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
    let searchImageView : UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private var placeholderString: String? {
        didSet{
            guard let placeholderString = placeholderString else { return }
            let ps = NSAttributedString(string: placeholderString, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
            self.attributedPlaceholder = ps
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
//        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
//        self.attributedPlaceholder = placeholder
        addSubview(searchImageView)
        searchImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingLeft: 10, paddingBottom: -5, paddingRight: 0, paddingTop: 5, width: 20, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
}
