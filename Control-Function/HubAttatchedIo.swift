//
//  HubAttatchedIo.swift
//  Control-Function
//
//  Created by xxxx on 2020/04/04.
//  Copyright © 2020 xxxx. All rights reserved.
//

import Foundation
import CoreBluetooth


func HubAttatchedIo_Upstream(HubId: Int, ReceivedData: [UInt8]){//01
    switch ReceivedData[0] {
    case 5:     //Detatched Io
        if(ReceivedData[4]==0x00){
            HubHW[HubId].DetatchedIo(Port: Int(ReceivedData[3]))
        }else{
            print("Error: HubAttatchedIo")
        }
        
    case 15:    //Attatched Io
        if(ReceivedData[4]==0x01){
            HubHW[HubId].AttatchedIo(Port: Int(ReceivedData[3]), IoTypeId: Int16toInt(value: [ReceivedData[5], ReceivedData[6]]), HardwareRevision: 0, SoftwareRevision: 0)
        }else{
            print("Error: HubAttatchedIo")
        }
        
    case 9:     //Attatched Virtual Io
        if(ReceivedData[4]==0x02){
            HubHW[HubId].AttatchedVirtualIo(Port: Int(ReceivedData[3]), IoTypeId: Int16toInt(value: [ReceivedData[5], ReceivedData[6]]), PortIdA: Int(ReceivedData[7]), PortIdB: Int(ReceivedData[8]))
        }else{
            print("Error: HubAttatchedIo")
        }
    default:
        print("Error: HubAttatchedIo")
    }
}
