//
//  FiltersController.swift
//  MoviePickerFinal
//
//  Created by Anirudh Bandi on 4/19/18.
//  Copyright © 2018 Anirudh Bandi. All rights reserved.
//

import UIKit

class FiltersController : UICollectionViewController, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    
    private var selectedFrame : CGRect?
    var otherCustomAnimator : OtherCustomAnimator?
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            
            otherCustomAnimator = OtherCustomAnimator()
            guard let selectedFrame = selectedFrame else { return  nil}
            otherCustomAnimator?.thumbnailFrame = selectedFrame
     
        }
        otherCustomAnimator?.operation = operation
        
        return otherCustomAnimator
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    let titleLabel : UILabel = {
        let tb = UILabel()
        tb.attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Movie Picker", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor: UIColor.black]))
        return tb
    }()
    
    var isYearCellExpanded = false
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.titleView = titleLabel
        
        collectionView?.register(LanguagePickerCell.self, forCellWithReuseIdentifier: "languagePickerCell")
        
        guard let collectionViewLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        collectionViewLayout.sectionInset  = UIEdgeInsets(top: 20, left: view.frame.width * 0.05, bottom: 20, right: view.frame.width * 0.05)
        collectionViewLayout.invalidateLayout()
        
        navigationController?.delegate = self
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1{
             return CGSize(width: self.view.frame.width*0.9, height: 40)
        }else {
            return CGSize(width: self.view.frame.width*0.9, height: 40)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "languagePickerCell", for: indexPath) as! LanguagePickerCell
            return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            self.selectedFrame = collectionView.cellForItem(at: indexPath)?.frame
        
            let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
            selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
            let languageViewController = LanguageViewController()
            navigationController?.pushViewController(languageViewController, animated: true)
            
        }

}

