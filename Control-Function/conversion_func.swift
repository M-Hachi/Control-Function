//
//  conversion_func.swift
//  swift02->SiriTest
//
//  Created by 森内　映人 on 2019/09/30.
//  Copyright © 2019 森内　映人. All rights reserved.
//

import Foundation
//ddd
func InttoInt16(value: Int)->[UInt8]{
    var str = ""
    var padd = ""
    var int = "0000"
    if(value>=0){
        str = String(value, radix: 16)
        padd = String(repeating: Character("0"), count: (4 - str.count))//zeroume
        int = padd + str
    }else{
        str = String(65535+value, radix: 16)
        //padd = String(repeating: Character("F"), count: (8 - str.count))//zeroume
        int = padd + str
    }
    var out :[UInt8]=[0,0]
    //change to UInt8 array (litte Endian)
    out[1] = UInt8((int[int.index(int.startIndex, offsetBy: 0)..<int.index(int.startIndex, offsetBy: 2)]),radix: 16)!
    out[0] = UInt8((int[int.index(int.startIndex, offsetBy: 2)..<int.index(int.startIndex, offsetBy: 4)]), radix: 16)!
    return out
}
func InttoDouble(value: UInt8)->Double{
    let int=Int(value)
    let out :Double
    if(int < 128){
        out=Double(int)
    }else{
        out=Double(255-int)
    }
    return out
}

func DtoUInt8(double: Double)->UInt8{
    let int=Int(double)
    let out :UInt8
    if(int >= 0){
        out=UInt8(int)
    }else{
        out=UInt8(255-abs(int))
    }
    return out
}

func DtoInt32(double: Double)->[UInt8]{
    var str = ""
    var padd = ""
    var int = "00000000"
    if(double>=0){
        str = String(Int(double), radix: 16)
        padd = String(repeating: Character("0"), count: (8 - str.count))//zeroume
        int = padd + str
    }else{
        str = String(4294967295+Int(double), radix: 16)
        //padd = String(repeating: Character("F"), count: (8 - str.count))//zeroume
        int = padd + str
    }
    var out :[UInt8]=[0, 0, 0, 0]
    //change to UInt8 array (litte Endian)
    out[3] = UInt8((int[int.index(int.startIndex, offsetBy: 0)..<int.index(int.startIndex, offsetBy: 2)]),radix: 16)!
    //print(out[3])
    out[2] = UInt8((int[int.index(int.startIndex, offsetBy: 2)..<int.index(int.startIndex, offsetBy: 4)]),radix: 16)!
    //print(out[2])
    out[1] = UInt8((int[int.index(int.startIndex, offsetBy: 4)..<int.index(int.startIndex, offsetBy: 6)]),radix: 16)!
    //print(out[1])
    out[0] = UInt8((int[int.index(int.startIndex, offsetBy: 6)..<int.index(int.startIndex, offsetBy: 8)]), radix: 16)!
    //print(out[0])
    //print("out: \(out)")
    return out
}

func Int16toInt(value: [UInt8])->Int{
    let str0 = String( value[0], radix: 16)
    let str1 = String( value[1], radix: 16)
    let int = str0 + str1
    //print("int: \(int)")
    let raw : Int = Int(int, radix: 16)!
    var out : Int = 0
    if(raw > 32678){
        out = -65536+raw
    }else{
        out = raw
    }
    return out
}

func Int32toInt(value: [UInt8])->Int{
    let str0 = String( value[0], radix: 16)
    let str1 = String( value[1], radix: 16)
    let str2 = String( value[2], radix: 16)
    let str3 = String( value[3], radix: 16)
    var int = "00000000"
     int = str0 + str1  + str2 + str3
    print("int: \(int)")
    let raw : Int = Int(int, radix: 16)!
    var out : Int = 0
    if(raw > 4294967295){
        //if(raw > 4294966000){
        out = -4294967295+raw
    }else{
        out = raw
    }
    return out
}
func Int32toInt2(value: [UInt8])->Int{
    let str0 :Int = Int(value[0])*256*256*256
    let str1 :Int = Int(value[1])*256*256
    let str2 :Int = Int(value[2])*256
    let str3 :Int = Int(value[3])
    let int = str0 + str1  + str2 + str3
    //print("int: \(int)")
    let raw : Int = int
    var out : Int = 0
    if(raw > 2147483648){
        out = -4294967295+raw
    }else{
        out = raw
    }
    return out
}
/*func Int32toFloat(value: [UInt8])->Int{
    /*let str0 = String( value[0], radix: 2)
    let str1 = String( value[1], radix: 2)
    let str2 = String( value[2], radix: 2)
    let str3 = String( value[3], radix: 2)
    let int = str0 + str1  + str2 + str3*/
   
    let str0 = InttoBit(input: value[0])
    let str1 = InttoBit(input: value[1])
    let str2 = InttoBit(input: value[2])
    let str3 = InttoBit(input: value[3])
    let int: [UInt8] = [str0[0],str0[1],str0[2],str0[3], str1[0],str1[1],str1[2],str1[3], str2[0],str2[1],str2[2],str2[3], str3[0],str3[1],str3[2],str3[3]]
    
    var sign = 0
    if(int[0]==0){
        sign = 1
    }else if(int[0]==1){
        sign = -1
    }
    var expo: UInt8 = 0
    for k in 1 ... 8 {
        expo += int[k] * UInt8( pow(2.0,(8-k)).int )
    }
    //,int[2],int[3],int[4], int[5],int[6],int[7],int[8] ]
   
    let int = str0 + str1  + str2 + str3
    //print("int: \(int)")
    let raw : Int = Int(int, radix: 16)!
    var out : Int = 0
    if(raw > 4294966000){
        out = -4294967296+raw
    }else{
        out = raw
    }
    return out
}*/

func InttoBit(input: UInt8)->[UInt8]{
    let str = String(Int(input), radix: 2)
    let padd = String(repeating: Character("0"), count: (4 - str.count))//zeroume
    let int = padd+str//make a 4bit string
    var out :[UInt8]=[0, 0, 0, 0]
    //change to UInt8 array (litte Endian)
    out[3] = UInt8((int[int.index(int.startIndex, offsetBy: 0)..<int.index(int.startIndex, offsetBy: 1)]),radix: 2)!
    out[2] = UInt8((int[int.index(int.startIndex, offsetBy: 1)..<int.index(int.startIndex, offsetBy: 2)]),radix: 2)!
    out[1] = UInt8((int[int.index(int.startIndex, offsetBy: 2)..<int.index(int.startIndex, offsetBy: 3)]),radix: 2)!
    out[0] = UInt8((int[int.index(int.startIndex, offsetBy: 3)..<int.index(int.startIndex, offsetBy: 4)]), radix: 2)!
    return out
}

func RotationDelta(delta: Double)->Double{
    let det: Double
    if(delta>180){
        det = -(360 - delta)
    }else if(delta < -180){
        det = 360+delta
    }else{
        det = delta
    }
    return det
}

func datatoDouble(data: [UInt8])->[Double]{
    //print("data:\(data)")
    var value: [Double] = [0,0,0]
    switch data[0] {
    case 5:
        //memcpy(&value, [data[4]], 8)
        value[0] = Double(data[4])
    case 6:
        value[0] = Double(Int16toInt(value: [data[5],data[4]]))
    case 8:
        value[0] = Double(Int32toInt2(value: [data[7],data[6],data[5],data[4]]))
        //memcpy(&value, [data[7],data[6],data[5],data[4]], 4)
    case 10:
        value[0] = Double(Int16toInt(value: [data[5],data[4]]))
        value[1] = Double(Int16toInt(value: [data[7],data[6]]))
        value[2] = Double(Int16toInt(value: [data[9],data[8]]))
    default:
        value[0] = -5555
    }
    return value
}

func DegToCent(data: Int)->Double{
    let cent:Double
    cent = abs(Double(data)/90.0*100.0)
    if(cent<=100){
        return cent
    }else{
        return 100
    }
}
