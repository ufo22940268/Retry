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
    
    func parseHost() -> String {
        let headers = parseHeaders()
        return headers["Host"] ?? ""
    }
    
    func parseField(field: String) -> String {
        let headers = parseHeaders()
        return headers[field] ?? ""
    }
    
    private func parseHeaders() -> [String: String] {
        if let header = header {
            return header.split(separator: "\r\n").filter { (line) -> Bool in
                line.contains(":")}
                .map{$0.split(separator: ":")}
                .reduce([String:String]()) {
                    (d, splits) in
                    var d = d
                    d[String(splits[0])] = String(splits[1]).trimmingCharacters(in: CharacterSet(charactersIn: " "))
                    return d
            }
        }
        
        return [:]
    }
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

