//
//  PacketTunnelProvider.swift
//  CrawlerTunnelProvider
//
//  Created by Frank Cheng on 2018/6/22.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import NetworkExtension
import NEKit

class PacketTunnelProvider: NEPacketTunnelProvider {

    var proxyServer: ProxyServer!
    
    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        // Add code here to start the process of connecting the tunnel.
        NSLog("start tunnel-0-----------------")
        let networkSettings = NEPacketTunnelNetworkSettings(tunnelRemoteAddress: "127.0.0.1")
        networkSettings.mtu = 1500
        
        let proxySettings = NEProxySettings()
        proxySettings.httpServer = NEProxyServer(address: "127.0.0.1", port: 9090)
        proxySettings.httpEnabled = true
        proxySettings.httpsServer = NEProxyServer(address: "127.0.0;.1", port: 9090)
        proxySettings.httpsEnabled = true
        proxySettings.matchDomains = ["api.xinpinget.com"]
        networkSettings.proxySettings = proxySettings
        
        networkSettings.dnsSettings = NEDNSSettings(servers: ["114.114.114.114"])

        let ipv4Settings = NEIPv4Settings(addresses: ["192.169.89.1"], subnetMasks: ["255.255.255.0"])
        networkSettings.ipv4Settings = ipv4Settings

        RawSocketFactory.TunnelProvider = self
        
        setTunnelNetworkSettings(networkSettings) { (error) in

            if let error = error {
                NSLog("++++++++++" + error.localizedDescription)
            }
            
//            self.proxyServer = GCDHTTPProxyServer(address: IPAddress(fromString: "127.0.0.1"), port: 9090)
//            ObserverFactory.currentFactory = DebugObserverFactory()
//            try! self.proxyServer.start()
            
            completionHandler(nil)
            NSLog("end")

        }
        
    }
    
    
    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        // Add code here to start the process of stopping the tunnel.
        proxyServer.stop()
        completionHandler()
    }
    
    override func handleAppMessage(_ messageData: Data, completionHandler: ((Data?) -> Void)?) {
        // Add code here to handle the message.
        if let handler = completionHandler {
            handler(messageData)
        }
    }
    
    override func sleep(completionHandler: @escaping () -> Void) {
        // Add code here to get ready to sleep.
        completionHandler()
    }
    
    override func wake() {
        // Add code here to wake up.
        NSLog("start tunnel-0-----------------")

    }
}
