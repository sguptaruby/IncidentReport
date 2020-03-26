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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        issueTableView.register(UINib(nibName: "IssueListCell", bundle: nil), forCellReuseIdentifier: "IssueListCell")
        issueTableView.register(UINib(nibName: "IssueListHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "IssueListHeaderCell")
        
        issueListApiCall()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
        self.addNavigationView(title: "List of issue", subtitle: "", image: "menu", isMenu: false, isIssueForm: false)
    }
    
    
    func issueListApiCall() {
        let dict = ["Userid":AppManager.share.user.data.userID]
        IssueListModel.share.getIssueList(param: dict, vc: self, successClosure: { (data) in
            if let dict = data as? [String:Any] {
                AppManager.share.issue = IssueList(json: dict)
                var arrayName = [IssueList.Data]()
                if let catArrray = AppManager.share.category {
                    for index in 0..<catArrray.data.count {
                        let cat = catArrray.data[index].categoryName
                        let data = AppManager.share.issue.data
                        for indexVal in 0..<data.count {
                            let cat1 = data[indexVal].categoryName
                            if cat1 == cat {
                                arrayName.append(data[indexVal])
                            }
                        }
                        self.issueArray.append([cat : arrayName])
                        arrayName.removeAll()
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
        let issueListArr = dict[keyVal] as! [IssueList.Data]
        return issueListArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueListCell") as! IssueListCell
        cell.selectionStyle = .none
        
        let dict = issueArray[indexPath.section] as NSDictionary
        let key = dict.allKeys
        let keyVal = key[0]
        let issueListArr = dict[keyVal] as! [IssueList.Data]
        let createdOn = issueListArr[indexPath.row].createdOn
        let description = issueListArr[indexPath.row].description
        
        cell.lblHeading.text  = description ?? "No Description"
        cell.lblDate.text  = checkDayType(dateStr: createdOn  ?? "")
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = IssueDetailVC.loadFromNib()
        let dict = issueArray[indexPath.section] as NSDictionary
        let key = dict.allKeys
        let keyVal = key[0]
        let issueListArr = dict[keyVal] as! [IssueList.Data]
        vc.issueDetailObj = issueListArr[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
