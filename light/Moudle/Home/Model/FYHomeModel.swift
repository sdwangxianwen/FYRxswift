//
//  FYHomeModel.swift
//  light
//
//  Created by wang on 2019/9/9.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit


struct  FYHomeModel: Codable {
    var product_category_list : [FYHomeCateListModel]
    
}

struct FYHomeCateListModel: Codable {
    var id : String!
    var img : String!
    var name : String!
}

struct FYChannelListModel: Codable {
    var channel_id : String!
    var name : String!
    var img : String!
}

struct FYLoginModel : Codable {
    let mobile : String?
    let token : String?
    let user_id : String?
    let name : String?

}

struct ErrorInfo: Decodable, Error {
    let rsp_code: String
    let rsp_msg: String
}
