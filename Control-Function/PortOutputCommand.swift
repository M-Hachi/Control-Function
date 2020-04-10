//
//  PortOutputCommand.swift
//  Control-Function
//
//  Created by 森内　映人 on 2020/04/04.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import Foundation

/*
func StartPower(Hub:Int, Port:UInt8, Power:Double) {
    var bytes : [UInt8]
    //CommonHeader, PortID, S&Cinfo, SubCommand(=motor control), payload(=power, degrees, etc)
    bytes = [0x08,0x00,0x81,Port, 0x11,0x51,0x00,DtoUInt8(double: Power)]
    //print("StartPower \(bytes)")
    let data = Data(bytes: bytes, count: 8)
    legohub.Peripheral[Hub]?.writeValue(data, for: legohub.Characteristic[Hub]!, type: .withResponse)
}*/

func PortOutputCommand_StartPower(HubId: Int, PortId: UInt8, StartupInformation: Int, CompletetionInformation: Int, Power: Double) {
    var bytes : [UInt8]
    let StartupAndCompletetionInformation: UInt8 = UInt8(StartupInformation*16 + CompletetionInformation)
    print("SC:\(StartupAndCompletetionInformation)")
    //CommonHeader, PortID, S&Cinfo, SubCommand(=motor control), payload(=power, degrees, etc)
    bytes = [0x08,0x00,0x81,PortId, StartupAndCompletetionInformation,0x51,0x00,DtoUInt8(double: Power)]
    let data = Data(bytes: bytes, count: 8)
    legohub.Peripheral[HubId]?.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withResponse)
}


func PortOutputCommand_SetAccTime(HubId: Int, PortId: UInt8, StartupInformation: Int, CompletetionInformation: Int, Time: Int, ProfileNo :UInt8){//0x05
    let bytes : [UInt8]
    let StartupAndCompletetionInformation: UInt8 = UInt8(StartupInformation*16 + CompletetionInformation)
    let TimeArray = InttoInt16(value: Time)
    bytes = [ 0x09,0x00,0x81,PortId, StartupAndCompletetionInformation,0x05, TimeArray[0], TimeArray[1], ProfileNo]
    let data = Data(bytes: bytes, count: MemoryLayout.size(ofValue: bytes))
    legohub.Peripheral[HubId]?.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withResponse)
}


func PortOutputCommand_SetDecTime(HubId: Int, PortId: UInt8, StartupInformation: Int, CompletetionInformation: Int, Time: Int, ProfileNo :UInt8){//0x05
    let bytes : [UInt8]
    let StartupAndCompletetionInformation: UInt8 = UInt8(StartupInformation*16 + CompletetionInformation)
    let TimeArray = InttoInt16(value: Time)
    bytes = [ 0x09,0x00,0x81,PortId, StartupAndCompletetionInformation,0x06, TimeArray[0], TimeArray[1], ProfileNo]
    let data = Data(bytes: bytes, count: MemoryLayout.size(ofValue: bytes))
    legohub.Peripheral[HubId]?.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withResponse)
}


func PortOutputCommand_StartSpeed(HubId: Int, PortId: UInt8, StartupInformation: Int, CompletetionInformation: Int, Speed:Double, MaxPower:UInt8, UseProfie:UInt8) {//0x07
    var bytes : [UInt8]
    let StartupAndCompletetionInformation: UInt8 = UInt8(StartupInformation*16 + CompletetionInformation)
    var SpeedOut :Double
    
    if(abs(Speed)>100){
        SpeedOut = 100*Speed/abs(Speed)
    }else{
        SpeedOut = Speed
    }
    
    bytes = [0x09,0x00,0x81,PortId, StartupAndCompletetionInformation,0x07,DtoUInt8(double: SpeedOut),MaxPower, UseProfie ]
    
    let data = Data(bytes: bytes, count: 9)
    legohub.Peripheral[HubId]?.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withoutResponse)
}

func PortOutputCommand_StartSpeedForDegrees(HubId: Int, PortId: UInt8, StartupInformation: Int, CompletetionInformation: Int, Degrees:Double, Speed:Double, MaxPower:UInt8, EndState:UInt8, UseProfie:UInt8) {//0x0B = 11
    var bytes : [UInt8]
    let StartupAndCompletetionInformation: UInt8 = UInt8(StartupInformation*16 + CompletetionInformation)
    let AbsPosArray = DtoInt32(double: Degrees)
    print("deg:\(Degrees)")
    bytes = [0x0e,0x00,0x81,PortId, StartupAndCompletetionInformation,0x0B,AbsPosArray[0],AbsPosArray[1], AbsPosArray[2],AbsPosArray[3],DtoUInt8(double: Speed),MaxPower, EndState,UseProfie ]
    let data = Data(bytes: bytes, count: 14)
    legohub.Peripheral[HubId]?.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withoutResponse)
}

func PortOutputCommand_GotoAbsolutePosition(HubId: Int, PortId: UInt8, StartupInformation: Int, CompletetionInformation: Int, AbsPos:Double, Speed:UInt8, MaxPower:UInt8, EndState:UInt8, UseProfie:UInt8) {//0x0D
    var bytes : [UInt8]
    let StartupAndCompletetionInformation: UInt8 = UInt8(StartupInformation*16 + CompletetionInformation)
    let AbsPosArray = DtoInt32(double: AbsPos)
    bytes = [0x0e,0x00,0x81,PortId, StartupAndCompletetionInformation,0x0D,AbsPosArray[0],AbsPosArray[1], AbsPosArray[2],AbsPosArray[3],Speed,MaxPower, EndState,UseProfie ]
    let data = Data(bytes: bytes, count: 14)
    legohub.Peripheral[HubId]?.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withoutResponse)
}

func PortOutputCommand_PresetEncoder(HubId: Int, PortId: UInt8, StartupInformation: Int, CompletetionInformation: Int, Position :Double) {//N/A
    var bytes : [UInt8]
    let StartupAndCompletetionInformation: UInt8 = UInt8(StartupInformation*16 + CompletetionInformation)
    let PosArray = DtoInt32(double: Position)
    bytes = [0x0B,0x00,0x81,PortId, StartupAndCompletetionInformation,0x51,0x02,PosArray[0], PosArray[1],PosArray[2],PosArray[3]]
    print("PresetEncoder:\(bytes)")
    let data = Data(bytes: bytes, count: 10)
    legohub.Peripheral[HubId]?.writeValue(data, for: legohub.Characteristic[HubId]!, type: .withResponse)
}
