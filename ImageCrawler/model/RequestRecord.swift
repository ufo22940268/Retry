//
//  RequestRecord.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/19.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import Foundation
import RealmSwift

class RequestRecord: Object {
    @objc dynamic var tunnelId: String? = nil
    let headers = List<String>()
    @objc dynamic var payload: String? = nil
}
