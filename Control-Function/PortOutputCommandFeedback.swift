//
//  PortOutputCommandFeedback.swift
//  Control-Function
//
//  Created by 森内　映人 on 2020/04/04.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import Foundation


func PortOutputCommandFeedback_Upstream(data: [UInt8], HubID: Int){//82
    if(data[4]==10){
        //print("Hub[\(HubID)] Port[\(data[3])] is Busy/Full")
        connection.Buffer[HubID][Int(data[3])] = 0x10
    }
}
