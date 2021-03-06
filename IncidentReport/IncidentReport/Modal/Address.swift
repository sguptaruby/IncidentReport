


import Foundation

struct Address: CreatableFromJSON { // TODO: Rename this struct
    let plusCode: PlusCode
    let results: [Results]
    let status: String
    init(plusCode: PlusCode, results: [Results], status: String) {
        self.plusCode = plusCode
        self.results = results
        self.status = status
    }
    init?(json: [String: Any]) {
        guard let plusCode = PlusCode(json: json, key: "plus_code") else { return nil }
        guard let results = Results.createRequiredInstances(from: json, arrayKey: "results") else { return nil }
        guard let status = json["status"] as? String else { return nil }
        self.init(plusCode: plusCode, results: results, status: status)
    }
    struct PlusCode: CreatableFromJSON { // TODO: Rename this struct
        let compoundCode: String
        let globalCode: String
        init(compoundCode: String, globalCode: String) {
            self.compoundCode = compoundCode
            self.globalCode = globalCode
        }
        init?(json: [String: Any]) {
            guard let compoundCode = json["compound_code"] as? String else { return nil }
            guard let globalCode = json["global_code"] as? String else { return nil }
            self.init(compoundCode: compoundCode, globalCode: globalCode)
        }
    }
    struct Results: CreatableFromJSON { // TODO: Rename this struct
        let addressComponents: [AddressComponents]
        let formattedAddress: String
        let geometry: Geometry
        let placeId: String
        let plusCode: PlusCode?
        let postcodeLocalities: [String]?
        let types: [String]
        init(addressComponents: [AddressComponents], formattedAddress: String, geometry: Geometry, placeId: String, plusCode: PlusCode?, postcodeLocalities: [String]?, types: [String]) {
            self.addressComponents = addressComponents
            self.formattedAddress = formattedAddress
            self.geometry = geometry
            self.placeId = placeId
            self.plusCode = plusCode
            self.postcodeLocalities = postcodeLocalities
            self.types = types
        }
        init?(json: [String: Any]) {
            guard let addressComponents = AddressComponents.createRequiredInstances(from: json, arrayKey: "address_components") else { return nil }
            guard let formattedAddress = json["formatted_address"] as? String else { return nil }
            guard let geometry = Geometry(json: json, key: "geometry") else { return nil }
            guard let placeId = json["place_id"] as? String else { return nil }
            guard let types = json["types"] as? [String] else { return nil }
            let plusCode = PlusCode(json: json, key: "plus_code")
            let postcodeLocalities = json["postcode_localities"] as? [String]
            self.init(addressComponents: addressComponents, formattedAddress: formattedAddress, geometry: geometry, placeId: placeId, plusCode: plusCode, postcodeLocalities: postcodeLocalities, types: types)
        }
        struct AddressComponents: CreatableFromJSON { // TODO: Rename this struct
            let longName: String
            let shortName: String
            let types: [String]
            init(longName: String, shortName: String, types: [String]) {
                self.longName = longName
                self.shortName = shortName
                self.types = types
            }
            init?(json: [String: Any]) {
                guard let longName = json["long_name"] as? String else { return nil }
                guard let shortName = json["short_name"] as? String else { return nil }
                guard let types = json["types"] as? [String] else { return nil }
                self.init(longName: longName, shortName: shortName, types: types)
            }
        }
        struct Geometry: CreatableFromJSON { // TODO: Rename this struct
            let bounds: Bounds?
            let location: Location
            let locationType: String
            let viewport: Viewport
            init(bounds: Bounds?, location: Location, locationType: String, viewport: Viewport) {
                self.bounds = bounds
                self.location = location
                self.locationType = locationType
                self.viewport = viewport
            }
            init?(json: [String: Any]) {
                guard let location = Location(json: json, key: "location") else { return nil }
                guard let locationType = json["location_type"] as? String else { return nil }
                guard let viewport = Viewport(json: json, key: "viewport") else { return nil }
                let bounds = Bounds(json: json, key: "bounds")
                self.init(bounds: bounds, location: location, locationType: locationType, viewport: viewport)
            }
            struct Bounds: CreatableFromJSON { // TODO: Rename this struct
                let northeast: Northeast
                let southwest: Southwest
                init(northeast: Northeast, southwest: Southwest) {
                    self.northeast = northeast
                    self.southwest = southwest
                }
                init?(json: [String: Any]) {
                    guard let northeast = Northeast(json: json, key: "northeast") else { return nil }
                    guard let southwest = Southwest(json: json, key: "southwest") else { return nil }
                    self.init(northeast: northeast, southwest: southwest)
                }
                struct Northeast: CreatableFromJSON { // TODO: Rename this struct
                    let lat: Double
                    let lng: Double
                    init(lat: Double, lng: Double) {
                        self.lat = lat
                        self.lng = lng
                    }
                    init?(json: [String: Any]) {
                        guard let lat = Double(json: json, key: "lat") else { return nil }
                        guard let lng = Double(json: json, key: "lng") else { return nil }
                        self.init(lat: lat, lng: lng)
                    }
                }
                struct Southwest: CreatableFromJSON { // TODO: Rename this struct
                    let lat: Double
                    let lng: Double
                    init(lat: Double, lng: Double) {
                        self.lat = lat
                        self.lng = lng
                    }
                    init?(json: [String: Any]) {
                        guard let lat = Double(json: json, key: "lat") else { return nil }
                        guard let lng = Double(json: json, key: "lng") else { return nil }
                        self.init(lat: lat, lng: lng)
                    }
                }
            }
            struct Location: CreatableFromJSON { // TODO: Rename this struct
                let lat: Double
                let lng: Double
                init(lat: Double, lng: Double) {
                    self.lat = lat
                    self.lng = lng
                }
                init?(json: [String: Any]) {
                    guard let lat = Double(json: json, key: "lat") else { return nil }
                    guard let lng = Double(json: json, key: "lng") else { return nil }
                    self.init(lat: lat, lng: lng)
                }
            }
            struct Viewport: CreatableFromJSON { // TODO: Rename this struct
                let northeast: Northeast
                let southwest: Southwest
                init(northeast: Northeast, southwest: Southwest) {
                    self.northeast = northeast
                    self.southwest = southwest
                }
                init?(json: [String: Any]) {
                    guard let northeast = Northeast(json: json, key: "northeast") else { return nil }
                    guard let southwest = Southwest(json: json, key: "southwest") else { return nil }
                    self.init(northeast: northeast, southwest: southwest)
                }
                struct Northeast: CreatableFromJSON { // TODO: Rename this struct
                    let lat: Double
                    let lng: Double
                    init(lat: Double, lng: Double) {
                        self.lat = lat
                        self.lng = lng
                    }
                    init?(json: [String: Any]) {
                        guard let lat = Double(json: json, key: "lat") else { return nil }
                        guard let lng = Double(json: json, key: "lng") else { return nil }
                        self.init(lat: lat, lng: lng)
                    }
                }
                struct Southwest: CreatableFromJSON { // TODO: Rename this struct
                    let lat: Double
                    let lng: Double
                    init(lat: Double, lng: Double) {
                        self.lat = lat
                        self.lng = lng
                    }
                    init?(json: [String: Any]) {
                        guard let lat = Double(json: json, key: "lat") else { return nil }
                        guard let lng = Double(json: json, key: "lng") else { return nil }
                        self.init(lat: lat, lng: lng)
                    }
                }
            }
        }
        struct PlusCode: CreatableFromJSON { // TODO: Rename this struct
            let compoundCode: String
            let globalCode: String
            init(compoundCode: String, globalCode: String) {
                self.compoundCode = compoundCode
                self.globalCode = globalCode
            }
            init?(json: [String: Any]) {
                guard let compoundCode = json["compound_code"] as? String else { return nil }
                guard let globalCode = json["global_code"] as? String else { return nil }
                self.init(compoundCode: compoundCode, globalCode: globalCode)
            }
        }
    }
}
