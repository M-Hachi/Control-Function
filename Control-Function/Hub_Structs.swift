//
//  Hub_Structs.swift
//  JoyStick_V4->SiriTest
//
//  Created by 森内　映人 on 2019/10/20.
//  Copyright © 2019 森内　映人. All rights reserved.
//

import Foundation
//var DriveHub = [Attitude].self
/*struct Attitude{
    var yaw: Int = 0
    var roll: Int = 0
    var pitch: Int = 0
    var yaw_cal: Int = 0
    var roll_cal: Int = 0
    var pitch_cal: Int = 0
    
    var yaw_inv: Int = 0
    var roll_inv: Int = 0
    
    var yaw_slider: Int = 0
    var yaw1: Int = 0
}*/
class Attitude{
    var yaw: Int = 0
    var roll: Int = 0
    var pitch: Int = 0
    var yaw_cal: Int = 0
    var roll_cal: Int = 0
    var pitch_cal: Int = 0
    
    var yaw_inv: Int = 0
    var roll_inv: Int = 0
    
    var yaw_slider: Int = 0
    var yaw1: Int = 0
    
    init(){
        self.yaw = 0
        self.roll = 0
        self.pitch = 0
        self.yaw_cal = 0
        self.roll_cal = 0
        self.pitch_cal = 0
        
        self.yaw_inv = 0
        self.roll_inv = 0
        
        self.yaw_slider = 0
        self.yaw1 = 0
    }
    
    func invert(){
        if(roll>=0){
            roll_inv=roll-180
        }else{
            roll_inv=roll+180
        }
    }
}
var HubAtt = [Attitude](repeating: Attitude() , count: 10)
//var HubAtt = [Attitude](repeating: Attitude(yaw: 0, roll:0, pitch:0, yaw_cal:0, roll_cal:0, pitch_cal:0, yaw_slider:0, yaw1: 0) , count: 10)

struct AttatchedHW{
    var PortA: Int
    var PortB: Int
    var PortC: Int
    var PortD: Int
    var PortE: Int
    var PortF: Int
}
var HubHW = [AttatchedHW](repeating: AttatchedHW(PortA: 0, PortB: 0, PortC: 0, PortD: 0, PortE: 0, PortF: 0), count: 10)

struct PortValue{
    var PortA: Double
    var PortB: Double
    var PortC: Double
    var PortD: Double
    var PortE: Double
    var PortF: Double
}
var HubPorts = [PortValue](repeating: PortValue(PortA: 0, PortB: 0, PortC: 0, PortD: 0, PortE: 0, PortF: 0), count: 10)


struct PortTimer{
    var PortA = Timer()
    var PortB = Timer()
    var PortC = Timer()
    var PortD = Timer()
    var PortE = Timer()
    var PortF = Timer()
}
var HubTimers = [PortTimer](repeating: PortTimer(), count: 10)


struct DegreesCal{//最大値・最小値・零点設定用
    var Max: Double
    var Min: Double
    var Zero: Double
    var MaxSet: Bool
    var MinSet: Bool
    var ZeroSet: Bool
    var Move: Bool
}

struct ArmHub{
    static var hatch = [Double](repeating: 0, count: 100)//PortA
    static var hatchCal = DegreesCal(Max: 0, Min: 0, Zero: 0, MaxSet: false, MinSet: false, ZeroSet: false, Move: false)
    
    static var Elbow : Int = 0
    static var Elbow_cal : Int = 0
    
    static var Ports = PortValue(PortA: 0, PortB: 0, PortC: 0, PortD: 0, PortE: 0, PortF: 0)
    static var Ports_dt = PortValue(PortA: 0, PortB: 0, PortC: 0, PortD: 0, PortE: 0, PortF: 0)
    
    static var Mode : Int = 0
    static var Attatchment : Int = 0
    //static var GestureRecognition:Bool = false
    static var Gesture :Int = 0
    static var GestureLog = [Int](repeating: 0, count: 3)
    static var Gesture_Timer = Timer()
    static var Gesture_IntervalTimer = Timer()
    static var Gesture_Error=[Double](repeating: 0.0, count: 5)
    static var Gesture_Error_min:Double=0.0
    static var Gesture_Tolerance=[Double](repeating: 0.5, count: 5)
    static var userDefaults = UserDefaults.standard
}

