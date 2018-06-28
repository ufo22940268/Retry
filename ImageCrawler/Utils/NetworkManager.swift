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
    
    
    public func startVPN(_ complete: ((NETunnelProviderManager?, Error?) -> Void)? = nil) {
        startVPNWithOptions(nil, complete: complete)
    }
    
    fileprivate func startVPNWithOptions(_ options: [String : NSObject]?, complete: ((NETunnelProviderManager?, Error?) -> Void)? = nil) {
        // Load provider
        loadAndCreateProviderManager { (manager, error) -> Void in
            if let error = error {
                complete?(nil, error)
            }else{
                guard let manager = manager else {
                    complete?(nil, error)
                    return
                }
                if manager.connection.status == .disconnected || manager.connection.status == .invalid {
                    do {
                        try manager.connection.startVPNTunnel(options: options)
//                        self.addVPNStatusObserver()
                        complete?(manager, nil)
                    }catch {
                        complete?(nil, error)
                    }
                }else{
//                    self.addVPNStatusObserver()
                    complete?(manager, nil)
                }
            }
        }
    }
    
    
    func stop() {
        NETunnelProviderManager.loadAllFromPreferences(completionHandler: {  (managers, error) in
            if let managers = managers {
                if managers.count > 0 && managers.first!.connection.status == .connected  {
                    managers.first?.connection.stopVPNTunnel()
                }
            }
        })
    }
    
}

extension NetworkManager  {
    
    fileprivate func loadAndCreateProviderManager(_ complete: @escaping (NETunnelProviderManager?, Error?) -> Void ) {
        NETunnelProviderManager.loadAllFromPreferences { [unowned self] (managers, error) -> Void in
            if let managers = managers {
                let manager: NETunnelProviderManager
                if managers.count > 0 {
                    manager = managers[0]
                }else{
                    manager = NETunnelProviderManager()
                    manager.protocolConfiguration = NETunnelProviderProtocol()
                }
                
                let configuration = manager.protocolConfiguration as! NETunnelProviderProtocol
                configuration.serverAddress = "ImageCrawler"
                configuration.providerBundleIdentifier = "bettycc.com.ImageCrawler.CrawlerTunnelProvider"
                manager.isEnabled = true
                manager.localizedDescription = "ImageCrawler"
                
                manager.saveToPreferences(completionHandler: { (error) -> Void in
                    if let error = error {
                        complete(nil, error)
                    }else{
                        manager.loadFromPreferences(completionHandler: { (error) -> Void in
                            if let error = error {
                                complete(nil, error)
                            }else{
                                complete(manager, nil)
                            }
                        })
                    }
                })
            }else{
                complete(nil, error)
            }
        }
    }
    
    public func loadProviderManager(_ complete: @escaping (NETunnelProviderManager?) -> Void) {
        NETunnelProviderManager.loadAllFromPreferences { (managers, error) -> Void in
            if let managers = managers {
                if managers.count > 0 {
                    let manager = managers[0]
                    complete(manager)
                    return
                }
            }
            complete(nil)
        }
    }
}
