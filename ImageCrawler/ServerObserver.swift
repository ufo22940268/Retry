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
    
    override func getObserverForProxySocket(_ socket: ProxySocket) -> Observer<ProxySocketEvent>? {
        return ProxySocketObserver()
    }
}

class ProxySocketObserver: Observer<ProxySocketEvent> {
    let realm =  try! Realm()
    
    override func signal(_ event: ProxySocketEvent) {
        switch event {
        case .errorOccured:
            DDLogError("\(event)")
        case .disconnected,
             .receivedRequest:
            DDLogInfo("\(event)")
        case .socketOpened,
             .askedToResponseTo,
             .readyForForward:
            DDLogVerbose("\(event)")
        case .readData(let data, let socket):
            let dataString = String(data: data,  encoding: .utf8)
            
            let socketId = socket.hashValue.description
            
            var record = realm.objects(RequestRecord.self).filter("socketId = '\(socketId)'").first ?? RequestRecord()
            try! realm.write {
                record.socketId = socketId
                
                let httpSocket = socket as! HTTPProxySocket
                if (httpSocket.readStatusDescription == "reading first header") {
                    if let headerArray = dataString?.split(separator: "\r\n") {
                        for s in headerArray {
                            record.headers.append(String(s))
                        }
                    }
                } else if (httpSocket.readStatusDescription == "reading content (forwarding)") {
                    record.payload = dataString
                }
                
                realm.add(record)
            }
            
            DDLogInfo("--------------\(dataString!)-----\(socket.hashValue)--------------")
        case .disconnectCalled,
             .forceDisconnectCalled,
             .wroteData:
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
