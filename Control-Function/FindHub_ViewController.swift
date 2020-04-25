//
//  FindHub_ViewController.swift
//  SiriTest
//
//  Created by 森内　映人 on 2020/01/18.
//  Copyright © 2020 森内　映人. All rights reserved.
//

import UIKit
import CoreBluetooth

//let legohubServiceCBUUID = CBUUID(string: "00001623-1212-EFDE-1623-785FEABCD123")
//let legohubCharacteristicCBUUID = CBUUID(string: "00001624-1212-EFDE-1623-785FEABCD123")

class FindHub_ViewController: UIViewController {
    
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
