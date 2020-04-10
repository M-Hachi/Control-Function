//
//  PortInputFormatSetup(Single).swift
//  Control-Function
//
//  Created by 森内　映人 on 2020/04/04.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import Foundation

/*
func PortInputFormatSetup_Single(HubId: Int, PortId: UInt8, Mode: UInt8, DeltaInterval: Double, NotificationEnabled: UInt8){//41
    let DIntervalArray: [UInt8] =  DtoInt32(double: DInterval)
    let bytes: [UInt8] = [0x0A, 0x00, 0x41, PortID, Mode,DIntervalArray[0],DIntervalArray[1],DIntervalArray[2],DIntervalArray[3], NotificationE]
    //let bytes: [UInt8] = [0x0A, 0x00, 0x41, PortID, Mode, DInterval[3], DInterval[2], DInterval[1], DInterval[0], NotificationE]
    let data = Data(_:bytes)
    if(connection.Status[No]==1){
        legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
    }else{
            print("41: no hub!!!")
        }
}*/

func PortInputFormatSetup_Single(HubId: Int, PortId: UInt8, Mode: UInt8, DeltaInterval: Double, NotificationEnabled: UInt8){//41
    let DIntervalArray: [UInt8] =  DtoInt32(double: DeltaInterval)
    let bytes: [UInt8] = [0x0A, 0x00, 0x41, PortId, Mode,DIntervalArray[0],DIntervalArray[1],DIntervalArray[2],DIntervalArray[3], NotificationEnabled]
    //let bytes: [UInt8] = [0x0A, 0x00, 0x41, PortID, Mode, DInterval[3], DInterval[2], DInterval[1], DInterval[0], NotificationE]
    let data = Data(_:bytes)
    if(connection.Status[HubId]==1){
        legohub.Peripheral[HubId]!.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withResponse)
    }else{
        print("PortInputFormatSetup_Single: No Hub!!!")
    }
}
