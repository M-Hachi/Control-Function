//
//  custom_func.swift
//  swift02->SiriTest
//
//Hub0: CoreHub for Mk-8
//Hub1: AttitudeHub
//Hub2: DriveHub
//Hub3: SubHub for IRJammers

import Foundation
//test20
public func DidConnectToHub(HubID: Int){
    HubAlerts_Downstream(HubId: HubID, AlertType: 0x04, AlertOperation: 0x01)
    //LED
    PortInputFormatSetup_Single(HubId: HubID, PortId: 0x32, Mode: 0x00, DeltaInterval: 1, NotificationEnabled: 0x01)
    SetRgbColorNo(LED_color: HubID, No: HubID, Port: 0x32, Mode: 0x00)
    
    //HubPropertiesSet(Hub: HubID, Reference: 0x02, Operation: 0x02)//enable_Button
    //HubProperties_Downstream(HubId: HubID, HubPropertyReference: 0x02, HubPropertyOperation: 0x02)
    //synthesizer.speak(utterance_DidConnect)
    switch HubID {
    case 0:
        //PortInputFormatSetup(No: 0, PortID: 0x01, Mode: 0x02, DInterval: 2, NotificationE: 0x01)
        PortInputFormatSetup_Single(HubId: 0, PortId: 0x01, Mode: 0x02, DeltaInterval: 3, NotificationEnabled: 0x01)
        //PortInputFormatSetup(No: 0, PortID: 0x63, Mode: 0x00, DInterval: 2, NotificationE: 0x01)
        PortInputFormatSetup_Single(HubId: 0, PortId: 0x63, Mode: 0x00, DeltaInterval: 3, NotificationEnabled: 0x01)
        
        //PortInputFormatSetup(No: 0, PortID: 0x32, Mode: 0x01, DInterval: 1, NotificationE: 0x01)
        PortInputFormatSetup_Single(HubId: 0, PortId: 0x32, Mode: 0x01, DeltaInterval: 1, NotificationEnabled: 0x01)
    default:
        print("Warning: Unknown Hub!")
    }
}



func SetProfile(){
    /* SetAccTime(No: 0, Port: 0x00, Time: [0x00,0x2A], ProfileNo: 0x01)
     SetDecTime(No: 0, Port: 0x00, Time: [0x00,0x2A], ProfileNo: 0x02)
     SetAccTime(No: 0, Port: 0x01, Time: [0x00,0x2A], ProfileNo: 0x01)
     SetDecTime(No: 0, Port: 0x01, Time: [0x00,0x2A], ProfileNo: 0x02)*/
    
    /*SetAccTime(No: 2, Port: 0x00, Time: 4000, ProfileNo: 0x01)
    SetDecTime(No: 2, Port: 0x00, Time: 4000, ProfileNo: 0x02)
    SetAccTime(No: 2, Port: 0x01, Time: 4000, ProfileNo: 0x01)
    SetDecTime(No: 2, Port: 0x01, Time: 4000, ProfileNo: 0x02)
    SetAccTime(No: 2, Port: 0x03, Time: 2000, ProfileNo: 0x01)
    SetDecTime(No: 2, Port: 0x03, Time: 2000, ProfileNo: 0x02)*/
}
func SetProfile0(){
    /*SetAccTime(No: 0, Port: 0x00, Time: 200, ProfileNo: 0x01)
    SetDecTime(No: 0, Port: 0x00, Time: 200, ProfileNo: 0x01)
    SetAccTime(No: 0, Port: 0x01, Time: 1000, ProfileNo: 0x01)
    SetDecTime(No: 0, Port: 0x01, Time: 1000, ProfileNo: 0x01)*/
}

func SetProfile1(){
    /*SetAccTime(No: 1, Port: 0x00, Time: 200, ProfileNo: 0x01)
    SetDecTime(No: 1, Port: 0x00, Time: 200, ProfileNo: 0x01)
    SetAccTime(No: 1, Port: 0x01, Time: 200, ProfileNo: 0x01)
    SetDecTime(No: 1, Port: 0x01, Time: 200, ProfileNo: 0x01)
    SetAccTime(No: 1, Port: 0x02, Time: 200, ProfileNo: 0x01)
    SetDecTime(No: 1, Port: 0x02, Time: 200, ProfileNo: 0x01)*/
}

func SetProfile2(){
    print("SetProfile2")
    /*SetAccTime(No: 2, Port: 0x00, Time: 700, ProfileNo: 0x03)
    SetDecTime(No: 2, Port: 0x00, Time: 700, ProfileNo: 0x03)
    SetAccTime(No: 2, Port: 0x01, Time: 700, ProfileNo: 0x03)
    SetDecTime(No: 2, Port: 0x01, Time: 700, ProfileNo: 0x03)
    SetAccTime(No: 2, Port: 0x03, Time: 1500, ProfileNo: 0x02)
    SetDecTime(No: 2, Port: 0x03, Time: 1500, ProfileNo: 0x02)
    SetAccTime(No: 2, Port: 0x03, Time: 8000, ProfileNo: 0x03)
    SetDecTime(No: 2, Port: 0x03, Time: 8000, ProfileNo: 0x03)*/
}



func GetPortModeInfo(Hub: Int, port:Int){
    print("port:\(port)")
    for mode in 0...10{
        for type in 0...4{
            PortModeInformationRequest(HubId: Hub, PortId: UInt8(port), Mode: UInt8(mode), InformationType: UInt8(type))
        }
    }
}

func CalcYaw(yaw: Double)->Double{
    var Mul: Double
    let Ratio :Double = 140/12
    Mul = yaw*Ratio
    if(Mul > 45.0*Ratio){
        Mul = 45.0*Ratio
    }else if(Mul < -45.0*Ratio){
        Mul = -45.0*Ratio
    }
    print("Calc Yaw: \(Mul)")
    return Mul
}
