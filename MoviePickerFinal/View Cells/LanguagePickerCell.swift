//
//  LanguagePickerCell.swift
//  MoviePickerFinal
//
//  Created by Anirudh Bandi on 4/20/18.
//  Copyright © 2018 Anirudh Bandi. All rights reserved.
//

import UIKit

class LanguagePickerCell : UICollectionViewCell {
    
    let pointerImageView : UIImageView = {
        guard let cgImage = #imageLiteral(resourceName: "back").cgImage else { return UIImageView()}
        let iv = UIImageView(image: UIImage(cgImage: cgImage, scale: 1.0, orientation: UIImageOrientation.upMirrored))
        //let iv = UIImageView(image: #imageLiteral(resourceName: "back"))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let title : UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Select Movie Language ", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]))
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.cornerRadius = 5.0
        addSubview(title)
        title.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, paddingTop: 8, width: 0, height: 0)
        
        addSubview(pointerImageView)
        pointerImageView.anchor(top: nil, left: title.rightAnchor, bottom: nil, right: rightAnchor, paddingLeft: 0, paddingBottom: 0, paddingRight: -8, paddingTop: 8, width: 20, height: 20)
        pointerImageView.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
