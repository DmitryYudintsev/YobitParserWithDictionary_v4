//
//  Struct.swift
//  YobitParser
//
//  Created by Дмитрий Ю on 23.12.2017.
//  Copyright © 2017 Дмитрий Ю. All rights reserved.
//

import Foundation


struct StructDictToYobit : Decodable {
    var last : Double?
    var high : Double?
    var low : Double?
}

struct StructDict2 : Decodable {   //для графического баннера
    var ID : Int?
    var NameType : String?
}

struct StructDictForAdvTypes : Decodable {   //для получения списка кодов
    var get_adv_types = [StructDict2]()
}

struct StructDictDataById : Decodable {   //для получения баннера
    var Data : String?
}


