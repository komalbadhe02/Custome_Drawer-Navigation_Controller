///**
/**
 Custome_Drawer+Navigation_Controller
 VCScanner.swift
 Created by: KOMAL BADHE on 03/01/19
 Copyright (c) 2019 KOMAL BADHE
 */

import UIKit

class VCScanner: UIViewController {
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var scanButton: UIButton!
     @IBOutlet weak var scanImgBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(VCScanner.receivedNotification(notification:)), name:.validateProduct  , object:nil )
        
         
        
        if UserDefaults.standard.value(forKey: "loginRequired") as! Bool == true {
            moveToLogin(animated: false)
        }
        separatorView.applyBottomShadow();
        
        let title = getStringWithSpace(stringObj: "SCAN QR", spacingValue: 2.0, fontColor: UIColor.white, fontDetails: UIFont(name: "SairaCondensed-Medium", size: 22.0)!)
        scanButton.setAttributedTitle(title, for: .normal);
        
        let title1 = getStringWithSpace(stringObj: "SCAN Image", spacingValue: 2.0, fontColor: UIColor.white, fontDetails: UIFont(name: "SairaCondensed-Medium", size: 22.0)!)
        scanImgBtn.setAttributedTitle(title1, for: .normal);
        
        
    }
  
    @objc func  receivedNotification(notification: NSNotification){
        
//        WebServiceHandler().validateProduct(scanType: (notification.object as! NSDictionary).value(forKey: "scan_type") as! String, scanCode: (notification.object as! NSDictionary).value(forKey: "scan_code") as! String, parentController: self)
    
        
    }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func moveToLogin(animated : Bool)  {
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "vcLoginId") as! VCLogin
        self.navigationController?.pushViewController(loginViewController, animated: animated)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        moveToLogin(animated: true)
    }
    
  
    @IBAction func scanQRButtonAction(_ sender: Any)   {
//        
//        let  controllerObj = self.storyboard?.instantiateViewController(withIdentifier: "qrScannerVCID") as? VCQRCodeReader
//        controllerObj?.parentController = self;
//        
//        self.present(controllerObj!, animated: true, completion: nil);
    }
    
}
