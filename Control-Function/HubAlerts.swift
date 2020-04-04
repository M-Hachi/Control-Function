//
//  HubAlerts.swift
//  Control-Function
//
//  Created by 森内　映人 on 2020/04/04.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import Foundation

/*func HubAlerts(HubID: Int, AlertType: UInt8, AlertOperation: UInt8) {//03
    print("AlertType: ", AlertType)
    let bytes : [UInt8] = [ 0x05, 0x00, 0x03, AlertType, AlertOperation]
    let data = Data(_:bytes)
    legohub.Peripheral[HubID]!.writeValue(data, for: legohub.Characteristic[HubID]!, type: .withResponse)
}*/
func HubAlerts_Downstream(HubId: Int, AlertType: UInt8, AlertOperation: UInt8) {//03
    print("AlertType: ", AlertType)
    let bytes : [UInt8] = [ 0x05, 0x00, 0x03, AlertType, AlertOperation]
    let data = Data(_:bytes)
    if(connection.Status[HubId]==1){
        legohub.Peripheral[HubId]!.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withResponse)
    }else{
        print("HubActions: No Hub!")
    }
}
func HubAlerts_Upstream( HubId: Int, ReceivedData: [UInt8]){//03
    if(ReceivedData[4]==0x04){//Update
        switch ReceivedData[3]{
        case 0x01:
            print("Low Voltage: \(ReceivedData[5])")
        case 0x02:
            print("High Current: \(ReceivedData[5])")
        case 0x03:
            print("Low Signal Strength: \(ReceivedData[5])")
        case 0x04:
            print("Over Power Condition: \(ReceivedData[5])")
        default:
            print("Unknown Alert Type:", ReceivedData[3] )
        }
    }else{
        print("Error: HubAlerts")
    }
}
