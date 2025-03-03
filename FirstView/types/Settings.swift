//
//  Settings.swift
//  FirstView
//
//  Created by Vijayarajan Govindarajan on 3/2/25.
//

import Foundation

struct Settings{
    
    
    private static let userJwtwtKey : String = "UserJwtKey"
    
    static func saveUserJwt(_ value: String){
        UserDefaults.standard.set(value, forKey:userJwtwtKey)
    }
    
    static func getUserJwt()-> String?{
        return UserDefaults.standard.string(forKey: userJwtwtKey)
    }
    
    private static let selectedAccountKey : String = "SelectedAccountKey"
    
    static func saveSelectedAccount(_ value: String){
        UserDefaults.standard.set(value, forKey:selectedAccountKey)
    }
    
    static func getSelectedAccount()-> String?{
        return UserDefaults.standard.string(forKey: selectedAccountKey)
    }
}
