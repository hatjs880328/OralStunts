//
//  OTICloud.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/9/30.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

private let recordType = "OTNoteTab"

final class CloudKitManager {

    fileprivate init() {}

    static var publicCloudDatabase: CKDatabase {
        return CKContainer.default().publicCloudDatabase
    }

    // MARK: Retrieve existing records
    static func fetchAllCities(_ completion: @escaping (_ records: [OTCloudFatherModel]?, _ error: NSError?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            var ins: [OTCloudFatherModel] = []
            for eachItem in records! {
                ins.append(OTCloudFatherModel().initWith(record: eachItem))
            }
            DispatchQueue.main.async {
                completion(ins, error as NSError?)
            }
        }
    }

    // MARK: add a new record
    static func createRecord(_ primaryKey: String, _ recordData: [String: Any], completion: @escaping (_ record: CKRecord?, _ error: NSError?) -> Void) {
        let recordId = CKRecord.ID(recordName: primaryKey)
        let record = CKRecord(recordType: recordType, recordID: recordId)
        for (key, value) in recordData {
            if key == OTICloudModelExamplecityPicture {
//                if let path = Bundle.main.path(forResource: value, ofType: "jpg") {
//                    do {
//                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                        record.setValue(data, forKey: key)
//                    } catch let error {
//                        print(error)
//                    }
//                }
            } else {
                record.setValue(value, forKey: key)
            }
        }

        publicCloudDatabase.save(record) { (_, error) in
            DispatchQueue.main.async {
                completion(record, error as NSError?)
            }
        }
    }

    // MARK: updating the record by recordId
    static func updateRecord(_ recordId: String, text: String, completion: @escaping (CKRecord?, NSError?) -> Void) {
        let recordId = CKRecordID(recordName: recordId)
        publicCloudDatabase.fetch(withRecordID: recordId) { updatedRecord, error in
            guard let record = updatedRecord else {
                DispatchQueue.main.async {
                    completion(nil, error as NSError?)
                }
                return
            }

            record.setValue(text, forKey: OTICloudModelExamplecityText)
            self.publicCloudDatabase.save(record) { savedRecord, error in
                DispatchQueue.main.async {
                    completion(savedRecord, error as NSError?)
                }
            }
        }
    }

    // MARK: remove the record
    static func removeRecord(_ recordId: String, completion: @escaping (String?, NSError?) -> Void) {
        let recordId = CKRecordID(recordName: recordId)
        publicCloudDatabase.delete(withRecordID: recordId, completionHandler: { deletedRecordId, error in
            DispatchQueue.main.async {
                completion (deletedRecordId?.recordName, error as NSError?)
            }
        })
    }

    // MARK: check that user is logged
    static func checkLoginStatus(_ handler: @escaping (_ islogged: Bool) -> Void) {
        CKContainer.default().accountStatus { accountStatus, error in
            if let error = error {
                print(error.localizedDescription)
            }
            switch accountStatus {
            case .available:
                handler(true)
            default:
                handler(false)
            }
        }
    }
}
