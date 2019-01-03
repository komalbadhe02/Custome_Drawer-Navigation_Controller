///**
/**
 Custome_Drawer+Navigation_Controller
 VCSettings.swift
 Created by: KOMAL BADHE on 03/01/19
 Copyright (c) 2019 KOMAL BADHE
 */

import UIKit

class VCSettings: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func drawerButtonAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let drawerC =  appDelegate?.window?.rootViewController as? KYDrawerController
        drawerC?.setDrawerState(KYDrawerController.DrawerState.opened, animated: true)
        
    }
}
