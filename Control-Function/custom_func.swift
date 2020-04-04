//
//  custom_func.swift
//  swift02->SiriTest
//
//  Created by 森内　映人 on 2019/09/30.
//  Copyright © 2019 森内　映人. All rights reserved.
//

//Hub0: CoreHub for Mk-8
//Hub1: AttitudeHub
//Hub2: DriveHub
//Hub3: SubHub for IRJammers

import Foundation
//aaa
func DidConnectToHub(HubID: Int){
    HubAlerts(HubID: HubID, AlertType: 0x04, AlertOperation: 0x01)
    
    //LED
    PortInputFormatSetup(No: HubID, PortID: 0x32, Mode: 0x00, DInterval: 1, NotificationE: 0x01)
    SetRgbColorNo(LED_color: HubID, No: HubID, Port: 0x32, Mode: 0x00)
    
    //HubPropertiesSet(Hub: HubID, Reference: 0x02, Operation: 0x02)//enable_Button
    HubProperties_Downstream(HubId: HubID, HubPropertyReference: 0x02, HubPropertyOperation: 0x02)
    //synthesizer.speak(utterance_DidConnect)
    switch HubID {
    case 0:
        PortInputFormatSetup(No: 0, PortID: 0x01, Mode: 0x02, DInterval: 2, NotificationE: 0x01)
        PortInputFormatSetup(No: 0, PortID: 0x63, Mode: 0x00, DInterval: 2, NotificationE: 0x01)
        
        PortInputFormatSetup(No: 0, PortID: 0x32, Mode: 0x01, DInterval: 1, NotificationE: 0x01)
        
        
        //PortInputFormatSetup(No: 0, PortID: 0x00, Mode: 0x05, DInterval: 1, NotificationE: 0x01)
        
    //SetRgbColorNo(LED_color: 2, No: 0, Port: 0x32, Mode: 0x00)
    default:
        print("Warning: Unknown Hub!")
    }
}



func SetProfile(){
    /* SetAccTime(No: 0, Port: 0x00, Time: [0x00,0x2A], ProfileNo: 0x01)
     SetDecTime(No: 0, Port: 0x00, Time: [0x00,0x2A], ProfileNo: 0x02)
     SetAccTime(No: 0, Port: 0x01, Time: [0x00,0x2A], ProfileNo: 0x01)
     SetDecTime(No: 0, Port: 0x01, Time: [0x00,0x2A], ProfileNo: 0x02)*/
    
    SetAccTime(No: 2, Port: 0x00, Time: 4000, ProfileNo: 0x01)
    SetDecTime(No: 2, Port: 0x00, Time: 4000, ProfileNo: 0x02)
    SetAccTime(No: 2, Port: 0x01, Time: 4000, ProfileNo: 0x01)
    SetDecTime(No: 2, Port: 0x01, Time: 4000, ProfileNo: 0x02)
    SetAccTime(No: 2, Port: 0x03, Time: 2000, ProfileNo: 0x01)
    SetDecTime(No: 2, Port: 0x03, Time: 2000, ProfileNo: 0x02)
}
func SetProfile0(){
    SetAccTime(No: 0, Port: 0x00, Time: 200, ProfileNo: 0x01)
    SetDecTime(No: 0, Port: 0x00, Time: 200, ProfileNo: 0x01)
    SetAccTime(No: 0, Port: 0x01, Time: 1000, ProfileNo: 0x01)
    SetDecTime(No: 0, Port: 0x01, Time: 1000, ProfileNo: 0x01)
}

func SetProfile1(){
    SetAccTime(No: 1, Port: 0x00, Time: 200, ProfileNo: 0x01)
    SetDecTime(No: 1, Port: 0x00, Time: 200, ProfileNo: 0x01)
    SetAccTime(No: 1, Port: 0x01, Time: 200, ProfileNo: 0x01)
    SetDecTime(No: 1, Port: 0x01, Time: 200, ProfileNo: 0x01)
    SetAccTime(No: 1, Port: 0x02, Time: 200, ProfileNo: 0x01)
    SetDecTime(No: 1, Port: 0x02, Time: 200, ProfileNo: 0x01)
}

func SetProfile2(){
    print("SetProfile2")
    SetAccTime(No: 2, Port: 0x00, Time: 700, ProfileNo: 0x03)
    SetDecTime(No: 2, Port: 0x00, Time: 700, ProfileNo: 0x03)
    SetAccTime(No: 2, Port: 0x01, Time: 700, ProfileNo: 0x03)
    SetDecTime(No: 2, Port: 0x01, Time: 700, ProfileNo: 0x03)
    SetAccTime(No: 2, Port: 0x03, Time: 1500, ProfileNo: 0x02)
    SetDecTime(No: 2, Port: 0x03, Time: 1500, ProfileNo: 0x02)
    SetAccTime(No: 2, Port: 0x03, Time: 8000, ProfileNo: 0x03)
    SetDecTime(No: 2, Port: 0x03, Time: 8000, ProfileNo: 0x03)
}


/*func Gyro(){
 GotoAbsolutePosition(Hub:0, Port:0x00, AbsPos:CalcRoll(roll:att.roll_det*0.9), Speed:0x50, MaxPower:0x64, EndState:0x7f, UseProfie:0x21)
 print("Roll:",Int(att.roll_det))//pitch
 //print("pow_y:",pow_y)//yaw
 GotoAbsolutePosition(Hub:0, Port:0x01, AbsPos:CalcPitch(pitch: att.pitch_det*1.5), Speed:0x64, MaxPower:0x64, EndState:0x7f, UseProfie:0x21)
 print("Pitch:",Int(att.pitch_det))//pitch
 //print("pow_r:",pow_r)//roll
 }*/
/*func Gyro2(){
 GotoAbsolutePosition(Hub:0, Port:0x00, AbsPos:CalcRoll(roll: att.roll_det), Speed:0x64, MaxPower:0x64, EndState:0x7f, UseProfie:0x00)
 print("Roll:",Int(att.roll_det))//pitch
 //print("pow_y:",pow_y)//yaw
 GotoAbsolutePosition(Hub:0, Port:0x01, AbsPos: CalcPitch(pitch: att.pitch_det), Speed:0x64, MaxPower:0x64, EndState:0x7f, UseProfie:0x00)
 print("Pitch:",Int(att.pitch_det))//pitch
 //print("pow_r:",pow_r)//roll
 }*/
/*func DriveHubPort(){
 //PortInformationRequest(No: 1, PortID: 0x01, InfoType: 0x01)
 for mode in 0...6{
 for type in 0...4{
 PortModeInformationRequest(No: 2, Port: 0x63, Mode: UInt8(mode), InfoType: UInt8(type))
 }
 }
 }*/

func AttitudeHubCallibration(){
    for mode in 0...6{
        for type in 0...4{
            PortModeInformationRequest(No: 1, Port: 0x01, Mode: UInt8(mode), InfoType: UInt8(type))
        }
    }
    /*PortModeInformationRequest(No: 1, Port: 0x01, Mode: 0x00, InfoType: 0x01)
     PortModeInformationRequest(No: 1, Port: 0x01, Mode: 0x00, InfoType: 0x02)
     PortModeInformationRequest(No: 1, Port: 0x01, Mode: 0x00, InfoType: 0x03)
     PortModeInformationRequest(No: 1, Port: 0x01, Mode: 0x00, InfoType: 0x04)*/
    //PortInformationRequest(No: 1, PortID: 0x00, InfoType: 0x00)
    //PortInformationRequest(No: 1, PortID: 0x01, InfoType: 0x00)
    //PortInformationRequest(No: 1, PortID: 0x00, InfoType: 0x00)
    PortInputFormatSetup(No: 1, PortID: 0x00, Mode: 0x03, DInterval: 2, NotificationE: 0x01)
    PortInputFormatSetup(No: 1, PortID: 0x01, Mode: 0x03, DInterval: 2, NotificationE: 0x01)
}
func GetPortModeInfo(Hub: Int, port:Int){
    print("port:\(port)")
    for mode in 0...10{
        for type in 0...4{
            PortModeInformationRequest(No: Hub, Port: UInt8(port), Mode: UInt8(mode), InfoType: UInt8(type))
        }
    }
}

/*func AttitudeHubTimer1(){
 let Pitch = CalcPitch(pitch: att.pitch_det*1.5)
 let Roll = CalcRoll(roll:att.roll_det*0.9)
 GotoAbsolutePosition(Hub:1, Port:0x00, AbsPos:Pitch, Speed:0x64, MaxPower:0x64, EndState:0x7e, UseProfie:0x11)
 print("Pitch:",att.pitch_det)//pitch
 GotoAbsolutePosition(Hub:1, Port:0x01, AbsPos:Roll, Speed:0x50, MaxPower:0x64, EndState:0x7e, UseProfie:0x11)
 print("Roll:",att.roll_det)//roll
 }*/

/*func SynchronizationTimer(){
 let Pitch = CalcPitch(pitch: att.pitch_det*1.2)
 let Roll = CalcRoll(roll:att.roll_det*0.9)
 GotoAbsolutePosition(Hub:1, Port:0x00, AbsPos:Pitch, Speed:100, MaxPower:100, EndState:0x7e, UseProfie:0x11)
 //print("Pitch:",att.pitch_det)//pitch
 GotoAbsolutePosition(Hub:1, Port:0x01, AbsPos:Roll, Speed:60, MaxPower:100, EndState:0x7e, UseProfie:0x11)
 //print("Roll:",att.roll_det)//roll
 }*/
/*func AutoPilotTimer(){
 AttHub.auto *= -1
 let PitchIn = Double.random(in: -70.0 ... 70.0)
 let Pitch = CalcPitch(pitch: PitchIn)
 let RollIn = Double.random(in: 0.0 ... 70.0) * Double(AttHub.auto)
 let Roll = CalcRoll(roll: RollIn)
 print("AutoPilot= Pitch:\(PitchIn)\tRoll:\(RollIn)")
 GotoAbsolutePosition(Hub:1, Port:0x00, AbsPos:Pitch, Speed:80, MaxPower:100, EndState:0x7e, UseProfie:0x11)
 //print("Pitch:",att.pitch_det)//pitch
 GotoAbsolutePosition(Hub:1, Port:0x01, AbsPos:Roll, Speed:50, MaxPower:100, EndState:0x7e, UseProfie:0x11)
 //print("Roll:",att.roll_det)//roll
 }*/

func AttitudeHubSetRange(){
    StartSpeed(Hub: 1, Port: 0x00, Speed: -90, MaxPower: 50, UseProfie: 0x11)
}

/*func DriveHubTimer1(){//yawControl
 //Hub2: DriveHub
 //PortInformationRequest(No: 2, PortID: 0x63, InfoType: 0x00)
 var det_y = HubAtt[2].yaw - HubAtt[2].yaw1
 let yaw_pos_servo : Int
 if(det_y>180){
 det_y = -(360 - det_y)
 }else if(det_y < -180){
 det_y = 360+det_y
 }
 PastData.yaw[0] = PastData.yaw[1] + det_y
 HubAtt[2].yaw1 = HubAtt[2].yaw
 PastData.yaw[1] = PastData.yaw[0]
 //let yaw_att = HubAtt[0].yaw * Int(abs(sin( Double.pi*CalcRoll(roll:Double(HubAtt[0].roll/180)) )))
 DriveHub.yaw_pos = PastData.yaw[0]-HubAtt[2].yaw_cal+HubAtt[2].yaw_slider
 yaw_pos_servo = DriveHub.yaw_pos*(-5)+Int(DriveHub.yawCal.Zero)
 print("Yaw_Pos=\(DriveHub.yaw_pos)")
 print("Yaw_Pos_Servo=\(yaw_pos_servo)")
 //print("yaw:\(HubAtt[2].yaw), yaw1:\(HubAtt[2].yaw1), yaw_cal:\(HubAtt[2].yaw_cal)")
 //print("yaw_pos:\(yaw_pos)")
 if(connection.Buffer[2][3] != 0x10){
 GotoAbsolutePosition(Hub:2, Port:0x03, AbsPos: Double(yaw_pos_servo), Speed:0x50, MaxPower:0x64, EndState:0x7e, UseProfie: 0x22)
 }else{
 if(connection.BufferTimer[2][3] > Int(0.1/0.5)){
 //        if(connection.BufferTimer[2][3] > Int(0.1/DriveHubInterval)){
 connection.Buffer[2][3] = 0x01
 connection.BufferTimer[2][3] = 0
 }
 connection.BufferTimer[2][3] += 1
 }
 }*/

/*func DriveHubTimer2(){//AutoTank
 //Hub2: DriveHub
 //PortInformationRequest(No: 2, PortID: 0x63, InfoType: 0x00)
 let ForwardSpeed = Double(DriveHub.forward) * abs(cos(Double.pi*Double(HubAtt[0].pitch)/180))
 //DriveHub.yawCal.Zero = DriveHub.yawCal.Zero+5*sin( Double.pi*Double(att.yaw_det)/180)*abs(sin( Double.pi*Double(HubAtt[0].roll)/180 ))
 
 let YawSpeed = 80.0*Double(-DriveHub.yaw_pos-HubAtt[0].roll)/180
 print("Yaw_Pos:\(DriveHub.yaw_pos)\tHubAttRoll:\(HubAtt[0].roll)")
 let RSpeed = ForwardSpeed+YawSpeed
 let LSpeed = ForwardSpeed-YawSpeed
 print("Speed:Yaw_elevon:\t\tR=\(RSpeed)\tL=\(LSpeed)")
 StartSpeed(Hub: 2, Port: 0x00, Speed: -RSpeed, MaxPower: 100, UseProfie: 0x33)
 StartSpeed(Hub: 2, Port: 0x01, Speed: LSpeed, MaxPower: 100, UseProfie: 0x33)
 }*/

/*func DriveHubTimer3(){//AutoTank
 let ForwardSpeed = Double(DriveHub.forward) * abs(cos(Double.pi*Double(HubAtt[0].pitch)/180))
 let YawSpeed = 80.0*Double(-HubAtt[0].roll)/180
 print("Yaw_Pos:\(DriveHub.yaw_pos)\tHubAttRoll:\(HubAtt[0].roll)")
 let RSpeed = ForwardSpeed+YawSpeed
 let LSpeed = ForwardSpeed-YawSpeed
 print("Speed:Yaw_elevon:\t\tR=\(RSpeed)\tL=\(LSpeed)")
 StartSpeed(Hub: 2, Port: 0x00, Speed: -RSpeed, MaxPower: 100, UseProfie: 0x33)
 StartSpeed(Hub: 2, Port: 0x01, Speed: LSpeed, MaxPower: 100, UseProfie: 0x33)
 }*/
/*func DriveHubTimer4(){//AutoTank$
 let ForwardSpeed = Double(DriveHub.forward) * abs(cos(Double.pi*Double(HubAtt[0].pitch)/180))
 let YawSpeed :Double = 100.0*( sin(Double.pi*Double(att.yaw_det)/2/180.0)+sin(Double.pi*Double(-HubAtt[0].roll/3)/180) )*(0.5+sin(Double.pi*Double(-att.yaw_det)/180.0)*sin(Double.pi*Double(HubAtt[0].roll)/180))
 print("Yaw_Pos:\(DriveHub.yaw_pos)\tHubAtt[0]Roll:\(HubAtt[0].roll)\tSDYaw:\(att.yaw_det)")
 let RSpeed = ForwardSpeed+YawSpeed
 let LSpeed = ForwardSpeed-YawSpeed
 print("Speed:Yaw_elevon:\t\tR=\(RSpeed)\tL=\(LSpeed)")
 
 let yaw_pos_servo : Int
 yaw_pos_servo = Int( 100*Double(-HubAtt[0].roll)/180 * abs(cos(Double.pi*Double(att.yaw_det)/180)) )*(-10)+Int(DriveHub.yawCal.Zero)
 print("Yaw_Pos_Servo=\(yaw_pos_servo)")
 GotoAbsolutePosition(Hub:2, Port:0x03, AbsPos: Double(yaw_pos_servo), Speed:0x50, MaxPower:0x64, EndState:0x7e, UseProfie: 0x33)
 StartSpeed(Hub: 2, Port: 0x00, Speed: -RSpeed, MaxPower: 100, UseProfie: 0x33)
 StartSpeed(Hub: 2, Port: 0x01, Speed: LSpeed, MaxPower: 100, UseProfie: 0x33)
 }*/
/*func DriveHubTimer5(){//AutoTank$
 let ForwardSpeed = Double(DriveHub.forward) * abs(cos(Double.pi*Double(HubAtt[0].pitch)/180))
 let YawSpeed :Double = 100.0*( sin(Double.pi*Double(att.yaw_det)/2/180.0)+sin(Double.pi*Double(-HubAtt[0].roll)/1.5/180) )*(0.5+sin(Double.pi*Double(-att.yaw_det)/180.0)*sin(Double.pi*Double(HubAtt[0].roll)/180))
 print("Yaw_Pos:\(DriveHub.yaw_pos)\tHubAtt[0]Roll:\(HubAtt[0].roll)\tSDYaw:\(att.yaw_det)")
 let RSpeed = ForwardSpeed+YawSpeed
 let LSpeed = ForwardSpeed-YawSpeed
 print("Speed:Yaw_elevon:\t\tR=\(RSpeed)\tL=\(LSpeed)")
 
 //let yaw_pos_servo : Int
 let YawSp: Double
 //D:右回り-
 YawSp = (Double(HubAtt[0].roll)*1.5-HubPorts[2].PortD/5.0)/10
 //yaw_pos_servo = Int( 100*Double(-HubAtt[0].roll)/180 * abs(cos(Double.pi*Double(att.yaw_det)/180)) )*(-10)+Int(DriveHub.yawCal.Zero)
 print("YawSp=\(YawSp)")
 //GotoAbsolutePosition(Hub:2, Port:0x03, AbsPos: Double(yaw_pos_servo), Speed:0x50, MaxPower:0x64, EndState:0x7e, UseProfie: 0x33)
 StartSpeed(Hub: 2, Port: 0x03, Speed: YawSp, MaxPower: 100, UseProfie: 0x33)
 StartSpeed(Hub: 2, Port: 0x00, Speed: -RSpeed, MaxPower: 100, UseProfie: 0x33)
 StartSpeed(Hub: 2, Port: 0x01, Speed: LSpeed, MaxPower: 100, UseProfie: 0x33)
 }*/


func FullPower(){
    StartSpeed(Hub: 2, Port: 0x00, Speed: 0x32, MaxPower: 0x64, UseProfie: 0x21)
    StartSpeed(Hub: 2, Port: 0x01, Speed: 0x32, MaxPower: 0x64, UseProfie: 0x21)
}

/*func CalcRoll(roll: Double)->Double{
 var Mul: Double
 let Ratio :Double = 32.407
 Mul = roll*Ratio*(-1)
 if(abs(Mul)>27*Ratio){
 Mul = 27*Ratio*Mul/abs(Mul)
 }
 print("Calc Roll: \(Mul)")
 return Mul
 }*/
/*func CalcRoll(roll: Double)->Double{
 var Mul: Double
 var Out: Double = 0
 let Ratio :Double = 32.407
 Mul = (roll*Ratio)*(-1) + AttHub.rollCal.Zero
 if(Mul > (AttHub.rollCal.Max)*0.95-1){
 Out = AttHub.rollCal.Max*0.95-1
 }else if(Mul < AttHub.rollCal.Min*0.95+1){
 Out = AttHub.rollCal.Min*0.95+1
 }else{
 Out = Mul
 }
 //print("Calc Roll: \(Mul)")
 return Out
 }*/
/*
 func CalcPitch(pitch: Double)->Double{
 var Mul: Double
 let Ratio :Double = 58.3
 Mul = pitch*Ratio*(-1)
 if(Mul > 32.0*Ratio){
 Mul = 32.0*Ratio
 }else if(Mul < -49.0*Ratio){
 Mul = -49*Ratio
 }
 print("Calc Pitch: \(Mul)")
 return Mul
 }*/
/*func CalcPitch(pitch: Double)->Double{
 var Mul: Double
 var Out: Double
 //let Ratio :Double = 58.3
 let Ratio :Double = 77.8
 Mul = pitch*Ratio*(-1) + AttHub.pitchCal.Zero
 //Mul = pitch*Ratio + AttHub.pitchCal.Zero
 if(Mul > AttHub.pitchCal.Max*0.95-1){
 Out = AttHub.pitchCal.Max*0.95-1
 }else if(Mul < AttHub.pitchCal.Min*0.95+1){
 Out = AttHub.pitchCal.Min*0.95+1
 }else{
 Out = Mul
 }
 //print("Calc Pitch: \(Mul)")
 return Out
 }*/

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
