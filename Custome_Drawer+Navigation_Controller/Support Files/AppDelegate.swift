///**
/**
Custome_Drawer+Navigation_Controller
AppDelegate.swift
Created by: KOMAL BADHE on 03/01/19
Copyright (c) 2019 KOMAL BADHE
*/

import UIKit
import AVFoundation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var storyBoard: UIStoryboard?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        NotificationCenter.default.addObserver(self, selector: #selector(loginBtnNotification(notification:)), name:.login , object:nil )
        
        NotificationCenter.default.addObserver(self, selector: #selector(logoutBtnNotification(notification:)), name:.logout , object:nil )
        
        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        UserHandler().isLoginRequired(status: false)
        
        //customize navigation bar
        
        let navigationBarBgColor = UIColor(red: 35.0/255.0, green: 172.0/255.0, blue: 180.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().barTintColor = navigationBarBgColor;
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "SairaCondensed-Medium", size: 22)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        //customize status bar
        UIApplication.shared.statusBarStyle = .lightContent
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "scannerVCID")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController =  UINavigationController(rootViewController: mainViewController)
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    @objc func getPlistPath() -> String {
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = (documentDirectory as NSString).appending("/profile.plist")
        
        return path;
    }
    
    
    
    //Set status bar color
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    
    @objc func logoutBtnNotification(notification: NSNotification)  {
        
        UserHandler().saveUserId(user_id: "0");
        let mainViewController = storyBoard?.instantiateViewController(withIdentifier: "scannerVCID")
        
        window?.rootViewController =  UINavigationController(rootViewController: mainViewController!)
        window?.makeKeyAndVisible()
        
    }
    
    
    @objc func loginBtnNotification(notification: NSNotification)  {
        
        let tabBarVCObj = storyBoard?.instantiateViewController(withIdentifier: "tabBarID")
        
        //   tabBarVCObj?.tabBarController?.selectedIndex = selectedTabIndex;
        let drawerViewController = storyBoard?.instantiateViewController(withIdentifier: "homeDrawerVCID")
        let drawerController     = KYDrawerController(drawerDirection: KYDrawerController.DrawerDirection(rawValue: 0)!, drawerWidth: ((window?.frame.size.width)!/4)*3)
        drawerController.mainViewController = tabBarVCObj
        drawerController.drawerViewController = drawerViewController
        
        if let dict_obj : NSDictionary = notification.object as? NSDictionary {
            if selectedTabIndex == 0{
                
                let homeVCObj = ((((tabBarVCObj as! UITabBarController).viewControllers!  as NSArray).object(at: 0) as! UINavigationController).viewControllers as NSArray).object(at: 0) as! VCHome

                
            }
            
        }
        window?.rootViewController =   drawerController
        window?.makeKeyAndVisible()
    }
    
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
      
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

