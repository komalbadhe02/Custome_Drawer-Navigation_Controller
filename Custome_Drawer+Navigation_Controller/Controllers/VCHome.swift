///**
/**
 Custome_Drawer+Navigation_Controller
 VCHome.swift
 Created by: KOMAL BADHE on 03/01/19
 Copyright (c) 2019 KOMAL BADHE
 */

import UIKit
import AVFoundation
class VCHome: UIViewController,UITextFieldDelegate{
    @IBOutlet weak var tableViewObj: UITableView!
    @IBOutlet weak var collapseSearchContainer: NSLayoutConstraint!
    @IBOutlet weak var expandSearchContainer: NSLayoutConstraint!
    @IBOutlet weak var searchTxtFieldCloseBtn: UIButton!
    @IBOutlet weak var scanProductBtn: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.


        NotificationCenter.default.addObserver(self, selector: #selector(VCHome.receivedNotification(notification:)), name:.settings  , object:nil )
        NotificationCenter.default.addObserver(self, selector: #selector(VCHome.receivedNotification(notification:)), name:.dashboard  , object:nil )

        
        NotificationCenter.default.addObserver(self, selector: #selector(VCHome.receivedNotification(notification:)), name:.history  , object:nil )
        
        NotificationCenter.default.addObserver(self, selector: #selector(VCHome.receivedNotification(notification:)), name:.myProfile  , object:nil )
        
       
         NotificationCenter.default.addObserver(self, selector: #selector(VCHome.receivedNotification(notification:)), name:.login  , object:nil )
       
        
        searchTextField.delegate = self;
                searchTxtFieldCloseBtn.addTarget(self, action: #selector(closeSearchAction), for: .touchUpInside);
      
        
    }
    
    
    
        @IBAction func drawerButtonAction(_ sender: Any) {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
            let drawerC =  appDelegate?.window?.rootViewController as? KYDrawerController
            drawerC?.setDrawerState(KYDrawerController.DrawerState.opened, animated: true)
    
        }
    
    
    @objc func  receivedNotification(notification: NSNotification){
                let topC =  self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 1]
        
                let notifyType = notification.name.rawValue;
                switch notifyType {
        
                
                case "settings":
                    tabBarController?.selectedIndex = 1;
        
                    break;
        
                case "dashboard":
                    tabBarController?.selectedIndex = 0;
                    navigationController?.popToRootViewController(animated: true)
                    break;
        
                case "history" :
        
                    tabBarController?.selectedIndex = 3;
                    navigationController?.popToRootViewController(animated: true)
                    break;
        
        
               
                case "myProfile" :
        
        
                    tabBarController?.selectedIndex = 2;
        
                    let  viewObj = self.storyboard?.instantiateViewController(withIdentifier: "myProfileVCID") as? VCMyProfile
        
                    if topC is VCMyProfile {
                        return
                    }
                    self.navigationController?.pushViewController(viewObj!, animated: true)
        
             case "login" :
                    UserHandler().isLoginRequired(status: true);
                    UserHandler().saveUserSession(status: false);
                 
                    
                    break;
                default:
                    break
                }
            }
    
        @IBAction func searchEquipmentAction(_ sender: Any) {
    
            if expandSearchContainer.constant == 59 {
                collapseSearchContainer.constant = 0;
                expandSearchContainer.constant = 0;
            }
            else if
                expandSearchContainer.constant == 0{
                collapseSearchContainer.constant = 0;
                expandSearchContainer.constant = 59;
            }
        }
    
//    MARK: - textfield Delegates
    
        func textFieldShouldReturn(_ textField: UITextField) -> Bool{
    
            if textField.text?.trimmingCharacters(in: .whitespaces).count != 0 {
                closeSearchAction();
            }
            else{
                let alert = UIAlertController(title: "Warning", message: "Type something to search!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    
                self.present(alert, animated: true, completion: nil)
            }
            return true
        }
    
    
        @objc func closeSearchAction() {
    
            collapseSearchContainer.constant = 0;
            expandSearchContainer.constant = 0;
            searchTextField.text = "";
            searchTextField.resignFirstResponder()
        }
    
    

    
}

