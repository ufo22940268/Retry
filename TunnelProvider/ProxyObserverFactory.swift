//
//  ServerObserver.swift
//  ImageCrawler
//
//  Created by Frank Cheng on 2018/6/15.
//  Copyright © 2018 Frank Cheng. All rights reserved.
//

import Foundation
import RealmSwift
import NEKit

class ProxyObserverFactory : DebugObserverFactory {
    
    override func getObserverForTunnel(_ tunnel: Tunnel) -> Observer<TunnelEvent>? {
        return ProxyTunnelObserver()
    }
}

class ProxyTunnelObserver: Observer<TunnelEvent> {
    let manager = RecordManager()
    
    override open func signal(_ event: TunnelEvent) {
        switch event {
        case .proxySocketReadData(let data, let socket, let tunnel):
            manager.upsertRequest(data, socket, tunnel)
        case .adapterSocketReadData(let data, let socket, let tunnel):
            manager.upsertResponse(data, socket, tunnel)
        case .receivedRequest,
             .closed:
            break
        case .opened,
             .connectedToRemote,
             .updatingAdapterSocket:
            break
        case .closeCalled,
             .forceCloseCalled,
             .receivedReadySignal,
             .proxySocketWroteData,
             .adapterSocketWroteData:
            break
        }
    }
}

class RecordManager  {
    
    let dataThreshold = 1024*1024
    
    func upsertResponse(_ data: Data, _ socket: AdapterSocket, _ tunnel: Tunnel) {
        guard data.count < dataThreshold else {
            return
        }
        
        let dataString: String = String(data: data, encoding: .utf8) ?? ""

        NSLog("response payload: \(dataString)")
        let tunnelId = extractTunnelId(tunnel)
        let realm = RealmUtil.get()
        let record = realm.objects(RequestRecord.self).filter("tunnelId = '\(tunnelId)'").first
        
        
        let splits = dataString.components(separatedBy: "\r\n\r\n")
        if let record = record {
            if splits.count == 2 {
                try! realm.write {
                    let responseEntity: ResponseEntity = ResponseEntity()
                    responseEntity.header = String(splits[0])
                    responseEntity.payload = String(splits[1])
                    responseEntity.size += data.count
                    record.response = responseEntity
                }
            } else {
                try! realm.write {
                    if let res = record.response, let payload = record.response?.payload {
                        res.payload =  payload + dataString
                        res.size += data.count
                    }
                }
            }
        }
    }
    
    fileprivate func extractTunnelId(_ tunnel: Tunnel) -> String {
        return String(ObjectIdentifier(tunnel).hashValue)
    }
    
    fileprivate func upsertRequest(_ data: Data, _ socket: ProxySocket, _ tunnel: Tunnel) {
        guard data.count < dataThreshold else {
            return
        }
        
        let dataString = String(data: data,  encoding: .utf8) ?? ""
        
        let realm = RealmUtil.get()
        let tunnelId = extractTunnelId(tunnel)
        let record = realm.objects(RequestRecord.self).filter("tunnelId = '\(tunnelId)'").first ?? RequestRecord()
        try! realm.write {
            record.tunnelId = tunnelId
            
            let httpSocket = socket as! HTTPProxySocket
            record.request = record.request ?? RequestEntity()
            if (httpSocket.readStatusDescription == "waiting to send first header") {
                record.request?.header = dataString
            } else if (httpSocket.readStatusDescription == "reading content (forwarding)") {
                record.request?.payload = dataString
            }
            record.request?.size += data.count

            realm.add(record)
        }
    }
}
