//
//  SkinListViewController.swift
//  MCSkins
//
//  Created by Michael Montoya on 1/30/17.
//  Copyright © 2017 Michael Montoya. All rights reserved.
//

import UIKit

class SkinListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPickerViewDataSource, UIPickerViewDelegate, UISearchBarDelegate, CollectionViewCellDelegate, UITextFieldDelegate {
    
    
    //==================================================
    // MARK: Outlets
    //==================================================
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var pickerTextField: UITextField!
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    //==================================================
    // MARK: Properties
    //==================================================
    
    var searchController: UISearchController?
    var tap: UITapGestureRecognizer!
    var mockArrayOfSkins: [Skin] = []
    var categoryArray = ["Movies", "TV", "Games", "People", "Fantasy", "Mobs", "Other"]
    //==================================================
    // MARK: Lifecycle Functions
    //==================================================


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 1
        self.collectionViewOutlet.addGestureRecognizer(tap)
        
        searchController?.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resign)))
        pickerTextField.delegate = self
        
        // Picker stuff.
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerTextField.inputView = pickerView
        let pickerToolBar = UIToolbar()
        pickerToolBar.barStyle = UIBarStyle.default
        pickerToolBar.isTranslucent = false
        pickerToolBar.barTintColor = UIColor.darkGray
        pickerToolBar.tintColor = UIColor.white
        pickerToolBar.sizeToFit()
        pickerTextField.inputAccessoryView = pickerToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(resign))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(resign))
        categoryButton.setTitle("Movies \u{25BE}", for: .normal)
        pickerToolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        
    }
    
    //==================================================
    // MARK: IB Actions
    //==================================================

    
    @IBAction func categoryButtonTapped(_ sender: Any) {
        

        
    }
    
    @IBAction func searchBarButtonTapped(_ sender: Any) {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.tintColor = UIColor.darkGray
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.searchBar.keyboardType = UIKeyboardType.asciiCapable
        self.searchController?.searchBar.delegate = self
        present(searchController!, animated: true, completion: nil)
    }
    
    //==================================================
    // MARK: Functions
    //==================================================

    
    func resign() {
        self.view.endEditing(true)
        pickerTextField.resignFirstResponder()
    }

    func setUpViews() {
        
        self.pickerTextField.borderStyle = .none
        self.pickerTextField.layer.borderWidth = 0
    
        self.navigationItem.titleView = UIImageView(image:#imageLiteral(resourceName: "SKINS (1)"))
        
    }
    
    func showAlert(skinTitle: String) {
        let alertController = UIAlertController(title: "\(skinTitle)", message: "Download skin?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    

    //==================================================
    // MARK: Collection View DataSource
    //==================================================

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SkinController.shared.mockArrayOfSkins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "skinCell", for: indexPath) as? SkinCollectionViewCell else {
            print("Can't deque reusable cell")
            return UICollectionViewCell() }
        
        cell.delegate = self
        
        let skin = SkinController.shared.mockArrayOfSkins[indexPath.row]
        
        cell.updateWith(skin: skin)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        var collectionViewSize = collectionView.frame.size
//        collectionViewSize.width = collectionViewSize.width/2.0
//        collectionViewSize.height = collectionViewSize.height/2.0
//        return collectionViewSize
        
        let size = collectionView.bounds.size.width / 1
        
        return CGSize(width:size, height: 262)
    }
    
    //==================================================
    // MARK: Picker DataSource
    //==================================================

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryButton.setTitle(categoryArray[row] + " \u{25BE}", for: .normal)
    }
    
    //==================================================
    // MARK: Tap Gesture Recognizers
    //==================================================

    
    func handleTap(gesture: UITapGestureRecognizer) {
        
        if pickerTextField.isFirstResponder {
            view.endEditing(true)
            return
        }
        
        let sender = tap
        
        guard let senderThing = sender?.location(in: self.collectionViewOutlet) else { return }
        if let indexPath = self.collectionViewOutlet?.indexPathForItem(at: senderThing), let cell = self.collectionViewOutlet?.cellForItem(at: indexPath) as? SkinCollectionViewCell {
            
            guard let skinName = cell.skinNameTextField.text else { return }

            
            cell.delegate?.showAlert(skinTitle: skinName)
            
        } else {
            print("collection view was tapped but could not get indexPath")
        }
        
        print("called")
    }
}

protocol CollectionViewCellDelegate: class {
    func showAlert(skinTitle: String)
}
