///**
/**
 Custome_Drawer+Navigation_Controller
 VCHomeDrawer.swift
 Created by: KOMAL BADHE on 03/01/19
 Copyright (c) 2019 KOMAL BADHE
 */

import UIKit
class VCHomeDrawer: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableViewObj: UITableView!
    
    var userDetailsDict = NSDictionary();
    var tapGestureObj = UITapGestureRecognizer();
    
    var drawerDetailsArray = NSMutableArray()
    
    var login_DetailsArray : NSArray = [["Title":"User Name","Image":"user"],["Title":"Dashboard","Image":"Dashboard"],["Title":"History","Image":"img-criteria"],["Title":"Settings","Image":"Selected_Settings"],["Title":"Logout","Image":"LOGOUT"]];
    
    
    var logout_DetailsArray : NSArray = [["Title":"Guest","Image":"user"],
                                         ["Title":"Scan QR","Image":"scanProduct"],
                                         ["Title":"Dashboard","Image":"Dashboard"],["Title":"Login","Image":"login"]];
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableViewObj.backgroundView?.backgroundColor = UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1) ;

                actionForLoadingView();
                tableViewObj.bounces = false;
                tableViewObj.dataSource = self;
                tableViewObj.delegate = self;
        
                tapGestureObj.numberOfTapsRequired = 1;
                tapGestureObj.addTarget(self, action: #selector(openMyProfile))
        
                if UserHandler().getUserLoginSession()  {
                    drawerDetailsArray = NSMutableArray(array: login_DetailsArray);
                }
                else{
                     drawerDetailsArray = NSMutableArray(array: logout_DetailsArray);
                }
    }
    
        //MARK: - action for loading table view cells
        func actionForLoadingView() {
            tableViewObj.register(UINib(nibName: "DrawerHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "drawerHeaderCellID");
            tableViewObj.register(UINib(nibName: "DrawerTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "drawerCellID");
        }
    
        @objc func openMyProfile()  {
    
    
            if UserHandler().getUserLoginSession() {
                if let drawerController = parent as? KYDrawerController {
                    drawerController.setDrawerState(.closed, animated: true)
                }
                NotificationCenter.default.post(name: .myProfile, object: NSNotification.Name.myProfile)
            }
            else{
                showLoginPopup();
            }
    
        }
    
        func showLoginPopup() {
    
            let alert = UIAlertController(title: "Login Required",
                                          message: "Do you want to login???",
                                          preferredStyle: UIAlertControllerStyle.alert)
    
    
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
    
            let loginAction = UIAlertAction.init(title: "Login", style: .default, handler: { (action) in
    
                UserHandler().isLoginRequired(status: true);
    
               UserHandler().saveUserSession(status: false);
                NotificationCenter.default.post(name: .logout, object: NSNotification.Name.logout)
            })
    
            alert.addAction(cancelAction)
            alert.addAction(loginAction)
            self.present(alert, animated: true, completion: nil)
        }
    
    
        //MARK:- table view datasource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return drawerDetailsArray.count;
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "drawerHeaderCellID") as! DrawerHeaderTableViewCell
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "drawerCellID") as! DrawerTitleTableViewCell
            if indexPath.row == 0{
                headerCell.userNameLabel.text = "WELCOME";
                headerCell.emailIdLabel.text = (drawerDetailsArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "Title") as? String; headerCell.viewForTapGuesture.addGestureRecognizer(tapGestureObj)
                headerCell.initialize();
                return headerCell;
            }
            else{
                titleCell.iconImageView.image = UIImage(named:  (drawerDetailsArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "Image") as! String )
                titleCell.titleLabel.text = (drawerDetailsArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "Title") as? String
                return titleCell;
            }
        }
    
    
        //MARK:- tableview delegates
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
            if indexPath.row == 0 {
                return 180;
            }
            else{
                return 44;
            }
        }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            if indexPath.row != 0 {
                let cellObj = tableView.cellForRow(at: indexPath) as! DrawerTitleTableViewCell
                let cellTitle : String = (cellObj.titleLabel.text?.description)!
                if let drawerController = parent as? KYDrawerController {
                    drawerController.setDrawerState(.closed, animated: true)
                }
                switch cellTitle {
    
                case "Dashboard" :
                    if UserHandler().getUserLoginSession(){
                        NotificationCenter.default.post(name: .dashboard, object: NSNotification.Name.dashboard)

                    }
                    else{
                     showLoginPopup()
                    }
                    break;
    
                case "History" :
                    NotificationCenter.default.post(name: .history, object: NSNotification.Name.history)
                    break;
    
                case "Settings" :
                    NotificationCenter.default.post(name: .settings, object: NSNotification.Name.settings)
                    break;
    
             
    
                case "Logout":
                    selectedTabIndex = 0;
    
                    UserHandler().saveUserSession(status: false);
                    NotificationCenter.default.post(name: .login, object: NSNotification.Name.login)
                    break;
    
                  
                case "Login":
                    UserHandler().isLoginRequired(status: true);
                   UserHandler().saveUserSession(status: false);
                   NotificationCenter.default.post(name: .logout, object: NSNotification.Name.logout)
                    break
    
    
                default:
                    break;
                }
            }
        }
    
}

//
//import UIKit
//class VCHomeDrawer: UIViewController,UITableViewDelegate,UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    @IBOutlet weak var tableViewObj: UITableView!
//    
//    var userDetailsDict = NSDictionary();
//    var tapGestureObj = UITapGestureRecognizer();
//    
//    var drawerDetailsArray = NSMutableArray()
//    
//    
//    
////    var login_DetailsArray : NSArray = [["Title":"User Name","Image":"user"],["Title":"Dashboard","Image":"Dashboard"],["Title":"Add Request","Image":"Add-Request"],["Title":"History","Image":"img-criteria"],["Title":"Service Centers","Image":"Setting"],["Title":"List Of Contacts","Image":"List_of-Contact"],["Title":"Settings","Image":"Selected_Settings"],["Title":"Logout","Image":"LOGOUT"]];
//    
//    
//    
//    var login_DetailsArray : NSArray = [["Title":"User Name","Image":"user"],["Title":"Dashboard","Image":"Dashboard"],["Title":"History","Image":"img-criteria"],["Title":"Settings","Image":"Selected_Settings"],["Title":"Logout","Image":"LOGOUT"]];
//    
////var logout_DetailsArray : NSArray = [["Title":"Guest","Image":"user"],
////                                           ["Title":"Scan QR","Image":"scanProduct"],
////                                           ["Title":"Dashboard","Image":"Dashboard"],["Title":"Service Centers","Image":"Setting"],["Title":"List Of Contacts","Image":"List_of-Contact"],["Title":"Login","Image":"login"]];
//    var logout_DetailsArray : NSArray = [["Title":"Guest","Image":"user"],
//                                         ["Title":"Scan QR","Image":"scanProduct"],
//                                         ["Title":"Dashboard","Image":"Dashboard"],["Title":"Login","Image":"login"]];
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        self.tableViewObj.backgroundView?.backgroundColor = UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1) ;
//     
//      
//        actionForLoadingView();
//        tableViewObj.bounces = false;
//        tableViewObj.dataSource = self;
//        tableViewObj.delegate = self;
//        
//        tapGestureObj.numberOfTapsRequired = 1;
//        tapGestureObj.addTarget(self, action: #selector(openMyProfile))
//        
//        if UserHandler().getUserLoginSession()  {
//            drawerDetailsArray = NSMutableArray(array: login_DetailsArray);
//        }
//        else{
//             drawerDetailsArray = NSMutableArray(array: logout_DetailsArray);
//        }
//        
//       
//    }
////    //MARK: - action for loading table view cells
////    func actionForLoadingView() {
////        tableViewObj.register(UINib(nibName: "DrawerHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "drawerHeaderCellID");
////        tableViewObj.register(UINib(nibName: "DrawerTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "drawerCellID");
////    }
////    //MARK:- table view datasource
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
////        return drawerDetailsArray.count;
////    }
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
////        let headerCell = tableView.dequeueReusableCell(withIdentifier: "drawerHeaderCellID") as! DrawerHeaderTableViewCell
////        let titleCell = tableView.dequeueReusableCell(withIdentifier: "drawerCellID") as! DrawerTitleTableViewCell
////        if indexPath.row == 0{
////            headerCell.userNameLabel.text = "WELCOME";
////            headerCell.emailIdLabel.text = (drawerDetailsArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "Title") as? String; headerCell.viewForTapGuesture.addGestureRecognizer(tapGestureObj)
////            headerCell.initialize();
////            return headerCell;
////        }
////        else{
////
////
////
////            titleCell.iconImageView.image = UIImage(named:  (drawerDetailsArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "Image") as! String )
////            titleCell.titleLabel.text = (drawerDetailsArray.object(at: indexPath.row) as! NSDictionary).value(forKey: "Title") as? String
////            return titleCell;
////        }
////    }
////    //MARK:- tableview delegates
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
////        if indexPath.row == 0 {
////            return 180;
////        }
////        else{
////            return 44;
////        }
////    }
////    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
////        if indexPath.row != 0 {
////            let cellObj = tableView.cellForRow(at: indexPath) as! DrawerTitleTableViewCell
////            let cellTitle : String = (cellObj.titleLabel.text?.description)!
////            if let drawerController = parent as? KYDrawerController {
////                drawerController.setDrawerState(.closed, animated: true)
////            }
////            switch cellTitle {
////
////            case "Dashboard" :
////
////                if UserHandler().getUserLoginSession(){
////                    NotificationCenter.default.post(name: .dashboard, object: NSNotification.Name.dashboard)
////
////                }
////                else{
////                 showLoginPopup()
////                }
////                break;
////
////            case "History" :
////                NotificationCenter.default.post(name: .history, object: NSNotification.Name.history)
////                break;
////
////            case "Settings" :
////                NotificationCenter.default.post(name: .settings, object: NSNotification.Name.settings)
////                break;
////
////            case "Service Centers":
////                NotificationCenter.default.post(name: .serviceCenters, object: NSNotification.Name.serviceCenters)
////                break;
////
////            case "Add Request":
////                NotificationCenter.default.post(name: .addRequest, object: NSNotification.Name.addRequest)
////                break;
////
////
////            case "List Of Contacts":
////                NotificationCenter.default.post(name: .listOfContacts, object: NSNotification.Name.listOfContacts)
////                break;
////
////            case "Logout":
////                selectedTabIndex = 0;
////
////                UserHandler().saveUserSession(status: false);
////
////                if DBManager.shared.deleteAllRecords(){
////                 SDImageCache.shared().clearMemory();
////SDImageCache.shared().clearDisk(onCompletion: nil);
////                    print(SDImageCache.shared().getSize());
////                    NotificationCenter.default.post(name: .logout, object: NSNotification.Name.logout)
////                }
////                else{
////                    showAlert(message: "Please try again", viewController: self);
////                }
////                break;
////
////            case "Scan QR" :
////              NotificationCenter.default.post(name: .scanProduct, object: NSNotification.Name.scanProduct)
////                break;
////
////            case "Login":
////                UserHandler().isLoginRequired(status: true);
////               UserHandler().saveUserSession(status: false);
////               NotificationCenter.default.post(name: .logout, object: NSNotification.Name.logout)
////                break
////
////
////            default:
////                break;
////            }
////        }
////    }
////    override func didReceiveMemoryWarning() {
////        super.didReceiveMemoryWarning()
////        // Dispose of any resources that can be recreated.
////    }
////
////    @objc func openMyProfile()  {
////
////
////        if UserHandler().getUserLoginSession() {
////            if let drawerController = parent as? KYDrawerController {
////                drawerController.setDrawerState(.closed, animated: true)
////            }
////            NotificationCenter.default.post(name: .myProfile, object: NSNotification.Name.myProfile)
////        }
////        else{
////            showLoginPopup();
////        }
////
////
////    }
////
////
////    func showLoginPopup() {
////
////        let alert = UIAlertController(title: "Login Required",
////                                      message: "Do you want to login???",
////                                      preferredStyle: UIAlertControllerStyle.alert)
////
////
////        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
////
////        let loginAction = UIAlertAction.init(title: "Login", style: .default, handler: { (action) in
////
////            UserHandler().isLoginRequired(status: true);
////
////           UserHandler().saveUserSession(status: false);
////            NotificationCenter.default.post(name: .logout, object: NSNotification.Name.logout)
////        })
////
////        alert.addAction(cancelAction)
////        alert.addAction(loginAction)
////        self.present(alert, animated: true, completion: nil)
////    }
//}
//
