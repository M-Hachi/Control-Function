//
//  WriteDirectModeData.swift
//  SiriTest
//
//  Created by 森内　映人 on 2020/03/28.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import Foundation
import CoreBluetooth

func SetRgbColorNo(LED_color: Int, No: Int, Port: UInt8, Mode:UInt8) {
    let bytes : [UInt8] = [ 0x08, 0x00, 0x81, Port, 0x11, 0x51, Mode, UInt8(Int16(LED_color)) ]
    let data = Data(_:bytes)
    if(connection.Status[No]==1){
        legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
    }else{
        print("sendLED: no hub!!!")
    }
}

func SetRgbColors(Red: Int, Green: Int, Blue:Int, No: Int, Port: UInt8, Mode:UInt8) {
    let bytes : [UInt8] = [ 0x08, 0x00, 0x81, Port, 0x11, 0x51, Mode, UInt8(Int16(Red)), UInt8(Int16(Green)), UInt8(Int16(Blue)) ]
    let data = Data(_:bytes)
    if(connection.Status[No]==1){
        legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
    }else{
        print("sendLED: no hub!!!")
    }
}

func SetIrCommand(No: Int, Port:UInt8, Channel:UInt8, Send:UInt8) {
    let bytes : [UInt8] = [ 0x09, 0x00, 0x81, Port, 0x11, 0x51, 0x07, Send,Channel ]
    let data = Data(_:bytes)
    if(connection.Status[No]==1){
        legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
    }else{
        print("sendIR: no hub!!!")
        
    }
}

func IrCommand_ComboDirect(No: Int, Port:UInt8, CC:String, RED:String, BLUE:String) {
    let Send :UInt8 = UInt8("0001" + BLUE + RED, radix:2) ?? UInt8("00010000",radix: 2)!
    let Channel :UInt8 = UInt8("000000" + CC, radix:2) ?? UInt8("00000000",radix: 2)!
    
    let bytes : [UInt8] = [ 0x09, 0x00, 0x81, Port, 0x11, 0x51, 0x07, Send, Channel ]
    let data = Data(_:bytes)
    if(connection.Status[No]==1){
        legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
    }else{
        print("sendIR: no hub!!!")
        
    }
}

func IrCommand_SingleOutput(No: Int, Port:UInt8, CC:String, Mode:String, Output:String, DDDD:String) {
    let Send :UInt8 = UInt8(("01" + Mode + Output + DDDD), radix:2) ?? UInt8("01000000",radix: 2)!
    let Channel :UInt8 = UInt8("000000" + CC, radix:2) ?? UInt8("00000000",radix: 2)!
    
    let bytes : [UInt8] = [ 0x09, 0x00, 0x81, Port, 0x11, 0x51, 0x07, Send, Channel ]
    let data = Data(_:bytes)
    if(connection.Status[No]==1){
        legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
    }else{
        print("sendIR: no hub!!!")
    }
}

func IrCommand_ComboPwm(No: Int, Port:UInt8, CC:String, RED:String, BLUE:String) {
    let Send :UInt8 = UInt8((BLUE + RED), radix:2) ?? UInt8("01000000",radix: 2)!
    let Channel :UInt8 = UInt8("000001" + CC, radix:2) ?? UInt8("00000100",radix: 2)!
    
    let bytes : [UInt8] = [ 0x09, 0x00, 0x81, Port, 0x11, 0x51, 0x07, Send, Channel ]
    let data = Data(_:bytes)
    if(connection.Status[No]==1){
        legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
    }else{
        print("sendIR: no hub!!!")
    }
}
