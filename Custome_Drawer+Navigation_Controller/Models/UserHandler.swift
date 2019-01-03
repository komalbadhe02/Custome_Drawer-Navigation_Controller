///**
/**
 Custome_Drawer+Navigation_Controller
 UserHandler.swift
 Created by: KOMAL BADHE on 03/01/19
 Copyright (c) 2019 KOMAL BADHE
 */

import Foundation
class UserHandler: NSObject {
    var userDetailsDict = NSMutableDictionary();
    //Mark : initialization
    func initialize(clientID:String,userName : String, password : String,rememberMe : String,name :String)  {
        self.userDetailsDict = ["user_id":clientID,"username":userName,"password":password,"RememberMe":rememberMe,"name":name];
        self.saveUserDetails();
    }
    //Mark : update user details
    func updateUserDetails(clientID: String,userName : String,password : String , deviceID : String , rememberMe : String , name :String)  {
        self.userDetailsDict.setValue(name, forKey: "name")
        self.userDetailsDict.setValue(clientID, forKey: "client_id")
        self.userDetailsDict.setValue(userName, forKey: "username")
        self.userDetailsDict.setValue(password, forKey: "password")
        self.userDetailsDict.setValue(rememberMe, forKey: "RememberMe")
        self.saveUserDetails();
    }
    //Mark: Fetch user details
    @objc func getUserDetails() -> NSDictionary{
        let details : NSDictionary =  NSDictionary(dictionary: UserDefaults.standard.object(forKey: "UserDetails") as! NSMutableDictionary);
        let userDetails : NSDictionary = NSDictionary(dictionary: details);
        return userDetails;
    }
    //Mark: Save user details
    func saveUserDetails()  {
        UserDefaults.standard.set(self.userDetailsDict , forKey: "UserDetails");
        UserDefaults.standard.synchronize();
    }
    //MARK: - save user session
    func saveUserSession(status : Bool) {
        UserDefaults.standard.set(status , forKey: "isLoggedIn");
        UserDefaults.standard.synchronize();
    }
    //MARK: - get user session
    func getUserLoginSession() -> Bool {
        
        if UserDefaults.standard.dictionaryRepresentation().keys.contains("isLoggedIn"){
            return UserDefaults.standard.value(forKey: "isLoggedIn") as! Bool
        }
        
        else{
            return false;
        }
        
        
    }
    
    
    func authenticate_user(username : String , password :String) -> NSDictionary {
        var response_Dict  =  NSDictionary();
        
        if username == "komal"  && password == "komal"  {
            response_Dict  = ["status" : "true"];
        }
        else{
            response_Dict =  ["status" : "false"];
        }
        return response_Dict;
    }
    
    func isLoginRequired(status : Bool)  {
        UserDefaults.standard.set(status, forKey: "loginRequired");
    }
    
    func saveUserId(user_id : String) {
      
        UserDefaults.standard.set(user_id, forKey: "user_id");
    }
    func getUserId() -> String {
        return UserDefaults.standard.value(forKey: "user_id") as! String;
    }
}
