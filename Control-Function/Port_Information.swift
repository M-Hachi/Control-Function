//
//  Port_Information.swift
//  swift02->SiriTest
//
//  Created by 森内　映人 on 2019/09/22.
//  Copyright © 2019 森内　映人. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth



//
func HubAttachedIO(No: Int){//04
    //0x090004VV02YYYYAABB
    legohub.Peripheral[No]!.readValue(for: legohub.Characteristic[No]!)
    let characteristicData = legohub.Characteristic[No]?.value
    var data = [UInt8](repeating: 0, count: 21)
    let size :Int = Int(characteristicData?.first ?? 0)
    _ = characteristicData?.copyBytes(to: &data, count: MemoryLayout<UInt8>.size * size)
    if(data[2] == 0x04){
        print("Port ID is:",data[3])
        if(data[4] == 0x02){
            print("PortA, PortB: ",data[7],data[8])
        }
    }else{
        print("Error in HubAttachedIO")
        print("Port Info is:",data )
    }
}

func PortInformationRequest(No: Int, PortID: UInt8, InfoType: UInt8) {//21
    //print("No: \(No), PortID: \(PortID), InfoType: \(InfoType)" )
    let bytes: [UInt8] = [0x05, 0x00, 0x21, PortID, InfoType]
    //let bytes : [UInt8] = [ 0x08, 0x00, 0x81, 0x32, 0x11, 0x51, 0x00, UInt8(Int16(LED_color)) ]
    let data = Data(_:bytes)
    legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withoutResponse)
}

func PortModeInformationRequest(No: Int, Port: UInt8, Mode: UInt8, InfoType: UInt8){//22
    let bytes : [UInt8] = [ 0x06, 0x00, 0x22, Port, Mode, InfoType]//request update
    let data = Data(_:bytes)
    legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}


func PortInputFormatSetup(No: Int, PortID: UInt8, Mode: UInt8, DInterval: Double, NotificationE: UInt8){//41
    let DIntervalArray: [UInt8] =  DtoInt32(double: DInterval)
    let bytes: [UInt8] = [0x0A, 0x00, 0x41, PortID, Mode,DIntervalArray[0],DIntervalArray[1],DIntervalArray[2],DIntervalArray[3], NotificationE]
    //let bytes: [UInt8] = [0x0A, 0x00, 0x41, PortID, Mode, DInterval[3], DInterval[2], DInterval[1], DInterval[0], NotificationE]
    let data = Data(_:bytes)
    if(connection.Status[No]==1){
        legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
    }else{
            print("41: no hub!!!")
        }
}

func PortInformation(No: Int)->Int{//43
    legohub.Peripheral[No]!.readValue(for: legohub.Characteristic[No]!)
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
    return 1
}

func PortModeInformation(data: [UInt8], HubID: Int){//44
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
    }
}
/*func PortModeInformation(No:Int)->Int{//44
 legohub.Peripheral[No]!.readValue(for: legohub.Characteristic[No]!)
 let characteristicData = legohub.Characteristic[No]?.value
 var data: [UInt8] = [UInt8](repeating: 0, count: 20)
 _ = characteristicData?.copyBytes(to: &data, count: MemoryLayout<UInt8>.size * 20)
 if( data[2]==0x05 ){
 print("return is: error")
 return 1
 }else if( data == ReadData.value){
 return -1
 }else if(data[2]==0x44){
 var k=6
 var max = 0
 while data[k] != 0 {
 max = k+1
 k+=1
 }
 print(data)
 print("Port = \(String(Int(data[3]), radix: 16)), Mode = \(String(Int(data[4]), radix: 16)), InfoType = \(String(Int(data[5]), radix: 16))")
 if(data[5]==0x00 && data[6] != 0){//NAME
 print("Name= \(String(describing: String(bytes: data[data.index(data.startIndex, offsetBy: 6)..<data.index(data.startIndex, offsetBy: max)], encoding: .ascii) ) )")
 }else if(data[5]==0x01){//RAW
 print("RawMin= ", Int32toInt(value: [data[9],data[8],data[7],data[6]]))
 print("RawMax= ", Int32toInt(value: [data[13],data[12],data[11],data[10]]))
 }else if(data[5]==0x02){//PCT
 print("PctMin= ", Int32toInt(value: [data[9],data[8],data[7],data[6]]))
 print("PctMax= ", Int32toInt(value: [data[13],data[12],data[11],data[10]]))
 }else if(data[5]==0x03){//SI
 print("SiMin= ", Int32toInt(value: [data[9],data[8],data[7],data[6]]))
 print("SiMax= ", Int32toInt(value: [data[13],data[12],data[11],data[10]]))
 }else if(data[5]==0x04 && data[6] != 0){//SYMBOL
 print("Symbol= \(String(describing: String(bytes: data[data.index(data.startIndex, offsetBy: 6)..<data.index(data.startIndex, offsetBy: max)], encoding: .ascii) ) )")
 }else{
 print("unknown Information Type" )
 }
 return 1
 }else{
 print("error MT" )
 return 1
 }
 }*/

func PortValueSingle(No: Int)->[UInt8]{//45
    legohub.Peripheral[No]!.readValue(for: legohub.Characteristic[No]!)
    let characteristicData = legohub.Characteristic[No]?.value
    let size :Int = Int(characteristicData?.first ?? 0)
    var data = [UInt8](repeating: 0, count: size)
    //var data = [UInt8](repeating: 0, count: 21)
    _ = characteristicData?.copyBytes(to: &data, count: MemoryLayout<UInt8>.size * size)
    print("Port Value is:",data )
    
    return data
}

func PortValueSingleFeedback(data: [UInt8], HubID: Int){//45
    var value: Double = 0.0
    //print("data:\(data)")
    switch data[3]{
    case 0x00:
        //print("data=\(data)")
        HubPorts[HubID].PortA = datatoDouble(data: data)[0]
    case 0x01:
        HubPorts[HubID].PortB = datatoDouble(data: data)[0]
        
    case 0x02:
        HubPorts[HubID].PortC = datatoDouble(data: data)[0]
    case 0x03:
        HubPorts[HubID].PortD = datatoDouble(data: data)[0]
        print("PortD=\(HubPorts[HubID].PortD)")
    case 0x32:
        if(data[0]==6){//mode=0
            print(data)
            value = Double(Int16toInt(value: [data[5],data[4]]))
            print("Hub[\(HubID)] Port[\(data[3])] value: \(value)")
        }else{//mode==1
            print("data=\(data)")
            //print("error in 0x3d")
        }
    case 0x3b:
        if(data[0]==6){//mode=0
            print(data)
            value = Double(Int16toInt(value: [data[5],data[4]]))
            print("Hub[\(HubID)] Port[\(data[3])] value: \(value)")
        }else{//mode==1
            print(data)
            //print("error in 0x3d")
        }
    case 0x3c:
        if(data[0]==6){//mode=0
            print(data)
            value = Double(Int16toInt(value: [data[5],data[4]]))
            print("Hub[\(HubID)] Port[\(data[3])] value: \(value)")
        }else{//mode==1
            print(data)
            //print("error in 0x3d")
        }
    case 0x3d:
        if(data[0]==6){//mode=0
            //print(data)
            value = Double(Int16toInt(value: [data[5],data[4]]))
            print("Hub[\(HubID)] Port[\(data[3])] value: \(value)")
        }else{//mode==1
            print("error in 0x3d")
        }
    case 0x60:
        if(data[0]==6){//mode=0
            value = Double(Int16toInt(value: [data[5],data[4]]))
            print("Hub[\(HubID)] Port[\(data[3])] value: \(value)")
        }else{//mode==1
            print("error in 0x60")
        }
    case 0x61:
        if(data[0]==10){//mode=0
            HubAtt[HubID].yaw = Int16toInt(value: [data[9],data[8]])
            HubAtt[HubID].pitch = Int16toInt(value: [data[7],data[6]])
            HubAtt[HubID].roll = Int16toInt(value: [data[5],data[4]])
        }else{//mode==1
            value = InttoDouble(value: data[4])
            print("Hub[\(HubID)] Port[\(data[3])] value: \(value)")
        }
    case 0x62:
        if(data[0]==10){
            HubAtt[HubID].yaw = Int16toInt(value: [data[9],data[8]])
            HubAtt[HubID].pitch = Int16toInt(value: [data[7],data[6]])
            HubAtt[HubID].roll = Int16toInt(value: [data[5],data[4]])
        }else{
            print("error in 0x62")
        }
    case 0x63:
        if(data[0]==10){
            HubAtt[HubID].yaw = Int16toInt(value: [data[5],data[4]])
            HubAtt[HubID].pitch = Int16toInt(value: [data[7],data[6]])
            HubAtt[HubID].roll = Int16toInt(value: [data[9],data[8]])
            HubAtt[HubID].invert()
        }else{
            print(data)
            //value = datatoDouble(data: data)
            //print("Hub[\(HubID)] Port[\(data[3])] value: \(value)")
        }
    //print("Att[\(HubID)]=Y:\(HubAtt[HubID].yaw) P:\(HubAtt[HubID].pitch) R:\(HubAtt[HubID].roll)")
    default:
        print(data)
        value = datatoDouble(data: data)[0]
        print("Hub[\(HubID)] Port[\(data[3])] value: \(value)")
    }
    /*if(data[3] == 0x63){
     //DriveHub.yaw = Int16toInt(value: [data[5],data[4]])
        HubAtt[HubID].yaw = Int16toInt(value: [data[5],data[4]])
        HubAtt[HubID].pitch = Int16toInt(value: [data[7],data[6]])
        HubAtt[HubID].roll = Int16toInt(value: [data[9],data[8]])
        //DriveHub.pitch = Int16toInt(value: [data[7],data[6]])
        //DriveHub.roll = Int16toInt(value: [data[9],data[8]])
        print("Att[\(HubID)]=Y:\(HubAtt[HubID].yaw) P:\(HubAtt[HubID].pitch) R:\(HubAtt[HubID].roll)")
    }else{
        if(data[0]==5){
            memcpy(&value, [data[4]], 1)
        }else if(data[0]==6){
            value = Float(Int16toInt(value: [data[5],data[4]]))
            //memcpy(&value, [data[4],data[5]], 4)
        }else if(data[0]==8){
            memcpy(&value, [data[4],data[5],data[6],data[7]], 4)
        }
        print("Hub[\(HubID)] Port[\(data[3])] value: \(value)")
    }*/
}

