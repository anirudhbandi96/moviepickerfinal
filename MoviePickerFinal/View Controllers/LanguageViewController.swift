//
//  LanguageViewController.swift
//  MoviePickerFinal
//
//  Created by Anirudh Bandi on 4/20/18.
//  Copyright © 2018 Anirudh Bandi. All rights reserved.
//

import UIKit

class LanguageCell : UICollectionViewCell {
    let label : UILabel = {
        let tf = UILabel()
        tf.textColor = UIColor.black
        tf.textAlignment = .center
        return tf
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 5, paddingBottom: 0, paddingRight: -5, paddingTop: 0, width: 0, height: 0)
        backgroundColor = UIColor.white
        layer.cornerRadius = 3.0
    }
    
    func initialize(){
        backgroundColor = UIColor.white
        label.textColor = UIColor.black
    }
    func selected(){
        backgroundColor = UIColor.rgb(red: 178, green: 0, blue: 0)
        label.textColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LanguageViewController : UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let languageCell = "languageCell"
    let collectionView : UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        return cv
    }()
    
    var filteredLanguageArray = [[String]]()
    
    var languageArray = [[String]]()
    var selectedLanguage : String!
    var selectedIndexPath : IndexPath!
    var buttonFlag = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(textField)
        textField.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, paddingTop: 20, width: 0, height: 40)
        view.addSubview(cancelButton)
        cancelButton.anchor(top: nil, left: textField.rightAnchor, bottom: nil, right: view.rightAnchor, paddingLeft: 10, paddingBottom: 0, paddingRight: -10, paddingTop: 0, width: 60, height: 40)
        cancelButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        
        navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true
    
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.anchor(top: textField.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, paddingTop: 10, width: 0, height: 0)
        
        collectionView.register(LanguageCell.self, forCellWithReuseIdentifier: languageCell)
        collectionView.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        
        guard let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        collectionViewLayout.sectionInset  = UIEdgeInsets(top: 10, left: view.frame.width * 0.05, bottom: 20, right: view.frame.width * 0.05)
        collectionViewLayout.invalidateLayout()
        
        DataService.instance.getLanguageCodes { (data) in
            var data = data
            data.removeFirst()
            for i in data{
                if !i[0].contains(","){
                self.filteredLanguageArray.append(i)
                self.languageArray.append(i)
                }
            }
            self.textField.isEnabled = true
            self.collectionView.reloadData()
        }
        
    }
    let textField : CustomSearchTextField = {
        let tf = CustomSearchTextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Search Language"
        tf.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.isEnabled = false
        return tf
    }()
    
    @objc func handleTextChange(){
        if let text = self.textField.text, text.count > 0{
            self.filteredLanguageArray = self.languageArray.filter({
                $0[0].lowercased().contains(text.lowercased())
            })
            collectionView.reloadData()
        }else{
            self.filteredLanguageArray = self.languageArray
            collectionView.reloadData()
        }
    }
    
    let cancelButton : UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5.0
        button.setTitle("cancel", for: .normal)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        button.backgroundColor = UIColor.rgb(red: 178, green: 0, blue: 0)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    @objc func dismissView(){
        if buttonFlag == 0{
            print("added a new language filter with language:" + selectedLanguage)
            guard let navController  = navigationController else { return }
            guard let filtersController = navController.viewControllers[navController.viewControllers.count-2] as? FiltersController   else { return }
            guard let languageFilterCell = filtersController.collectionView?.cellForItem(at: IndexPath(item: 2, section: 0)) as? LanguagePickerCell else { return }
            let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Selected Language: ", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]))
            attributedText.append(NSAttributedString(string: selectedLanguage, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 15, green: 221, blue: 175)]))
            languageFilterCell.title.attributedText =  attributedText
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredLanguageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let languageName = filteredLanguageArray[indexPath.item][0]
        if languageName.count > 0 && languageName.count <= 10 {
            return CGSize(width: 100, height: 30)
        }else if languageName.count > 10 && languageName.count < 20{
            return CGSize(width: 180, height:30)
        }else{
            return CGSize(width: 340, height: 30)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: languageCell, for: indexPath) as! LanguageCell
        cell.label.text = self.filteredLanguageArray[indexPath.item][0]
        let languageName = self.filteredLanguageArray[indexPath.item][0]
        if languageName != selectedLanguage {
        cell.initialize()
        }else{
            cell.selected()
        }
        return cell
    }
    fileprivate func cancelToAdd(){
        
        buttonFlag = 0
        self.cancelButton.backgroundColor = UIColor.rgb(red: 15, green: 221, blue: 175)
        self.cancelButton.setTitle("add", for: .normal)
        
        
    }
    fileprivate func addToCancel(){
        buttonFlag = 1
        self.cancelButton.backgroundColor = UIColor.rgb(red: 178, green: 0, blue: 0)
        self.cancelButton.setTitle("cancel", for: .normal)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! LanguageCell
        if cell.label.text == selectedLanguage {
            cell.backgroundColor = UIColor.white
            cell.label.textColor = UIColor.black
            self.selectedLanguage = nil
            self.selectedIndexPath = nil
            self.addToCancel()
        }else {
            
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                collectionView.performBatchUpdates({
                    let cell = collectionView.cellForItem(at: indexPath) as! LanguageCell
                    cell.superview?.bringSubview(toFront: cell)
                    cell.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                }) { (success) in
                }
            }) { (bool) in
                UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    collectionView.performBatchUpdates({
                        let cell = collectionView.cellForItem(at: indexPath) as! LanguageCell
                        cell.transform = CGAffineTransform.identity
                    }, completion: nil)
                }, completion: nil)
            }
            
            
            if let index = selectedIndexPath {
                if let previousCell = collectionView.cellForItem(at: index) as? LanguageCell{
            previousCell.backgroundColor = UIColor.white
            previousCell.label.textColor = UIColor.black
                }
            }
            selectedLanguage = cell.label.text
            selectedIndexPath = indexPath
            cell.backgroundColor = UIColor.rgb(red: 178, green: 0, blue: 0)
            cell.label.textColor = UIColor.white
            self.cancelToAdd()
            
        }
    }
}
