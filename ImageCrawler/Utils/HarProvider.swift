//
//  HarProvider.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/29.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class HarProvider {
    
    var templateJson: JSON!
    
    init() {
        let asset = NSDataAsset(name: "har_template", bundle: Bundle.main)
        templateJson = try! JSON(data: asset!.data)
    }

    func generate(record: RequestRecord) ->  String {
        return templateJson!.string!
    }
}
