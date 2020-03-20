


import Foundation

struct SubCategory: CreatableFromJSON { // TODO: Rename this struct
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
        let email: String
        let icon: URL
        let isActive: Bool
        let phoneNumber: String
        let subCategoryID: Int
        let subCategoryName: String
        init(categoryID: Int, email: String, icon: URL, isActive: Bool, phoneNumber: String, subCategoryID: Int, subCategoryName: String) {
            self.categoryID = categoryID
            self.email = email
            self.icon = icon
            self.isActive = isActive
            self.phoneNumber = phoneNumber
            self.subCategoryID = subCategoryID
            self.subCategoryName = subCategoryName
        }
        init?(json: [String: Any]) {
            guard let categoryID = json["CategoryID"] as? Int else { return nil }
            guard let email = json["Email"] as? String else { return nil }
            guard let icon = URL(json: json, key: "Icon") else { return nil }
            guard let isActive = json["IsActive"] as? Bool else { return nil }
            guard let phoneNumber = json["PhoneNumber"] as? String else { return nil }
            guard let subCategoryID = json["SubCategoryID"] as? Int else { return nil }
            guard let subCategoryName = json["SubCategoryName"] as? String else { return nil }
            self.init(categoryID: categoryID, email: email, icon: icon, isActive: isActive, phoneNumber: phoneNumber, subCategoryID: subCategoryID, subCategoryName: subCategoryName)
        }
    }
}
