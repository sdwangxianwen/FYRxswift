//
//  FYUser.swift
//  light
//
//  Created by wang on 2019/9/9.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit

struct UserDefaultKeys  {
    struct account {
        static let userName = "userName"
        static let password = "password"
    }
    struct LoginInfo {
       static let token = "token"
       static let userId = "userId"
    }
    
    struct settingInfo {
       static let hostApi = "hostApi"
        
    }
}

//存储usertoken
func saveUserToken(userToken:String) {
    UserDefaults.standard.set(userToken, forKey: UserDefaultKeys.LoginInfo.token)
}

/// 读取usertoken
///
/// - Returns: usertoken
func readUserToken() -> String {
    return UserDefaults.standard.string(forKey: UserDefaultKeys.LoginInfo.token) ?? ""
}

/// 存储userID
///
/// - Parameter userID: userId
func saveUserID(userID:String) {
    UserDefaults.standard.set(userID, forKey: UserDefaultKeys.LoginInfo.userId)
}

/// 读取useriD
///
/// - Returns: userid
func readUserID() -> String {
    return UserDefaults.standard.string(forKey: UserDefaultKeys.LoginInfo.userId) ?? ""
}

func saveUserID(userName:String) {
    UserDefaults.standard.set(userName, forKey: UserDefaultKeys.account.userName)
}
func readuserName() -> String {
    return UserDefaults.standard.string(forKey: UserDefaultKeys.account.userName) ?? ""
}

func saveHostApi(hostApi:String) {
    UserDefaults.standard.set(hostApi, forKey: UserDefaultKeys.settingInfo.hostApi)
}
func readHostApi() -> String {
    return UserDefaults.standard.string(forKey: UserDefaultKeys.settingInfo.hostApi) ?? "http://test.quhuimai.com/app/"
}

class FYUser: NSObject {
   
    
}
