//
//  PortInputFormat(Single).swift
//  Control-Function
//
//  Created by 森内　映人 on 2020/04/04.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import Foundation

import CoreBluetooth


func PortInputFormat_Upstream(HubId: Int, ReceivedData: [UInt8]){//47
    let Port :Int = Int(ReceivedData[3])
    let Mode :Int = Int(ReceivedData[4])
    let DeltaInterval :Int = Int32toInt(value: [ReceivedData[8],ReceivedData[7],ReceivedData[6],ReceivedData[5]])
    let NotificationEnabled: Int = Int(ReceivedData[9])
    
    print("Port:\(Port), Set to Mode:\(Mode), DeltaInterval:\(DeltaInterval), NotificationEnabled:\(NotificationEnabled)")
}
