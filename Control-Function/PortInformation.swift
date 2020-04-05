//
//  PortInformation.swift
//  Control-Function
//
//  Created by 森内　映人 on 2020/04/04.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import Foundation
import CoreBluetooth

func PortInformation_Upstream(HubId: Int, ReceivedData: [UInt8]){//43
    /*legohub.Peripheral[No]!.readValue(for: legohub.Characteristic[No]!)
    let characteristicData = legohub.Characteristic[No]?.value
    var data = [UInt8](repeating: 0, count: 21)
    _ = characteristicData?.copyBytes(to: &data, count: MemoryLayout<UInt8>.size * 17)
    print("Port Info is:",data )
    /*if(data[5] == 0 || data[3] != 0x0B){
     return 0
     }else{
     print("STdata is:", String(Int(data[5]),radix: 2) )
     ReadData.value = data
     return 1
     }*/
     return 1*/
    switch ReceivedData[0] {
    case 11:     //MODE INFO
        if(ReceivedData[4]==0x01){
            let Port :Int=Int(ReceivedData[3])
            let Capabilities :Int = Int(ReceivedData[5])
            let TotalModeCount :Int = Int(ReceivedData[6])
            let InputModes :Int = Int16toInt(value: [ReceivedData[8], ReceivedData[7]])
            let OutputModes: Int = Int16toInt(value: [ReceivedData[10], ReceivedData[9]])
            print("Port:\(Port), Capabilities:\(Capabilities), TotalModeCount:\(TotalModeCount), InputModes:\(InputModes), OutputModes:\(OutputModes)")
        }else{
            print("Error: PortInformation")
        }
        
    default:
        if(ReceivedData[4]==0x02){//POSSIBLE MODE COMBINATIONS
            let Port :Int=Int(ReceivedData[3])
            var Modes = [String](repeating: "0000111100001111", count: 8)
            let Combinations:Int = Int(ReceivedData[0])-5
            print("Port:\(Port), Combinations:\(Combinations)")
            for i in 0...Combinations{
                Modes[i] = String(Int16toInt(value: [ReceivedData[6+i*2], ReceivedData[5+i*2]]), radix:2)
            }
        }else{
            print("Error: PortInformation")
        }
    }
}
