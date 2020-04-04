//
//  PortInformationRequest.swift
//  Control-Function
//
//  Created by 森内　映人 on 2020/04/04.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import Foundation
import CoreBluetooth

func PortInformationRequest(HubId: Int, PortId: UInt8, InformationType: UInt8) {//21
    //print("No: \(No), PortID: \(PortID), InfoType: \(InfoType)" )
    let bytes: [UInt8] = [0x05, 0x00, 0x21, PortId, InformationType]
    //let bytes : [UInt8] = [ 0x08, 0x00, 0x81, 0x32, 0x11, 0x51, 0x00, UInt8(Int16(LED_color)) ]
    let data = Data(_:bytes)
    if(connection.Status[HubId]==1){
        legohub.Peripheral[HubId]!.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withoutResponse)
    }else{
        print("PortInformationRequest: No Hub!")
    }
}
