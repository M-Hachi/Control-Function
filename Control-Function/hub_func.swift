//
//  hub_func.swift
//  swift02->SiriTest
//
//  Created by 森内　映人 on 2019/09/11.
//  Copyright © 2019 森内　映人. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth
/*
func HubPropertiesSet(Hub: Int, Reference: UInt8, Operation: UInt8){//01
    let bytes : [UInt8] = [ 0x05, 0x00, 0x01, Reference, Operation]//enable
    let data = Data(_:bytes)
    legohub.Peripheral[Hub]!.writeValue(data, for: legohub.Characteristic[Hub]!, type: .withResponse)
}

func HubPropertiesUpdate(data: [UInt8], HubID: Int){//01
    if(data[4]==0x06){
        switch data[3]{
        case 0x02:
            //Button
            print("State: \(data[5])")
            if(data[5]==1){
                legohub.Button[HubID]=true
            }else{
                legohub.Button[HubID]=false
            }
        case 0x06:
            //Battery Voltage
            legohub.Battery[HubID] = Int(data[5])
        default:
            print("Unknown Property:",data[3] )
        }
    }
}*/
/*
func HubActions(No: Int, ActionTypes: UInt8) {//02
    print("Hubactions: ", ActionTypes)
    let bytes : [UInt8] = [ 0x04, 0x00, 0x02, ActionTypes]
    let data = Data(_:bytes)
    legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}
*/

/*
func HubAlerts(HubID: Int, AlertType: UInt8, AlertOperation: UInt8) {//03
    print("AlertType: ", AlertType)
    let bytes : [UInt8] = [ 0x05, 0x00, 0x03, AlertType, AlertOperation]
    let data = Data(_:bytes)
    legohub.Peripheral[HubID]!.writeValue(data, for: legohub.Characteristic[HubID]!, type: .withResponse)
}
func HubAlertsUpdate(data: [UInt8], HubID: Int){//03
    print("AlertType:\(data[3]), AlertOperation:\(data[4]), Alertpayload:\(data[5])")
}*/
/*
func GenericErrorMessagesUpdate(data: [UInt8], HubID: Int){//05
    //String( value[3], radix: 16)
    print("Error:CType:\(String(data[3],radix: 16) ), ErrorCode:\(data[4])")
}*/

/*
func enable_battery(No: Int){
    print("enable_battery")
    let bytes : [UInt8] = [ 0x05, 0x00, 0x01, 0x06, 0x02]//enable
    let data = Data(_:bytes)
    legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}
func request_battery(No: Int){
    let bytes : [UInt8] = [ 0x05, 0x00, 0x01, 0x06, 0x05]//request update
    let data = Data(_:bytes)
    legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}
func return_battery(No:Int)->Int{
    legohub.Peripheral[No]!.readValue(for: legohub.Characteristic[No]!)
    let characteristicData = legohub.Characteristic[No]?.value
    //let data = characteristicData.stringEncoding(for data: characteristicData,usedLossyConversion: UnsafeMutablePointer<ObjCBool>?)
    // 0x06 0x00 0x01 0x06 0x06 0x00
    var data: [UInt8] = [0, 0, 0, 0, 0, 0, 0 ]
    _ = characteristicData?.copyBytes(to: &data, count: MemoryLayout<UInt8>.size * 7)
    //let data = characteristicData.withUnsafeBytes<ResultType, ContentType>(_ body:(UnsafePointer<ContentType>) throws -> ResultType) rethrows -> UInt8
   // let data :[UInt8] = String(decoding: characteristicData ?? Data(_:[88, 81]) , as: UTF8.self) // "Caf�"
    //characteristicData.map { String(format: "%02x", $0 as CVarArg) }.joined()
    _ = characteristicData?.first(where:{$0>10})
    
   // battery_1.text = String(format: "%d  [V]",byte ?? 0)
    if(data[5] == 0 || data[3] != 6){
        return 0
    }else{
        //print("data is:",data)
        //print("data[5] is:",data[5])
        //print("Data is :", characteristicData ?? 010)
        print("Battery voltage is: \(data[5])%" )
        return 1
    }
}

func enable_SystemType(No: Int){
    let bytes : [UInt8] = [ 0x05, 0x00, 0x01, 0x0B, 0x02]//enable
    let data = Data(_:bytes)
    legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}
func request_SystemType(No: Int){
    let bytes : [UInt8] = [ 0x05, 0x00, 0x01, 0x0B, 0x05]//request update
    let data = Data(_:bytes)
    legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}
func return_SystemType(No:Int)->Int{
    legohub.Peripheral[No]!.readValue(for: legohub.Characteristic[No]!)
    let characteristicData = legohub.Characteristic[No]?.value
    var data: [UInt8] = [0, 0, 0, 0, 0, 0, 0 ]
    _ = characteristicData?.copyBytes(to: &data, count: MemoryLayout<UInt8>.size * 7)
    //let byte = characteristicData?.first(where:{$0>10})
    //print("ST is:",data)
    // battery_1.text = String(format: "%d  [V]",byte ?? 0)
    if(data[5] == 0 || data[3] != 0x0B){
        return 0
    }else{
        print("STdata is:", String(Int(data[5]),radix: 2) )
        ReadData.value = data
        return 1
    }
}*/
/*
func return_PortModeInformation(No:Int)->Int{
    legohub.Peripheral[No]!.readValue(for: legohub.Characteristic[No]!)
    let characteristicData = legohub.Characteristic[No]?.value
    var data: [UInt8] = [UInt8](repeating: 0, count: 20)
    _ = characteristicData?.copyBytes(to: &data, count: MemoryLayout<UInt8>.size * 20)
    //print("PMI is:",data)
    // battery_1.text = String(format: "%d  [V]",byte ?? 0)
    if( data[2]==0x05 ){
        print("return is: error")
        return 1
    }else if( data == ReadData.value){
        return -1
    }else{
        var k=6
        var max = 0
        while data[k] != 0 {
            max = k+1
            k+=1
        }
        if(max > 6){
            print("Port = \(String(Int(data[3]), radix: 16)), Mode = \(String(Int(data[4]), radix: 16)), ",terminator: "")
            print("Name= \(String(describing: String(bytes: data[data.index(data.startIndex, offsetBy: 6)..<data.index(data.startIndex, offsetBy: max)], encoding: .ascii) ) )")
        }
        ReadData.value = data
        return 1
    }
}*/

/*func read_degA_set(No:Int){
    let bytes : [UInt8] = [0x0a,0x00,0x41,0x00, 0x02,0x00,0x00,0x00,0x64,0x01]//enable
    let data = Data(_:bytes)
    legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}
func read_degA_update(No:Int){
    let bytes : [UInt8] = [0x05,0x00,0x21,0x00, 0x00]//enable
    let data = Data(_:bytes)
    legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
    
    legohub.Peripheral[No]!.readValue(for: legohub.Characteristic[No]!)
    let characteristicData = legohub.Characteristic[No]?.value
    let byte = characteristicData?.last!
    print(byte)
    // battery_1.text = String(format: "%d  [V]",byte ?? 0)
}*/

func TiltConfigOrientation(No: Int, Orientation: UInt8){
    //CommonHeader, PortID, S&Cinfo, SubCommand(=motor control), payload(=power, degrees, etc)
      // bytes = [0x08,0x00,0x81,Port, 0x10, 0x51, 0x00, DtoUInt8(double: Power)]
    //let bytes: [UInt8] = [0x08,0x00,0x81,0x63, 0x11,0x51,0x05,Orientation]
    let bytes: [UInt8] = [0x08,0x00,0x81,0x63, 0x10,0x51,0x05,Orientation]
    print(bytes)
    //bytes = [0x08,0x00,0x81,Port, 0x10, 0x51, 0x00, DtoUInt8(double: Power)]
    //let bytes : [UInt8] = [ 0x08, 0x00, 0x81, 0x32, 0x11, 0x51, 0x00, UInt8(Int16(LED_color)) ]
    let data = Data(_:bytes)
    legohub.Peripheral[No]!.writeValue(data, for: legohub.Characteristic[No]!, type: .withResponse)
}

func PortOutputCommandFeedback(data: [UInt8], HubID: Int){//82
    if(data[4]==10){
        //print("Hub[\(HubID)] Port[\(data[3])] is Busy/Full")
        connection.Buffer[HubID][Int(data[3])] = 0x10
    }
}
