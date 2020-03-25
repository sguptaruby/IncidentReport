//
//  IssueListVC.swift
//  IncidentReport
//
//  Created by Arpita Jain on 20/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//
//ye mera code hai
import UIKit

class IssueListVC: UIViewController {
    @IBOutlet weak var issueTableView: UITableView!
    var issueArray = [[String: Any]]()
    var dictNew = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for index in 0..<AppManager.share.category.data.count {
            print(AppManager.share.category.data[index].categoryName)
        }
        issueTableView.register(UINib(nibName: "IssueListCell", bundle: nil), forCellReuseIdentifier: "IssueListCell")
        issueTableView.register(UINib(nibName: "IssueListHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "IssueListHeaderCell")

        issueListApiCall()
        // Do any additional setup after loading the view.
    }

    func issueListApiCall() {
        let dict = ["Userid":AppManager.share.user.data.userID]
        IssueListModel.share.getIssueList(param: dict, vc: self, successClosure: { (data) in
            if let dict = data as? [String:Any] {
                let issue = Issue(json: dict)
                var arrayName = [Any]()
                self.dictNew = dict as [String: Any]
                if let catArrray = AppManager.share.category {
                    for index in 0..<catArrray.data.count {
                        let cat = catArrray.data[index].categoryName
                        if let data = self.dictNew["Data"] as? NSArray {
                            for indexVal in 0..<data.count {
                                let diction = data[indexVal] as! NSDictionary
                                let cat1 = diction.value(forKey: "CategoryName") as? String ?? ""
                                if cat1 == cat {
                                    arrayName.append([data[indexVal]])//addingObjects(from: [data[indexVal]])
                                }
                            }
                        }
                        self.issueArray.append([cat : arrayName])
                        
                    }
                    
                }
                
                self.issueTableView.reloadData()
            }
        }) { (error) in
            
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

extension IssueListVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return issueArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dict = issueArray[section] as NSDictionary
        let key = dict.allKeys
        let keyVal = key[0]
        let arrayVal = dict[keyVal] as! NSArray
        return arrayVal.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueListCell") as! IssueListCell
        cell.selectionStyle = .none
        
        let dict = issueArray[indexPath.section] as NSDictionary
        let key = dict.allKeys
        let keyVal = key[0]
        let arrayVal = dict[keyVal] as! NSArray
        let sfd = arrayVal[indexPath.row] as! NSArray
        let dict1 = sfd[0] as! NSDictionary
        let createdOn = dict1["CreatedOn"] as? String ?? ""
        let description = dict1["Description"] as? String ?? "No Description"

        cell.lblHeading.text  = description//dict["Description"] as? String ?? ""
        cell.lblDate.text  = createdOn//dict["Description"] as? String ?? ""
        return cell
        
    }
  
}

extension IssueListVC : UITableViewDelegate {

func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "IssueListHeaderCell") as! IssueListHeaderCell
    
    let dict = issueArray[section] as NSDictionary
    let key = dict.allKeys
    let keyVal = key[0]

    header.labelHeader.text = keyVal as? String ?? ""//AppManager.share.category.data[section].categoryName
    header.imageViewHeader.setImageWith(AppManager.share.category.data[section].icon)
    return header
}
func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
