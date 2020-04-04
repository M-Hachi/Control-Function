//
//  Gyro_func.swift
//  JoyStick_V4->SiriTest
//
//  Created by 森内　映人 on 2019/10/14.
//  Copyright © 2019 森内　映人. All rights reserved.
//

import Foundation

struct att {
    static var roll: Double = 0
    static var pitch: Double = 0
    static var yaw: Double = 0
    static var npitch: Double = 0
    
    static var roll_cal: Double = 0
    static var pitch_cal: Double = 0
    static var yaw_cal: Double = 0
    
    static var roll_det: Double = 0
    static var pitch_det: Double = 0
    static var yaw_det: Double = 0
}

func lim(val: Double)->Double{
    let out :Double
    if(abs(val) <= 100){
        out=val
    }else{
        out=100*val/abs(val)
    }
    return out
}

func Lim(val: Double, max:Double)->Double{
    let out :Double
    if(abs(val) <= max){
        out=val
    }else{
        out=max*val/abs(val)
    }
    return out
}
