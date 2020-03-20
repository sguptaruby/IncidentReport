


import Foundation

struct Category: CreatableFromJSON { // TODO: Rename this struct
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
        let icon: URL
        init(categoryID: Int, categoryName: String, icon: URL) {
            self.categoryID = categoryID
            self.categoryName = categoryName
            self.icon = icon
        }
        init?(json: [String: Any]) {
            guard let categoryID = json["CategoryID"] as? Int else { return nil }
            guard let categoryName = json["CategoryName"] as? String else { return nil }
            guard let icon = URL(json: json, key: "Icon") else { return nil }
            self.init(categoryID: categoryID, categoryName: categoryName, icon: icon)
        }
    }
}
