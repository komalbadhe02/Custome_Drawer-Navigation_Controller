///**
/**
 Custome_Drawer+Navigation_Controller
 VCLogin.swift
 Created by: KOMAL BADHE on 03/01/19
 Copyright (c) 2019 KOMAL BADHE
 */

import UIKit

class VCLogin: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkboxImageView: UIImageView!
    var checkBoxSelected = String();
    var tapGesture = UITapGestureRecognizer();
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        separatorView.applyBottomShadow();
        self.navigationItem.hidesBackButton = true;
        self.navigationItem.backBarButtonItem = nil;
        userNameTextField.delegate = self;
        passwordTextField.delegate = self;
        
        //tap gesture for dismiss keyboard
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.addTarget(self, action: #selector(dismissKeyBoardAction));
        self.view.addGestureRecognizer(tapGesture);
    }
    
    override func viewWillAppear(_ animated: Bool){
        checkBoxSelected = "false";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyBoardAction() {
        self.view.endEditing(true);
    }
    
    // MARK: - textfield delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if textField == userNameTextField {
            userNameTextField.resignFirstResponder();
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField{
            passwordTextField.resignFirstResponder();
        }
        return true;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
 
    @IBAction func signInBtnAction(_ sender: Any) {
        
        
      
    

    dismissKeyBoardAction();
        if validateData() {
            var response_dict = NSDictionary();
            
        response_dict =   UserHandler().authenticate_user(username: userNameTextField.text!, password: passwordTextField.text!)
            print(response_dict)
            
            if response_dict.value(forKey: "status") as! String == "true"{
                    UserHandler().saveUserId(user_id: "1")
                     UserHandler().saveUserSession(status: true);
                 NotificationCenter.default.post(name: .login, object: nil)
            }
            
        }

       
    }
    
    
    func validateData() -> Bool {
        
        if userNameTextField.text?.trimmingCharacters(in: .whitespaces).count != 0 {
            
            if passwordTextField.text?.trimmingCharacters(in: .whitespaces).count != 0 {
                
                if  isConnectedToNetwork(){
                 return true
                }
                else{
                    showAlert(message: "No internet connection please try again.",viewController: self);
                    return false
                }
       }
            else{
                showAlert(message: "Please enter  password.",viewController: self);
                      return false
            }
            
        }
        else{
            showAlert(message: "Please enter user name.",viewController: self);
                  return false
        }

    }
    
    
    @IBAction func skipToScanBtnAction(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    @IBAction func rememberMeAction(_ sender: Any) {
        if checkBoxSelected == "true" {
            checkboxImageView.image = UIImage(named: "unSelectedCheckBox");
            checkBoxSelected = "false"
        }
        else{
            checkboxImageView.image = UIImage(named: "selectedCheckBox");
            checkBoxSelected = "true"
        }
        
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
   
//        let forgotPasswordVCObj = self.storyboard?.instantiateViewController(withIdentifier: "vcForgotPasswordID") as! VCForgotPassword
//        self.navigationController?.pushViewController(forgotPasswordVCObj, animated: true)
        

    }
    
    
    @IBAction func registrationAction(_ sender: Any) {
//      let registrationVCObj = self.storyboard?.instantiateViewController(withIdentifier: "vcRegistrationId") as! VCRegistration
// self.navigationController?.pushViewController(registrationVCObj, animated: true)
        
    }
    
   
  
}
