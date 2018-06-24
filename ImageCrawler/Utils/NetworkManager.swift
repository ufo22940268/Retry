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
            
            if targetManager.isEnabled && (targetManager.connection.status == .connecting || targetManager.connection.status == .connected)   {
                return
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
    
    func restart() {
        NETunnelProviderManager.loadAllFromPreferences(completionHandler: {  (managers, error) in
            if let managers = managers {
                if managers.count > 0 && managers.first!.connection.status == .connected  {
                    managers.first?.connection.stopVPNTunnel()
                }
            }
        })
        
        start()
    }
}
