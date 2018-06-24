//
//  RequestRecord.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/19.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import Foundation
import RealmSwift

class HttpEntity:Object {
    @objc dynamic var header: String? = nil
    @objc dynamic var payload: String? = nil
}

class ResponseEntity:HttpEntity {    
}

class RequestEntity:HttpEntity {
}


class RequestRecord: Object {
    @objc dynamic var tunnelId: String? = nil
    @objc dynamic var date: Date? = Date()
    @objc dynamic var request: RequestEntity? = nil
    @objc dynamic var response: ResponseEntity? = nil
}

