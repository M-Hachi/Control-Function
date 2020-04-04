//
//  HubProperties.swift
//  Control-Function
//
//  Created by xxxx on 2020/04/04.
//  Copyright © 2020 xxxx. All rights reserved.
//

import Foundation
import CoreBluetooth

/*
 Commmon Header
 
 Property
 0x01    Advertising Name
 0x02    Button
 0x03    FW Version
 
 Operation
 
 Payload
 */

func HubProperties_Downstream(HubId: Int, HubPropertyReference: UInt8, HubPropertyOperation: UInt8){//01
    let bytes : [UInt8] = [ 0x05, 0x00, 0x01, HubPropertyReference, HubPropertyOperation]//enable
    let data = Data(_:bytes)
    if(connection.Status[HubId]==1){
        legohub.Peripheral[HubId]!.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withResponse)
    }else{
        print("HubActions: No Hub!")
    }
}

func HubProperties_Upstream(HubId: Int, ReceivedData: [UInt8]){//01
    if(ReceivedData[4]==0x06){//Update
        switch ReceivedData[3]{
        case 0x01:
            print("Advertising Name")
        case 0x02:
            print("Button")
            print("State: \(ReceivedData[5])")
            if(ReceivedData[5]==1){
                legohub.Button[HubId]=true
            }else{
                legohub.Button[HubId]=false
            }
        case 0x03:
            print("FW Version")
        case 0x04:
            print("HW Version")
        case 0x05:
            print("RSSI")
            
        case 0x06:
            //Battery Voltage
            legohub.Battery[HubId] = Int(ReceivedData[5])
            
        case 0x07:
            print("Battery Type")
        case 0x08:
            print("Manufacturer Name")
        case 0x09:
            print("Radio Firmware Version")
        case 0x0A:
            print("Lego Wireless Protocol Version")
        case 0x0B:
            print("System Type ID")
        case 0x0C:
            print("H/W Network ID")
        case 0x0D:
            print("Primary MAC Adderss")
        case 0x0E:
            print("Secondary MAC Address")
        case 0x0F:
            print("Hardware Network Family")
        default:
            print("Unknown Property:", ReceivedData[3] )
        }
    }else{
        print("Error: HubPropertiesUpstream")
    }
}
/*
 func HubPropertiesUpdate(data: [UInt8], HubID: Int){//01
 if(data[4]==0x06){
 switch data[3]{
 case 0x02:
 //Button
            print("State: \(data[5])")
            if(data[5]==1){
                legohub.Button[HubID]=true
            }else{
                legohub.Button[HubID]=false
            }
        case 0x06:
            //Battery Voltage
            legohub.Battery[HubID] = Int(data[5])
        default:
            print("Unknown Property:",data[3] )
        }
    }
}*/
