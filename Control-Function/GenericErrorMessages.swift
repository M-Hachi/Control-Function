//
//  GenericErrorMessages.swift
//  Control-Function
//
//  Created by 森内　映人 on 2020/04/04.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import Foundation
import CoreBluetooth

func GenericErrorMessages_Upstream(HubId: Int, data: [UInt8]){//05
    //String( value[3], radix: 16)
    print("Error:CommandType:\(data[3]), ErrorCode:\(data[4])")
}
