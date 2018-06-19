//
//  ServerObserver.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/15.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import NEKit
import Foundation
import CocoaLumberjackSwift

class ServerObserverFactory : DebugObserverFactory {
    override func getObserverForProxyServer(_ server: ProxyServer) -> Observer<ProxyServerEvent>? {
        return HttpProxyServerObserver()
    }
    
    override func getObserverForTunnel(_ tunnel: Tunnel) -> Observer<TunnelEvent>? {
        return TunnelObserver()
    }
}

open class HttpProxyServerObserver: Observer<ProxyServerEvent> {
    override open func signal(_ event: ProxyServerEvent) {
        switch event {
        case .started,
             .stopped:
            DDLogInfo("\(event)")
        case .newSocketAccepted(let socket, let onServer):
            DDLogInfo("\(event)")
        case .tunnelClosed(let tunnel, let onServer):
            DDLogInfo("\(event) tunnel: \(tunnel)")
        }
    }
}

open class TunnelObserver: Observer<TunnelEvent> {
    open override func signal(_ event: TunnelEvent) {
        switch event {
        case .proxySocketReadData(let data, _, _):
            let str = String(data: data,  encoding: .utf8)
            DDLogInfo("--------------\(str!)")
        case .closeCalled,
             .opened,
             .connectedToRemote,
             .updatingAdapterSocket,
             .receivedRequest,
             .forceCloseCalled,
             .receivedReadySignal,
             .proxySocketWroteData,
             .adapterSocketReadData,
             .adapterSocketWroteData,
             .closed:
            DDLogDebug("\(event)")

        }
    }
}

class HttpDelegate : SocketDelegate {
    func didConnectWith(adapterSocket: AdapterSocket) {
        
    }
    
    func didDisconnectWith(socket: SocketProtocol) {
        
    }
    
    func didWrite(data: Data?, by: SocketProtocol) {
        
    }
    
    func didBecomeReadyToForwardWith(socket: SocketProtocol) {
        
    }
    
    func didReceive(session: ConnectSession, from: ProxySocket) {
        
    }
    
    func updateAdapterWith(newAdapter: AdapterSocket) {
        
    }
    
    func didRead(data: Data, from: SocketProtocol) {
        DDLogInfo("----------data:\(data)")
    }
}
