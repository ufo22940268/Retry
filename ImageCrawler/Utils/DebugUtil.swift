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
    static func restoreRealm() {
        let fileManager = FileManager.default
        let restoreFile: URL = (fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!).appendingPathComponent("restore.realm")
        if fileManager.fileExists(atPath: restoreFile.path) {
            
            let targetFile: URL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.bettycc.retry")!.appendingPathComponent(RealmUtil.realmFileName)
            
            if fileManager.fileExists(atPath: targetFile.path) {
                try! fileManager.removeItem(at: targetFile)
            }
            
            try! fileManager.copyItem(at: restoreFile, to: targetFile)
            try! fileManager.removeItem(at: restoreFile)

        }
    }

    
    static func copyRealm() {
        let fileManager = FileManager.default
        
        let destination: URL = (fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!).appendingPathComponent("SharedRealm.realm")
        
        do {
            try fileManager.removeItem(at: destination)
        } catch {
        }
        
        
        let source: URL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.bettycc.retry")!.appendingPathComponent(RealmUtil.realmFileName)
        try! fileManager.copyItem(at: source, to: destination)
    }
}
