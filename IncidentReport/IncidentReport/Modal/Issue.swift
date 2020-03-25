//
//  Issue.swift
//  IncidentReport
//
//  Created by Arpita Jain on 23/03/20.
//  Copyright © 2020 Arpita Jain. All rights reserved.
//

import Foundation

struct Issue: CreatableFromJSON { // TODO: Rename this struct
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
        let categoryID: Int
        let categoryName: String
        let createdOn: String
        let description: String
        init(categoryID: Int, categoryName: String, createdOn: String, description: String) {
            self.categoryID = categoryID
            self.categoryName = categoryName
            self.createdOn = createdOn
            self.description = description
        }
        init?(json: [String: Any]) {
            guard let categoryID = json["CategoryID"] as? Int else { return nil }
            guard let categoryName = json["CategoryName"] as? String else { return nil }
            guard let createdOn = json["CreatedOn"] as? String else { return nil }
            guard let description = json["Description"] as? String else { return nil }
            self.init(categoryID: categoryID, categoryName: categoryName, createdOn: createdOn, description: description)
        }
    }
}
