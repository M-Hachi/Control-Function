//
//  BTstructs.swift
//  swift02->SiriTest
//
//  Created by 森内　映人 on 2019/09/05.
//  Copyright © 2019 森内　映人. All rights reserved.
//

//ここでstruct legohubを設定することでglobalになり全てのViewControllerから使える
import Foundation
import CoreBluetooth

extension FindHub_ViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
            self.BTCondition_label.text = String("unknown")
        case .resetting:
            print("central.state is .resetting")
            self.BTCondition_label.text = String("resetting")
        case .unsupported:
            print("central.state is .unsupported")
            self.BTCondition_label.text = String("unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
            self.BTCondition_label.text = String("unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
            self.BTCondition_label.text = String("OFF")
        case .poweredOn:
            print("central.state is .poweredOn")
            self.BTCondition_label.text = String("ON")
        @unknown default:
            print("unknown deafult")
        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber){
        print("peripheral is: ",peripheral)
        print("peripheral name is: ",peripheral.name!)
        print("peripheral identifier is: ",peripheral.identifier)
        //legohub.Peripheral.append(peripheral)
        //legohub.Peripheral.insert(peripheral, at: connection.No)
        legohub.Peripheral[connection.No] = peripheral
        //legohub.Peripheral[connection.No]?.delegate = self //こっちだと数回接続するとなんかエラー出るけど通信はできる
        legohub.Identifier[connection.No] = peripheral.identifier
        central.connect(legohub.Peripheral[connection.No]!)
        central.stopScan()
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected!")
        closeAlert()
        //connection.Status[connection.No]=1
        peripheral.delegate = self as CBPeripheralDelegate
        print("didDiscoverServices")
        peripheral.discoverServices([legohubServiceCBUUID])
    }
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected!")
        if(error==nil){
            print("no error")
        }else{
            print("Disconnect error: \(String(describing: error))")
        }
    }
}

extension FindHub_ViewController: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("services for",peripheral.name!)
        guard let services = peripheral.services else { return }
        for service in services {
            print(service)
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            print(characteristic)
            //legohub.Characteristic.insert(characteristic, at: connection.No )
            legohub.Characteristic[connection.No] = characteristic
            print(legohub.Characteristic)
            print(legohub.Peripheral)
            print("connection.No = \(connection.No)")
            
            
            connection.Status[connection.No]=1 //接続できたことを記録
            DidConnectToHub(HubID:connection.No)
            //setNotifyValue( true, for: characteristic )
            peripheral.setNotifyValue(true, for: characteristic)
            //HubPropertiesSet(Hub: connection.No, Reference: 0x06, Operation: 0x05)
            //HubPropertiesSet(Hub: connection.No, Reference: 0x06, Operation: 0x02)
            HubProperties_Downstream(HubId: connection.No, HubPropertyReference: 0x06, HubPropertyOperation: 0x02)
 
            
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {//readに必要
        //print("did update value")
        switch characteristic.uuid {
        case legohubCharacteristicCBUUID:
            //print("didUpdateValue")
            if(characteristic.value==nil){
                print("value is nil")
            }else{
                let characteristicData = characteristic.value
                let size :Int = Int(characteristicData?.first ?? 0)
                var data = [UInt8](repeating: 0, count: size)
                _ = characteristicData?.copyBytes(to: &data, count: MemoryLayout<UInt8>.size * size)
                let Hub:Int
                switch peripheral.identifier{
                case legohub.Identifier[0]:
                    Hub = 0
                case legohub.Identifier[1]:
                    Hub = 1
                case legohub.Identifier[2]:
                    Hub = 2
                case legohub.Identifier[3]:
                    Hub = 3
                /*case DriveHubID:
                    Hub = 2
                case DriveHubID2:
                    Hub = 2
                case SubHubID:
                    Hub = 3*/
                default:
                    Hub = -1
                    print("unknown Hub")
                }
                switch data[2]{
                case 0x01:
                    //HubPropertiesUpdate(data: data, HubID: Hub)
                    HubProperties_Upstream(HubId: Hub, ReceivedData: data)
                case 0x03:
                    //HubAlertsUpdate(data: data, HubID: Hub)
                    HubAlerts_Upstream(HubId: Hub, ReceivedData: data)
                case 0x05:
                    //GenericErrorMessagesUpdate(data: data, HubID: Hub)
                    GenericErrorMessages_Upstream(HubId: Hub, data: data)
                case 0x44:
                    //PortModeInformation(data: data, HubID: Hub )
                    PortModeInformation_Upstream(HubId: Hub, ReceivedData: data)
                case 0x45:
                    //PortValueSingleFeedback(data: data, HubID: Hub )
                    PortValue_Single(HubId: Hub, ReceivedData: data)
                case 0x47:
                    PortInputFormat_Upstream(HubId: Hub, ReceivedData: data)
                case 0x82:
                    PortOutputCommandFeedback(data: data, HubID: Hub )
                default:
                    //print((String(data, radix: 16))
                    print("Unknown Updated value:",data )
                }
                //Feedback(data)
                //let str = String(decoding: characteristicData!, as: UTF8.self)
                //print("value1:", str)
            }
        default:
            print("Unhandled Characteristic UUID: \(characteristic.uuid)")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Write失敗...error: \(error)")
            return
        }
        //print("Write成功！")
    }
    
    /*func setNotifyValue(_ enabled: Bool,for characteristic: CBCharacteristic){
        print("Notify value:", enabled)
    }*/
    
    func peripheral(_ peripheral: CBPeripheral,didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?){
        if let error = error {
            print("Update失敗...error: \(error)")
            return
        }else {
            print("didUpdateNotificationState")
        }
 
    }
    
}
//legohubの中身を配列にする
//CBCharacteristicの初期値を設定できないのでlegohubを配列にはできない？
struct legohub{
    static var Characteristic = [CBCharacteristic?](repeating: nil, count: 10)
    static var Peripheral = [CBPeripheral?](repeating: nil, count: 10)
    //static var Status = [Int](repeating: 0/*初期値*/, count: 10/*必要な要素数*/)
    //static var Identifier = [UUID](repeating: UUID(uuidString: "ABCDEFGH-1234-5678-9123-IJKLMNOPQRST")!, count: 10)
    static var Identifier = [UUID](repeating: UUID(uuidString: "ABC1C06A-1844-4DA8-11C2-298F5C64BE2B")!, count: 10)
    static var Button = [Bool](repeating: false, count: 10)
    static var Battery = [Int](repeating: 0, count: 10)
}

//legohubの状態を示す．legohubはnilの可能性がある
struct connection{
    //class connection{
    static var No = 0
    static var Status = [Int](repeating: 0/*初期値*/, count: 10/*必要な要素数*/)
    static var Buffer = [[Int]](repeating: [Int](repeating: 0, count: 100), count: 10)
    static var BufferTimer = [[Int]](repeating: [Int](repeating: 0, count: 100), count: 10)
}

func InfinityColor( No: Int )->Int{
    var color: Int = 10
    if(No == 0){
        color = 2 //purple
    }else if(No == 1){
        color = 3 //blue
    }else if(No == 2){
        color = 9 //red
    }else if(No == 3){
        color = 8 //orange
    }else if(No == 4){
        color = 6 //green
    }else if(No == 5){
        color = 7 //yellow
    }
    return color
}

struct ReadData{
    static var No = 0
    static var value = [UInt8](repeating: 0/*初期値*/, count: 100/*必要な要素数*/)
}

struct PastData{
    static var yaw = [Int](repeating: 0/*初期値*/, count: 100/*必要な要素数*/)
    static var pitch = [Int](repeating: 0/*初期値*/, count: 100/*必要な要素数*/)
    static var roll = [Int](repeating: 0/*初期値*/, count: 100/*必要な要素数*/)
    
    static var pow_y = [Int](repeating: 0/*初期値*/, count: 100/*必要な要素数*/)
    static var pow_p = [Int](repeating: 0/*初期値*/, count: 100/*必要な要素数*/)
    static var pow_r = [Int](repeating: 0/*初期値*/, count: 100/*必要な要素数*/)
}

struct PitchError{
    static var x = [Int](repeating: 0/*初期値*/, count: 3/*必要な要素数*/)
}


