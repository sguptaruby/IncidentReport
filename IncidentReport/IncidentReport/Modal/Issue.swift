//
//  Issue.swift
//  IncidentReport
//
//  Created by Arpita Jain on 23/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//


import Foundation


struct IssueList: CreatableFromJSON { // TODO: Rename this struct
    let data: [Data]
    let message: String
    let success: Bool
    init(data: [Data], message: String, success: Bool) {
        self.data = data
        self.message = message
        self.success = success
    }
    init?(json: [String: Any]) {
        guard let data = Data.createRequiredInstances(from: json, arrayKey: "Data") else { return nil }
        guard let message = json["Message"] as? String else { return nil }
        guard let success = json["Success"] as? Bool else { return nil }
        self.init(data: data, message: message, success: success)
    }
    struct Data: CreatableFromJSON { // TODO: Rename this struct
        let categoryID: Int?
        let categoryName: String?
        let createdOn: String?
        let description: String?
        let incidentRequestID: Int?
        let location: String?
        let status: String?
        let statusID: Int?
        let subCategoryID: Int?
        let subCategoryIcon: URL?
        let subCategoryName: String?
        let images: [ImagesURL]
        init(categoryID: Int?, categoryName: String?, createdOn: String?, description: String?, incidentRequestID: Int?, location: String?, status: String?, statusID: Int?, subCategoryID: Int?, subCategoryIcon: URL?, subCategoryName: String?, images: [ImagesURL]) {
            self.categoryID = categoryID
            self.categoryName = categoryName
            self.createdOn = createdOn
            self.description = description
            self.incidentRequestID = incidentRequestID
            self.location = location
            self.status = status
            self.statusID = statusID
            self.subCategoryID = subCategoryID
            self.subCategoryIcon = subCategoryIcon
            self.subCategoryName = subCategoryName
            self.images = images
        }
        
        init?(json: [String: Any]) {

             let categoryID = json["CategoryID"] as? Int
             let categoryName = json["CategoryName"] as? String
             let createdOn = json["CreatedOn"] as? String
             let description = json["Description"] as? String
             let incidentRequestID = json["IncidentRequestID"] as? Int
             let location = json["Location"] as? String
             let status = json["Status"] as? String
             let statusID = json["StatusID"] as? Int
             let subCategoryID = json["SubCategoryID"] as? Int
             let subCategoryIcon = json["SubCategoryIcon"] as? URL
             let subCategoryName = json["SubCategoryName"] as? String
//             let images = json["images"] as? ImagesURL]
            guard let images = ImagesURL.createRequiredInstances(from: json, arrayKey: "images") else { return nil }

            self.init(categoryID: categoryID, categoryName: categoryName, createdOn: createdOn, description: description, incidentRequestID: incidentRequestID, location: location, status: status, statusID: statusID, subCategoryID: subCategoryID, subCategoryIcon: subCategoryIcon, subCategoryName: subCategoryName, images: images)
        }
    }
    
    struct ImagesURL: CreatableFromJSON {
        let url: URL?
        init(url: URL?) {
            self.url = url
        }
        init?(json: [String: Any]) {
            let str = json["url"] as? String
            let url = URL(string: str ?? "")
            self.init(url: url)
        }
    }
}
