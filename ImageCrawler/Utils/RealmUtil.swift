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
    static let realmFileName = "SharedRealm" + (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String) + "." + (Bundle.main.infoDictionary!["CFBundleVersion"] as! String) + ".realm"
    
    static func get() -> Realm  {

        let sharedContainerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.bettycc.retry")!
        let realmURL = sharedContainerURL.appendingPathComponent(realmFileName)
        let config: Realm.Configuration = Realm.Configuration(fileURL: realmURL)
        Realm.Configuration.defaultConfiguration = config
        return try! Realm(configuration: config)
        
    }
}
