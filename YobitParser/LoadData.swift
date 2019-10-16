//
//  LoadData.swift
//  YobitParser
//
//  Created by Дмитрий Ю on 23.12.2017.
//  Copyright © 2017 Дмитрий Ю. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

func loadData(name : String) -> Void {
    request("https://yobit.net/api/3/ticker/" + name).responseJSON { responseJSON in
        print(responseJSON)
    }
    print("viewDidLoad ended")
}

func loadDataPing() -> Void {
    
    let jsonQuery: [String: Any] = [
    "query": " { ping }\n",
    //"variables": "null"
    ]
//{"query":"query { ping }\n","variables":null}
    let headers: HTTPHeaders = [
        "Connection": "keep-alive",
        "Origin": "null",
        "DNT": "1",
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Accept-Language": "ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7"]
    
    request("http://107.191.52.235/getdata.php", method: .post, parameters: jsonQuery, encoding: JSONEncoding.default, headers: headers).responseJSON { responseJSON in
        print(responseJSON)
    }
    print("viewDidLoad ended")
}
//=========================================================================================================================
//Возвращает рекламную информацию с сервера клиентскому приложению с учетом указанных параметров.
func getInfoData() -> Void {
    let jsonQuery: [String: Any] = [
       "query":"{\n get_info_data(api_key: \"00000000-0000-0000-0000-000000000000\")\n {ID CreatedAt AdvTypeID GroupID Descr Comment TargetURL Width Height Orientation IsActive Data DataSize Ext AgeRate}}\n",
        //"query":"{\n get_type_descr(api_key: \"00000000-0000-0000-0000-000000000000\", code: 1)\n}\n",
        //"query":"{\n get_info_types(api_key: \"00000000-0000-0000-0000-000000000000\")\n}\n",
        //"query":"{\n get_adv_types(api_key: \"00000000-0000-0000-0000-000000000000\")\n {ID NameType}}\n",  //победил)))
        "info_type":"1",
        "max_x": "30",
        "max_y": "30",
        "max_age_rate": "0",
        "variables":"null",
        "operationName":"null"
    ]
    let headers: HTTPHeaders = [
        "Connection": "keep-alive",
        "Origin": "null",
        "DNT": "1",
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Accept-Language": "ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7"]
    
    request("http://107.191.52.235/getdata.php", method: .post, parameters: jsonQuery, encoding: JSONEncoding.default, headers: headers).responseJSON { responseJSON in
    print(responseJSON)
    }
    print("viewDidLoad ended")
}
//======================================================================================================================

//get_adv_types(api_key: String): [AdvTypeData]
//Получить полный список кодов доступной информации и их наименование.

func getAdvTypes(complition : @escaping([String: StructDictForAdvTypes]) -> Void ) {
    let jsonQuery: [String: Any] = [
        "query":"{\n get_adv_types(api_key: \"00000000-0000-0000-0000-000000000000\")\n {ID NameType}}\n",
     //   "variables":"null",
     //   "operationName":"null"
    ]
    let headers: HTTPHeaders = [
        "Connection": "keep-alive",
        "Origin": "null",
        "DNT": "1",
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Accept-Language": "ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7"]
    
    request("http://107.191.52.235/getdata.php", method: .post, parameters: jsonQuery, encoding: JSONEncoding.default, headers: headers).responseJSON
        { responseJSON in
        do {
            let structure = try JSONDecoder().decode([String: StructDictForAdvTypes].self, from: responseJSON.data!)
            complition(structure)
        } catch let error { print(error)}
    }
    print("viewDidLoad ended")
}

//===================================================================================================================================
//get_info_list(api_key: String): [InfoData]
//Возвращает список доступной рекламной информации (баннеров) на сервере

func getInfoList() -> Void {
    let jsonQuery: [String: Any] = [
        "query":"{\n get_info_list(api_key: \"00000000-0000-0000-0000-000000000000\")\n {ID CreatedAt AdvTypeID GroupID Descr Comment TargetURL Width Height Orientation IsActive Data DataSize Ext AgeRate}}\n",
        //"query":"{\n get_type_descr(api_key: \"00000000-0000-0000-0000-000000000000\", code: 1)\n}\n",
        //"query":"{\n get_info_types(api_key: \"00000000-0000-0000-0000-000000000000\")\n}\n",
        //"query":"{\n get_adv_types(api_key: \"00000000-0000-0000-0000-000000000000\")\n {ID NameType}}\n",  //победил)))
        "info_type":"1",
        "max_x": "30",
        "max_y": "30",
        "max_age_rate": "0",
        "variables":"null",
        "operationName":"null"
    ]
    let headers: HTTPHeaders = [
        "Connection": "keep-alive",
        "Origin": "null",
        "DNT": "1",
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Accept-Language": "ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7"]
    
    request("http://107.191.52.235/getdata.php", method: .post, parameters: jsonQuery, encoding: JSONEncoding.default, headers: headers).responseJSON { responseJSON in
        print(responseJSON)
    }
    print("viewDidLoad ended")
}
//===================================================================================================================================

//get_info_data_by_id(api_key: StringID: Int): InfoData
//Возвращает одну запись с рекламной информацией по её идентификатору (ID). Для получения ID используйте get_info_list.

func getInfoDataById(id : Int) -> Void {
    let jsonQuery: [String: Any] = [
        "query":"{\n get_info_data_by_id(api_key: \"00000000-0000-0000-0000-000000000000\", ID: \(id))\n {ID CreatedAt AdvTypeID GroupID Descr Comment TargetURL Width Height Orientation IsActive Data DataSize Ext AgeRate}}\n",
        //"query":"{\n get_type_descr(api_key: \"00000000-0000-0000-0000-000000000000\", code: 1)\n}\n",
        //"query":"{\n get_info_types(api_key: \"00000000-0000-0000-0000-000000000000\")\n}\n",
        //"query":"{\n get_adv_types(api_key: \"00000000-0000-0000-0000-000000000000\")\n {ID NameType}}\n",  //победил)))
        "info_type":"1",
        "max_x": "30",
        "max_y": "30",
        "max_age_rate": "0",
        "variables":"null",
        "operationName":"null"
    ]
    let headers: HTTPHeaders = [
        "Connection": "keep-alive",
        "Origin": "null",
        "DNT": "1",
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Accept-Language": "ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7"]
    
    request("http://107.191.52.235/getdata.php", method: .post, parameters: jsonQuery, encoding: JSONEncoding.default, headers: headers).responseJSON { responseJSON in
        print(responseJSON)
    }
    print("viewDidLoad ended")
}

//===================================================================================================================================

func loadDataFromYobit(name :String, complition : @escaping([String: StructDictToYobit]) -> Void ) {  // for StructDict
    request("https://yobit.net/api/3/ticker/" + name).responseJSON
        { responseJSON in
            //print(responseJSON)
            do {
                let structure = try JSONDecoder().decode([String: StructDictToYobit].self, from: responseJSON.data!)
                complition(structure)
            } catch let error { print(error)}
        }
    print("viewDidLoad ended")
}


