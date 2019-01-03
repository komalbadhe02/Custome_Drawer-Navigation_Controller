///**
/**
 Custome_Drawer+Navigation_Controller
 CommonUtils.swift
 Created by: KOMAL BADHE on 03/01/19
 Copyright (c) 2019 KOMAL BADHE
 */

import Foundation
import SystemConfiguration
import UIKit
func getStringWithSpace(stringObj : String , spacingValue : Float  , fontColor : UIColor , fontDetails : UIFont) -> NSAttributedString {
    let attrs = [
        NSAttributedStringKey.foregroundColor : fontColor ];
    let attributedString = NSMutableAttributedString(string: stringObj, attributes:attrs
    );
    attributedString.addAttribute(NSAttributedStringKey.font, value: fontDetails, range: NSRange(location: 0, length: (attributedString.string.count )))
    attributedString.addAttribute(NSAttributedStringKey.kern, value: spacingValue, range: NSRange(location: 0, length: (attributedString.string.count )))
    //MARK:- for underline
    //attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: 1, range: NSMakeRange(0, attributedString.string.count))
    //MARK:- for strikeThrough
    //attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.string.count))
    return attributedString;
}

//Mark: Check internet connection
func isConnectedToNetwork() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
}

func showAlert(message : String,viewController : UIViewController) {
    let alert = UIAlertController(title: "",
                                  message: message,
                                  preferredStyle: UIAlertControllerStyle.alert)
    let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
    alert.addAction(okAction)
    viewController.present(alert, animated: true, completion: nil)
}
func getTextFieldsContentView(width : CGFloat , height : CGFloat , imgName : String) -> UIView  {
    let  containerView = UIView(frame:CGRect(x:0, y:0, width:width, height:height))
    let imgView = UIImageView(frame: containerView.frame);
    imgView.image = UIImage(named: imgName);
    containerView.addSubview(imgView);
    return containerView;
}
func getDateInString(date : Date) -> String {
    let formatter = DateFormatter()
    // initially set the format based on your datepicker date
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let myString = formatter.string(from: date)
    // convert your string to date
    let yourDate = formatter.date(from: myString)
    //then again set the date format whhich type of output you need
    formatter.dateFormat = "dd MMM yyyy"
    // again convert your date to string
    let myStringafd = formatter.string(from: yourDate!)
    return myStringafd;
}
