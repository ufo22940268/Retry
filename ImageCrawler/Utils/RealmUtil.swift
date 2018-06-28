//
//  RealmUtil.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/23.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUtil {
    static func get() -> Realm  {
        let sharedContainerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.bettycc.retry")!
        let realmURL = sharedContainerURL.appendingPathComponent("SharedRealm.realm")
        let config: Realm.Configuration = Realm.Configuration(fileURL: realmURL)
        Realm.Configuration.defaultConfiguration = config
        return try! Realm(configuration: config)
        
    }
}
