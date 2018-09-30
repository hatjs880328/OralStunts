//
//  OTICloudModelExample.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/30.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation
import CloudKit


let OTICloudModelExamplecityName = "name"
let OTICloudModelExamplecityText = "text"
let OTICloudModelExamplecityPicture = "picture"

private let kCitiesSourcePlist = "Cities"

class City: Equatable {
    
    static var cities: [[String: String]]!
    
    var name: String
    var text: String
    var image: UIImage?
    var identifier: String
    
    init(record: CKRecord) {
        self.name = record.value(forKey: OTICloudModelExamplecityName) as! String
        self.text = record.value(forKey: OTICloudModelExamplecityText) as! String
        if let imageData = record.value(forKey: OTICloudModelExamplecityPicture) as? Data {
            self.image = UIImage(data:imageData)
        }
        self.identifier = record.recordID.recordName
    }
    
    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
