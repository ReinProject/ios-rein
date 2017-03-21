//
//  User.swift
//  ReinClient
//
//  Created by Alex on 3/7/17.
//  Copyright © 2017 ads2alpha. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire

class User: Object {
    
    dynamic var email = ""
    dynamic var username = ""
    dynamic var maddr = ""
    
    private struct Resources {
        private static let baseURL = "https://api.reinproject.org"
        static let jobsURL = baseURL + "/jobs?maddr="
    }
    
    // Checks if ANY user exists in the DB, that's why class func and not method.
    class func userExists(inRealm realm: Realm) -> Bool {
        let count = realm.objects(User.self).count
        if count == 1 {
            return true
        } else {
            return false
        }
    }
    
    class func get(fromRealm realm: Realm) -> User? {
        return realm.objects(User.self).first
    }
    
    func insert(toRealm realm: Realm) {
        try? realm.write() {
            realm.add(self)
        }
        try? realm.commitWrite()
    }
    
    func getAllJobs(handler: @escaping (Any?, Error?) -> Void) {
        Alamofire.request(Resources.jobsURL + self.maddr).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                handler(value, nil)
            case .failure(let error):
                handler(nil, error)
            }
        }
    }
}
