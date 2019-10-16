//
//  Logics.swift
//  YobitParser
//
//  Created by Дмитрий Ю on 27/10/2018.
//  Copyright © 2018 Дмитрий Ю. All rights reserved.
//

import Foundation


func standardDeviation (mas : [Float]) -> Float {
    let length = Float(mas.count)
    let average = mas.reduce(0, {$0 + $1}) / length
    let sumOfSquaredAvgDiff = mas.map { pow($0 - average, 2.0)}.reduce(0, {$0 + $1})
    return sqrt(sumOfSquaredAvgDiff / length)
}

func prognoz (mas : [Float]) -> Float {
    let prognoz : Float
    prognoz = 1 + 2
    return prognoz
}

func skoMax (std : Float, mas : [Float]) -> Float {
    let max : Float
    max = (std * 3) + mas.last!
    return max
}

func skoMin (std : Float, mas : [Float]) -> Float {
    let min : Float
    min = mas.last! - (std * 3)
    return min
}

