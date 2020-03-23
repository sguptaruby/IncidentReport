//
//  SubmitIssueViewController.swift
//  IncidentReport
//
//  Created by Apple on 20/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import UIKit
import SwAlert

class SubmitIssueViewController: UIViewController {
    
    @IBOutlet weak var btnTakePicture: RoundCornerButton!
    @IBOutlet weak var btnCall: RoundCornerButton!
    @IBOutlet weak var txtViewDescription: UITextView!
    @IBOutlet weak var collectionVW: UICollectionView!
    var subcategory:SubCategory.Data!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        defaultInitialization()
        addDoneButtonOnKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    func defaultInitialization()  {
        btnCall.backgroundColor = .white
        btnCall.titleLabel?.textColor = appThemeColor
        btnCall.layer.borderWidth = 1.0
        btnCall.layer.borderColor = appThemeColor.cgColor
        txtViewDescription.layer.cornerRadius = 10.0
        txtViewDescription.layer.borderWidth = 1
        txtViewDescription.layer.borderColor = UIColor.lightGray.cgColor
        collectionVW.register(UINib(nibName: "SubmitIssueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubmitIssueCollectionViewCell")
        collectionVW.delegate = self
        collectionVW.dataSource = self
        collectionVW.isPagingEnabled = true
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 5
        collectionVW.collectionViewLayout = layout
        txtViewDescription.text = "Here is your place to write description."
        txtViewDescription.textColor = UIColor.lightGray
        txtViewDescription.delegate = self
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -200 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    @IBAction func btntakePicture(sender:UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnMakeCall(sender:UIButton) {
        dialNumber(number: "1110101001")
    }
    
    @IBAction func btnSubmitAction(sender:UIButton) {
        if vailidation() {
            
        }
    }
    
    func vailidation() -> Bool {
        if txtViewDescription.text == "Here is your place to write description." {
            SwAlert.showAlert("Incident Report", message: "Please enter description.", buttonTitle: "OK")
            return false
        }
        if txtViewDescription.text == "" {
            SwAlert.showAlert("Incident Report", message: "Please enter description.", buttonTitle: "OK")
            return false
        }
        return true
    }
    
    func dialNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension SubmitIssueViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            if let imageData = pickedImage.jpeg(.medium) {
                print(imageData.count)
                let image = UIImage(data: imageData)
                if AppManager.share.arrImages.count < Int(AppManager.share.IncidentImageCount) ?? 0 {
                    AppManager.share.arrImages.append(image!)
                    self.collectionVW.reloadData()
                }else{
                    SwAlert.showAlert("Incident Report", message: "You can not upload greter then \(AppManager.share.IncidentImageCount ?? "0") images.", buttonTitle: "OK")
                }
            }
        }
//        if let pickedImage = info[.editedImage] as? UIImage {
//            if let imageData = pickedImage.jpeg(.medium) {
//                print(imageData.count)
//                let image = UIImage(data: imageData)
//                AppManager.share.arrImages.append(image!)
//            }
//        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func deleteImage(sender:UIButton) {
        AppManager.share.arrImages.remove(at: sender.tag)
        collectionVW.reloadData()
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        txtViewDescription.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction()
    {
        txtViewDescription.resignFirstResponder()
    }
}

extension SubmitIssueViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppManager.share.arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionVW.dequeueReusableCell(withReuseIdentifier: "SubmitIssueCollectionViewCell", for: indexPath) as! SubmitIssueCollectionViewCell

        cell.imageView.layer.cornerRadius = 10
        cell.imageView.layer.masksToBounds = true
        cell.imageView.image = AppManager.share.arrImages[indexPath.row]
        cell.imageView.contentMode = .scaleAspectFill
        cell.imageView.clipsToBounds = true
        cell.btnCross.tag = indexPath.row
        cell.btnCross.addTarget(self, action: #selector(deleteImage(sender:)), for: .touchUpInside)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionVW.frame.size.width - space) / 3.0
        return CGSize(width: size, height: size)
    }

}

extension SubmitIssueViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Here is your place to write description."
            textView.textColor = UIColor.lightGray
        }
    }
}
