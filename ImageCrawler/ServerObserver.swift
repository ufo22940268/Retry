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
import RealmSwift

class ServerObserverFactory : DebugObserverFactory {
    
    override func getObserverForTunnel(_ tunnel: Tunnel) -> Observer<TunnelEvent>? {
        return TunnelObserver()
    }
}


open class TunnelObserver: Observer<TunnelEvent> {
    open override func signal(_ event: TunnelEvent) {
        switch event {
        case .proxySocketReadData(let data, let socket, let tunnel):
            let str = String(data: data,  encoding: .utf8)
            let record = RequestRecord()
            record.tunnelId = socket.hashValue.description
            
            if let headerArray = str?.split(separator: "\r\n") {
                for s in headerArray {
                    record.headers.append(String(s))
                }
            }
            
            let realm =  try! Realm()
            let records = realm.objects(RequestRecord.self)
            try! realm.write {
                realm.add(record)
            }
            
            print(records)
            
            DDLogInfo("--------------\(str!)-----\(socket.hashValue)")
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
