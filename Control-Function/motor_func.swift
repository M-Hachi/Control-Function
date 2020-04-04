//
//  motor_func.swift
//  swift02->SiriTest
//
//  Created by 森内　映人 on 2019/09/05.
//  Copyright © 2019 森内　映人. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth
//Control-Function!!
/*func readA(No:Int) {
    let bytes : [UInt8]
    bytes = [ 0x06,0x00,0x22,0x00, 0x02,0x00]
    let data = Data(bytes: bytes, count: MemoryLayout.size(ofValue: bytes))
    legohub.Peripheral[No]?.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
    print("read value")
    legohub.Peripheral[No]!.readValue(for: legohub.Characteristic[No]!)
    let characteristicData = legohub.Characteristic[No]?.value
    //let str = NSString(data: characteristicData!, encoding: String.Encoding.ascii.rawValue)
    //characteristicData?.first(where:{$0>10})
    print("return is", characteristicData![0],"!!")
}*/
func VirtualPortSetup(No: Int, PortA: UInt8, PortB: UInt8) {
    var bytes : [UInt8]
    bytes = [0x06,0x00,0x61,0x01, PortA,PortB]
    print("wrote \(bytes)")
    let data = Data(bytes: bytes, count: MemoryLayout.size(ofValue: bytes))
    legohub.Peripheral[No]?.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}
func PresetEncoder(HubID: Int, Port:UInt8, Mode:UInt8, Position :Double) {//N/A
    var bytes : [UInt8]
    let PosArray = DtoInt32(double: Position)
    bytes = [0x0B,0x00,0x81,Port, 0x11,0x51,0x02,PosArray[0], PosArray[1],PosArray[2],PosArray[3]]
    print("PresetEncoder:\(bytes)")
    let data = Data(bytes: bytes, count: 10)
    legohub.Peripheral[HubID]?.writeValue(data, for: legohub.Characteristic[HubID]!, type: .withResponse)
}

func SetAccTime(No: Int, Port:UInt8, Time: Int, ProfileNo :UInt8) {//0x05
    let bytes : [UInt8]
    let TimeArray = InttoInt16(value: Time)
    bytes = [ 0x09,0x00,0x81,Port, 0x10,0x05, TimeArray[0], TimeArray[1], ProfileNo]
    let data = Data(bytes: bytes, count: MemoryLayout.size(ofValue: bytes))
    legohub.Peripheral[No]?.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}

func SetDecTime(No: Int, Port:UInt8, Time: Int, ProfileNo :UInt8) {//0x06
    let bytes : [UInt8]
    let TimeArray = InttoInt16(value: Time)
    bytes = [ 0x09,0x00,0x81,Port, 0x10,0x06, TimeArray[0], TimeArray[1], ProfileNo]
    let data = Data(bytes: bytes, count: MemoryLayout.size(ofValue: bytes))
    legohub.Peripheral[No]?.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}

func StartSpeed(Hub: Int, Port:UInt8, Speed:Double, MaxPower:UInt8, UseProfie:UInt8) {//0x07
    var bytes : [UInt8]
    var SpeedOut :Double
    //CommonHeader, PortID, S&Cinfo, SubCommand(=motor control), payload(=power, degrees, etc)
    if(abs(Speed)>100){
        SpeedOut = 100*Speed/abs(Speed)
    }else{
        SpeedOut = Speed
    }
    bytes = [0x09,0x00,0x81,Port, 0x11,0x07,DtoUInt8(double: SpeedOut),MaxPower, UseProfie ]
    //print("wrote \(bytes)")
    let data = Data(bytes: bytes, count: 9)
    legohub.Peripheral[Hub]?.writeValue(data, for: legohub.Characteristic[Hub]!, type: .withoutResponse)
}

func StartSpeedSynchronized(No: Int) {//0x08
    var bytes : [UInt8]
    //bytes = [ 0x0C,0x00,0x81,0x00, 0x11,0x0B,0x5a,0x5a, 0x5a,0x64,0x7F,0x00 ]
    //StartSpeedForDegrees
    bytes = [0x0e,0x00,0x81,0x00, 0x00,0x0b,90,0x00, 0x00,0x00,0x5a,0x5a, 0x7f,0x00 ]
    //bytes = [0x0d,0x00,0x81,0x00, 0x11,0x0d,0xb4,0x00, 0x00,0x00,0x64,0x64, 0x7f,0x00 ]
    print("wrote \(bytes)")
    let data = Data(bytes: bytes, count: 14)
    //print(MemoryLayout.size(ofValue: bytes))
    legohub.Peripheral[No]?.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}


func GotoAbsolutePosition(Hub:Int, Port:UInt8, AbsPos:Double, Speed:UInt8, MaxPower:UInt8, EndState:UInt8, UseProfie:UInt8) {//0x0D
    var bytes : [UInt8]
    //CommonHeader, PortID, S&Cinfo, SubCommand(=motor control), payload(=power, degrees, etc)
    //print("AbsPos:\(AbsPos)")
    let AbsPosArray = DtoInt32(double: AbsPos)
    bytes = [0x0e,0x00,0x81,Port, 0x11,0x0D,AbsPosArray[0],AbsPosArray[1], AbsPosArray[2],AbsPosArray[3],Speed,MaxPower, EndState,UseProfie ]
    //print("wrote \(bytes)")
    let data = Data(bytes: bytes, count: 14)
    legohub.Peripheral[Hub]?.writeValue(data, for: legohub.Characteristic[Hub]!, type: .withoutResponse)
}

func StartPower(Hub:Int, Port:UInt8, Power:Double) {
    var bytes : [UInt8]
    //CommonHeader, PortID, S&Cinfo, SubCommand(=motor control), payload(=power, degrees, etc)
    bytes = [0x08,0x00,0x81,Port, 0x11,0x51,0x00,DtoUInt8(double: Power)]
    //print("StartPower \(bytes)")
    let data = Data(bytes: bytes, count: 8)
    legohub.Peripheral[Hub]?.writeValue(data, for: legohub.Characteristic[Hub]!, type: .withResponse)
}
func StartSpeedForDegreesA(No: Int) {
    var bytes : [UInt8]
    //bytes = [ 0x0C,0x00,0x81,0x00, 0x11,0x0B,0x5a,0x5a, 0x5a,0x64,0x7F,0x00 ]
    //StartSpeedForDegrees
    bytes = [0x0e,0x00,0x81,0x00, 0x00,0x0b,90,0x00, 0x00,0x00,0x5a,0x5a, 0x7f,0x00 ]
    //bytes = [0x0d,0x00,0x81,0x00, 0x11,0x0d,0xb4,0x00, 0x00,0x00,0x64,0x64, 0x7f,0x00 ]
    print("wrote \(bytes)")
    let data = Data(bytes: bytes, count: 14)
    //print(MemoryLayout.size(ofValue: bytes))
    legohub.Peripheral[No]?.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}
func StartSpeedForDegrees(Hub:Int, Port:UInt8, Degrees:Double, Speed:Double, MaxPower:UInt8, EndState:UInt8, UseProfie:UInt8) {//0x0B = 11
    var bytes : [UInt8]
    let AbsPosArray = DtoInt32(double: Degrees)
    print("deg:\(Degrees)")
    bytes = [0x0e,0x00,0x81,Port, 0x11,0x0B,AbsPosArray[0],AbsPosArray[1], AbsPosArray[2],AbsPosArray[3],DtoUInt8(double: Speed),MaxPower, EndState,UseProfie ]
    //print("wrote \(bytes)")
    let data = Data(bytes: bytes, count: 14)
    legohub.Peripheral[Hub]?.writeValue(data, for: legohub.Characteristic[Hub]!, type: .withoutResponse)
}

func GotoAbsolutePositionA(No: Int) {
    var bytes : [UInt8]
    //CommonHeader, PortID, S&Cinfo, SubCommand(=motor control), payload(=power, degrees, etc)
    bytes = [0x0e,0x00,0x81,0x00, 0x00,0x0D,180,0x00, 0x00,0x00,0x5a,0x5a, 0x7e,0x00 ]
    print("wroteA \(bytes)")
    let data = Data(bytes: bytes, count: 14)
    legohub.Peripheral[No]?.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}

extension Decimal {
    var int: Int {
        return NSDecimalNumber(decimal: self).intValue
    }
}
