//
//  OtherCustomAnimator.swift
//  MoviePickerFinal
//
//  Created by Anirudh Bandi on 4/24/18.
//  Copyright © 2018 Anirudh Bandi. All rights reserved.
//

import UIKit

class OtherCustomAnimator : NSObject, UIViewControllerAnimatedTransitioning{
    
    private let duration: TimeInterval = 0.5
    var operation: UINavigationControllerOperation = .push
    var thumbnailFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let presenting = operation == .push
        
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        
        let storyFeedView = presenting ? fromView : toView
        let storyDetailView = presenting ? toView : fromView
        
        
        var initialFrame = presenting ? thumbnailFrame : storyDetailView.frame
        let finalFrame = presenting ? storyDetailView.frame : thumbnailFrame
        
        
        let initialFrameAspectRatio = initialFrame.width / initialFrame.height
        let storyDetailAspectRatio = storyDetailView.frame.width / storyDetailView.frame.height
        if initialFrameAspectRatio > storyDetailAspectRatio {
            initialFrame.size = CGSize(width: initialFrame.height * storyDetailAspectRatio, height: initialFrame.height)
        }
        else {
            initialFrame.size = CGSize(width: initialFrame.width, height: initialFrame.width / storyDetailAspectRatio)
        }
        
        let finalFrameAspectRatio = finalFrame.width / finalFrame.height
        var resizedFinalFrame = finalFrame
        if finalFrameAspectRatio > storyDetailAspectRatio {
            resizedFinalFrame.size = CGSize(width: finalFrame.height * storyDetailAspectRatio, height: finalFrame.height)
        }
        else {
            resizedFinalFrame.size = CGSize(width: finalFrame.width, height: finalFrame.width / storyDetailAspectRatio)
        }
        
        let scaleFactor = resizedFinalFrame.width / initialFrame.width
        let growScaleFactor = presenting ? scaleFactor: 1/scaleFactor
        let shrinkScaleFactor = 1/growScaleFactor
        
        if presenting {
            // Shrink the detail view for the initial frame. The detail view will be scaled to CGAffineTransformIdentity below.
            storyDetailView.transform = CGAffineTransform(scaleX: shrinkScaleFactor, y: shrinkScaleFactor)
            storyDetailView.center = CGPoint(x: thumbnailFrame.midX, y: thumbnailFrame.midY)
            storyDetailView.clipsToBounds = true
            
        }
        
        // Set the initial state of the alpha for the master and detail views so that we can fade them in and out during the animation.
        storyDetailView.alpha = presenting ? 0 : 1
        storyFeedView.alpha = presenting ? 1 : 0
        
        // Add the view that we're transitioning to to the container view that houses the animation.
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: storyDetailView)
        
        // Animate the transition.
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            storyDetailView.alpha = presenting ? 1 : 0
            storyFeedView.alpha = presenting ? 0 : 1
            
            if presenting {
   
                storyFeedView.transform = CGAffineTransform(translationX: storyFeedView.frame.midX - self.thumbnailFrame.midX, y: storyFeedView.frame.midY - self.thumbnailFrame.midY).concatenating(CGAffineTransform(scaleX: growScaleFactor, y: growScaleFactor))
                
                storyDetailView.transform = .identity
            }
            else {
                
                storyFeedView.transform = .identity
                storyDetailView.transform = CGAffineTransform(scaleX: shrinkScaleFactor, y: shrinkScaleFactor)
                
            }
            
            // Move the detail view to the final frame position.
            storyDetailView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
    
}
