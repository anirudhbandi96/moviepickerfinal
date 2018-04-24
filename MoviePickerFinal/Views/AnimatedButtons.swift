//
//  AnimatedButtons.swift
//  MoviePickerFinal
//
//  Created by Anirudh Bandi on 4/19/18.
//  Copyright © 2018 Anirudh Bandi. All rights reserved.
//


import Foundation
import UIKit
import Lottie

class AnimatedButtons : UIButton {
    var starView : LOTAnimationView!
    
    public func addStarView(){
        self.starView = LOTAnimationView(name: "rating")
        self.starView.contentMode = .scaleAspectFill
        self.starView.animationSpeed = 1.0
        self.starView.alpha = 0.0
        self.starView.loopAnimation = false
        self.starView.isUserInteractionEnabled = false
        self.starView.isExclusiveTouch = false
        self.addSubview(starView)
        starView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 0, width: 0, height: 0)
        starView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        starView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        print(starView.frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addStarView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
