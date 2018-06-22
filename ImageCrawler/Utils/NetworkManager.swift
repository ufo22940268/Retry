//
//  NetworkManager.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/22.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import Foundation
import NetworkExtension

class NetworkManager {
    
    

    func start() {
        NETunnelProviderManager.loadAllFromPreferences(completionHandler: {  [unowned self] (managers, error) in
            let targetManager: NETunnelProviderManager
            if managers?.count == 0 {
                targetManager = NETunnelProviderManager()
            } else {
                targetManager = managers!.first!
            }
            
            let configuration = NETunnelProviderProtocol()
            let proxySettings = NEProxySettings()
            proxySettings.httpServer = NEProxyServer(address: "192.168.20.130", port: 6152)
            proxySettings.httpEnabled = true
            proxySettings.httpsServer = NEProxyServer(address: "192.168.20.130", port: 6152)
            proxySettings.httpsEnabled = true
            configuration.proxySettings = proxySettings
            configuration.serverAddress = "ImageCrawler"
            configuration.providerBundleIdentifier = "bettycc.com.ImageCrawler.CrawlerTunnelProvider"
            targetManager.protocolConfiguration = configuration
            targetManager.isEnabled = true
            targetManager.localizedDescription = "ImageCrawler"
            targetManager.saveToPreferences {err in
                if err != nil {
                    print("------------------\(err?.localizedDescription)")
                } else {
                    targetManager.loadFromPreferences(completionHandler: { (err) in
                        if err != nil {
                            print(err?.localizedDescription)
                        } else {
//                            try! (targetManager.connection as! NETunnelProviderSession).startTunnel(options: [:])
                            print("****************")
                            try! targetManager.connection.startVPNTunnel()
                        }
                    })
                }
            }
        })
    }
}
