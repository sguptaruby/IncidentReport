//
//  IssueDetailVC.swift
//  IncidentReport
//
//  Created by Arpita Jain on 24/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import UIKit

class IssueDetailVC: UIViewController {
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSubCategory: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblLocation: UILabel!
    
    var issueDetailObj: IssueList.Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "SubmitIssueCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubmitIssueCollectionViewCell")
        self.loadDataOnUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
        self.addNavigationView(title: "Incident Summary", subtitle: "", image: "back", isMenu: false, isIssueForm: false)
    }

    func loadDataOnUI(){
        lblStatus.text = issueDetailObj?.status
        lblSubCategory.text = issueDetailObj?.subCategoryName
        lblDescription.text = issueDetailObj?.description
        lblCategory.text = issueDetailObj?.categoryName
        lblLocation.text = issueDetailObj?.location
        if issueDetailObj?.images.count ?? 0 > 0 {
            collectionView.reloadData()
        } else {
            self.view.addBackgroundLabel(collectionView: self.collectionView, text: "No Images")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension IssueDetailVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issueDetailObj?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "SubmitIssueCollectionViewCell", for: indexPath) as! SubmitIssueCollectionViewCell
        
        cell.imageView.layer.cornerRadius = 10
        cell.imageView.layer.masksToBounds = true
        cell.imageView.setImageWith((issueDetailObj?.images[indexPath.row].url)!)
        cell.imageView.contentMode = .scaleAspectFill
        cell.imageView.clipsToBounds = true
        cell.btnCross.isHidden = true
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 3.0
        return CGSize(width: size, height: size)
    }
    
}
