//
//  FindHub.swift
//  Control-Function
//
//  Created by 森内　映人 on 2020/04/25.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

let legohubServiceCBUUID = CBUUID(string: "00001623-1212-EFDE-1623-785FEABCD123")
let legohubCharacteristicCBUUID = CBUUID(string: "00001624-1212-EFDE-1623-785FEABCD123")

class FindHub: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate  {
    override init () {
        super.init()
    }
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        //self.BTCondition_label.text = String("unknown")
        case .resetting:
            print("central.state is .resetting")
        //self.BTCondition_label.text = String("resetting")
        case .unsupported:
            print("central.state is .unsupported")
        //self.BTCondition_label.text = String("unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        //self.BTCondition_label.text = String("unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        //self.BTCondition_label.text = String("OFF")
        case .poweredOn:
            print("central.state is .poweredOn")
        //self.BTCondition_label.text = String("ON")
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
        //closeAlert()
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
}
/*
 @IBOutlet var BTCondition_label: UILabel!
 
 @IBOutlet var Switch0: UISwitch!
 @IBOutlet var Battery0: UILabel!
 
 @IBOutlet var Switch1: UISwitch!
 @IBOutlet var Battery1: UILabel!
 
 @IBOutlet var Switch2: UISwitch!
 @IBOutlet var Battery2: UILabel!
 
 @IBOutlet var Switch3: UISwitch!
 @IBOutlet var Battery3: UILabel!
 
 var centralManager: CBCentralManager!
 //var legohubPeripheral: CBPeripheral?
 //var legohubCharacteristic: CBCharacteristic?
 
 //let sub = Sub()
 @IBAction func Switch0_toggle(_ sender: UISwitch) {
 if( Switch0.isOn ){
 print("Switch0 turned On")
 alert_hub(No: 0)
 connection.No=0
 centralManager.scanForPeripherals(withServices: [legohubServiceCBUUID])
 }else{
 print("Switch0 turned Off")
 centralManager.stopScan()
 if(connection.Status[0]==1){//接続していたら切断する
 connection.Status[0]=0
 print("Hub0 turn Off Action")
 HubActions_Downstream(HubId: 0, ActionTypes: 0x01)
 }
 }
 }
 
 @IBAction func Switch1_toggle(_ sender: UISwitch) {
 if( Switch1.isOn ){
 print("Switch1 turned On")
 alert_hub(No: 1)
 connection.No=1
 centralManager.scanForPeripherals(withServices: [legohubServiceCBUUID])
 }else{
 print("Switch1 turned Off")
 if(connection.Status[1]==1){
 connection.Status[1]=0
 print("Hub1 turn Off Action")
 HubActions_Downstream(HubId: 1, ActionTypes: 0x01)
 }
 }
 }
 
 @IBAction func Switch2_toggle(_ sender: UISwitch) {
 if( Switch2.isOn ){
 print("Switch2 turned On")
 alert_hub(No: 2)
 connection.No=2
 centralManager.scanForPeripherals(withServices: [legohubServiceCBUUID])
 }else{
 print("Switch2 turned Off")
 if(connection.Status[2]==1){
 connection.Status[2]=0
 print("Hub2 turn Off Action")
 HubActions_Downstream(HubId: 2, ActionTypes: 0x01)
 }
 }
 }
 
 @IBAction func Switch3_toggle(_ sender: UISwitch) {
 if( Switch3.isOn ){
 print("Switch3 turned On")
 alert_hub(No: 3)
 connection.No=3
 centralManager.scanForPeripherals(withServices: [legohubServiceCBUUID])
 }else{
 print("Switch3 turned Off")
 if(connection.Status[3]==1){
 connection.Status[3]=0
 print("Hub3 turn Off Action")
 HubActions_Downstream(HubId: 3, ActionTypes: 0x01)
 }
 }
 }
 
 var alert: UIAlertController!
 func alert_hub(No:Int) {
 alert = UIAlertController(title: "Scanning...", message: "Press button on hub \(No).", preferredStyle: .alert)
 alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{
 (action: UIAlertAction!) -> Void in
 //Cancelが押された時の処理
 print("Switch turned Off")
 self.centralManager.stopScan()
 if(connection.No==0){
 self.Switch0.setOn(false, animated: true)
 }else if(connection.No==1){
 self.Switch1.setOn(false, animated: true)
 }else if(connection.No==2){
 self.Switch2.setOn(false, animated: true)
 }else if(connection.No==3){
 self.Switch3.setOn(false, animated: true)
 }else{
 print("error on .cancel of alert")
 }
 }))
 self.present(alert, animated: true, completion: nil)
 }
 func closeAlert() {
 alert.dismiss(animated: true, completion: nil)
 }
 
 func setSwitch() {
 if(connection.Status[0]==1){
 self.Switch0.setOn(true, animated: false)
 }
 if(connection.Status[1]==1){
 self.Switch1.setOn(true, animated: false)
 }
 if(connection.Status[2]==1){
 self.Switch2.setOn(true, animated: false)
 }
 if(connection.Status[3]==1){
 self.Switch3.setOn(true, animated: false)
 }
 }
 
 //var ble = FindHub_CBManagerDelegate()
 //let sub = Sub()
 override func viewDidLoad() {
 super.viewDidLoad()
 /*for Hub in 0...3{
 if(connection.Status[Hub]==1){
 HubPropertiesSet(Hub: Hub, Reference: 0x06, Operation: 0x05)
 }
 }*/
 setSwitch()
 //centralManager = CBCentralManager(delegate: FindHub_CBManagerDelegate.init() , queue: nil)
 centralManager = CBCentralManager(delegate: self, queue: nil)
 // Do any additional setup after loading the view.
 Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(FindHub_ViewController.ViewTimer), userInfo: nil, repeats: true)
 
 }
 
 override func viewDidAppear(_ animated: Bool) {
 setSwitch()
 }
 
 @objc func ViewTimer(){
 if(connection.Status[0] == 1){
 self.Battery0.text = String("\(legohub.Battery[0])%")
 }else{
 self.Battery0.text = String("NoHub")
 }
 if(connection.Status[1] == 1){
 self.Battery1.text = String("\(legohub.Battery[1])%")
 }else{
 self.Battery1.text = String("NoHub")
 }
 if(connection.Status[2] == 1){
 self.Battery2.text = String("\(legohub.Battery[2])%")
 }else{
 self.Battery2.text = String("NoHub")
 }
 if(connection.Status[3] == 1){
 self.Battery3.text = String("\(legohub.Battery[3])%")
 }else{
 self.Battery3.text = String("NoHub")
 }
 }
 /*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
 
 }
 */
