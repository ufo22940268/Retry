//
//  DebugUtils.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/24.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import Foundation
import RealmSwift

class DebugUtil {
    static func copyRealm() {
        let fileManager = FileManager.default
        
        let destination: URL = (fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!).appendingPathComponent("SharedRealm.realm")
        
        do {
            try fileManager.removeItem(at: destination)
        } catch {
        }
        
        
        let source: URL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.bettycc.com.ImageCrawler")!.appendingPathComponent("SharedRealm.realm")
        try! fileManager.copyItem(at: source, to: destination)
    }
}
