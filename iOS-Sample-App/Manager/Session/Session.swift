//
//  Session.swift
//  iOS-Sample-App
//
//  Created by Rith on 27/9/21.
//

import Foundation

class Session {
    
    static let shared = Session()
    let preference = UserDefaults.standard
    
    func getHeaderToken() -> String{
        return preference.string(forKey: "token") ?? ""
    }
    
    func saveUserLogin(date: UserInfo) {
        preference.save(object: date, forKey: "userInfo")
    }
    
    func getUserData() -> UserInfo {
        guard let user = preference.object(UserInfo.self, with: "userInfo") else {
            return UserInfo()
        }
        return user
    }
    
    func resetUserData() {
        preference.removeObject(forKey: "userInfo")
    }
    
}

struct UserInfo: Codable {
    var name: String?
}
