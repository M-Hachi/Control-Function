//
//  VirtualPortSetup.swift
//  Control-Function
//
//  Created by 森内　映人 on 2020/04/04.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import Foundation
import CoreBluetooth


func VirtualPortSetup_Disconnect(HubId: Int, PortId: UInt8) {
    var bytes : [UInt8]
    bytes = [0x06,0x00,0x61,0x00, PortId]
    let data = Data(bytes: bytes, count: MemoryLayout.size(ofValue: bytes))
    
    if(connection.Status[HubId]==1){
        legohub.Peripheral[HubId]?.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withResponse)
    }else{
        print("VirtualPortSetup_Connect: No Hub!!!")
    }
}


func VirtualPortSetup_Connect(HubId: Int, PortIdA: UInt8, PortIdB: UInt8) {
    var bytes : [UInt8]
    bytes = [0x06,0x00,0x61,0x01, PortIdA,PortIdB]
    let data = Data(bytes: bytes, count: MemoryLayout.size(ofValue: bytes))
    
    if(connection.Status[HubId]==1){
        legohub.Peripheral[HubId]?.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withResponse)
    }else{
        print("VirtualPortSetup_Connect: No Hub!!!")
    }
}
