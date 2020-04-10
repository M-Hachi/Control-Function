//
//  PortInputFormatSetup(CombinedMode).swift
//  Control-Function
//
//  Created by 森内　映人 on 2020/04/04.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import Foundation


func PortInputFormatSetup_CombinedMode(HubId: Int, PortId: UInt8, SubCommand: UInt8){//42
    
    let bytes: [UInt8] = [0x05, 0x00, 0x42, PortId, SubCommand]
    let data = Data(_:bytes)
    if(connection.Status[HubId]==1){
        legohub.Peripheral[HubId]!.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withResponse)
    }else{
            print("PortInputFormatSetup_CombinedMode: No Hub!!!")
        }
}


func PortInputFormatSetup_CombinedMode_SetModeDataSet(HubId: Int, PortId: UInt8, CombinationIndex: UInt8, Mode_DataSet:[UInt8]){//42
    let bytes: [UInt8] = [0x0A, 0x00, 0x42, PortId, 0x01, CombinationIndex, Mode_DataSet[0], Mode_DataSet[1], Mode_DataSet[2]]
    let data = Data(_:bytes)
    if(connection.Status[HubId]==1){
        legohub.Peripheral[HubId]!.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withResponse)
    }else{
        print("PortInputFormatSetup_CombinedMode_SetModeDataSet: No Hub!!!")
    }
}
