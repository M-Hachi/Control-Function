//
//  PortModeInformation.swift
//  Control-Function
//
//  Created by 森内　映人 on 2020/04/04.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import Foundation
import CoreBluetooth

func PortModeInformation_Upstream(HubId: Int, ReceivedData: [UInt8]){//44
    let InformationType: Int = Int(ReceivedData[5])
    
    var max = 0
    var k = 5
    while ReceivedData[k] != 0 {
        max = k+1
        k+=1
    }
    var Min:Float = 0.0
    var Max:Float = 0.0
    
    switch InformationType {
    case 0x00://NAME
        print("Port = \(ReceivedData[3]), Mode = \(ReceivedData[4])")
        print("Name= \(( String(bytes: ReceivedData[ReceivedData.index(ReceivedData.startIndex, offsetBy: 6)..<ReceivedData.index(ReceivedData.startIndex, offsetBy: max)], encoding: .ascii) ?? "No Name for Mode" )!)")
    case 0x01://RAW
        memcpy(&Min, [ReceivedData[6],ReceivedData[7],ReceivedData[8],ReceivedData[9]], 4)
        memcpy(&Max, [ReceivedData[10],ReceivedData[11],ReceivedData[12],ReceivedData[13]], 4)
        print("RawMin= \(Min)", "RawMax= \(Max)")
    case 0x02://PCT
        memcpy(&Min, [ReceivedData[6],ReceivedData[7],ReceivedData[8],ReceivedData[9]], 4)
        memcpy(&Max, [ReceivedData[10],ReceivedData[11],ReceivedData[12],ReceivedData[13]], 4)
        print("PctMin= \(Min)", "PctMax= \(Max)")
    case 0x03://SI
        memcpy(&Min, [ReceivedData[6],ReceivedData[7],ReceivedData[8],ReceivedData[9]], 4)
        memcpy(&Max, [ReceivedData[10],ReceivedData[11],ReceivedData[12],ReceivedData[13]], 4)
        print("SiMin= \(Min)", "SiMax= \(Max)")
    case 0x04:////SYMBOL
        print("Symbol= \(( String(bytes: ReceivedData[ReceivedData.index(ReceivedData.startIndex, offsetBy: 6)..<ReceivedData.index(ReceivedData.startIndex, offsetBy: max)], encoding: .ascii) ?? "No Symbol for Mode" )! )\n")
    default:
        print("Error: information type \(InformationType)")
    }
    /*
     //var k=6
     var max = 0
     var k = Int(data[0])
     while data[k-1] == 0{
     k-=1
     }
     max = k
     /*while data[k] != 0 {
        max = k+1
        k+=1
    }*/
    //print(data)
    var Min:Float = 0.0
    var Max:Float = 0.0
    if(data[5]==0x00 && data[6] != 0){//NAME
        print("Port = \(String(Int(data[3]), radix: 16)), Mode = \(String(Int(data[4]), radix: 16)), InfoType = \(String(Int(data[5]), radix: 16))")
        //print("Name= \(String(describing: String(bytes: data[data.index(data.startIndex, offsetBy: 6)..<data.index(data.startIndex, offsetBy: max)], encoding: .ascii) ) )")
        print("Name= \(( String(bytes: data[data.index(data.startIndex, offsetBy: 6)..<data.index(data.startIndex, offsetBy: max)], encoding: .ascii) ?? "no name" )!)")
    }else if(data[5]==0x01){//RAW
        memcpy(&Min, [data[6],data[7],data[8],data[9]], 4)
        memcpy(&Max, [data[10],data[11],data[12],data[13]], 4)
        print("RawMin= \(Min)", "RawMax= \(Max)")
        //print("RawMin= ", Int32toInt(value: [data[9],data[8],data[7],data[6]]),terminator: "")
        //print(" RawMax= ", Int32toInt(value: [data[13],data[12],data[11],data[10]]))
    }else if(data[5]==0x02){//PCT
        memcpy(&Min, [data[6],data[7],data[8],data[9]], 4)
        memcpy(&Max, [data[10],data[11],data[12],data[13]], 4)
        print("PctMin= \(Min)", "PctMax= \(Max)")
        //print("PctMin= ", Int32toInt(value: [data[9],data[8],data[7],data[6]]),terminator: "")
        //print(" PctMax= ", Int32toInt(value: [data[13],data[12],data[11],data[10]]))
    }else if(data[5]==0x03){//SI
        memcpy(&Min, [data[6],data[7],data[8],data[9]], 4)
        memcpy(&Max, [data[10],data[11],data[12],data[13]], 4)
        print("SiMin= \(Min)", "SiMax= \(Max)")
        //print("SiMin= ", Int32toInt(value: [data[9],data[8],data[7],data[6]]),terminator: "")
        //print(" SiMax= ", Int32toInt(value: [data[13],data[12],data[11],data[10]]))
    }else if(data[5]==0x04 && data[6] != 0){//SYMBOL
        print("Symbol= \(( String(bytes: data[data.index(data.startIndex, offsetBy: 6)..<data.index(data.startIndex, offsetBy: max)], encoding: .ascii) ?? "no name" )! )\n")
    }else{
        print("unknown Information Type" )
    }*/
}
