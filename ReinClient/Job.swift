//
//  Job.swift
//  ReinClient
//
//  Created by Alex on 3/7/17.
//  Copyright © 2017 ads2alpha. All rights reserved.
//

import Foundation
import RealmSwift

class Job: Object {
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var details = ""
    dynamic var creator = ""
    dynamic var creatorContact = ""
    dynamic var mediator = ""
    dynamic var mediatorContact = ""
    let tags = List<RealmString>()
    dynamic var expiresAt = 0
    
}
