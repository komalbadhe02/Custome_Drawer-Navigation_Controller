///**
/**
 Custome_Drawer+Navigation_Controller
 Extension.swift
 Created by: KOMAL BADHE on 03/01/19
 Copyright (c) 2019 KOMAL BADHE
 */

import Foundation
import UIKit
extension NSNotification.Name
{
      static let productDetails = Notification.Name("productDetails")
    static let validateProduct = Notification.Name("validateProduct")
    static let login = Notification.Name("login")
    static let serviceCenters = Notification.Name("serviceCenters")
    static let logout = Notification.Name("logout")
    static let scanProduct = Notification.Name("scanProduct")
    static let listOfContacts = Notification.Name("listOfContacts")
    static let settings = Notification.Name("settings")
    static let dashboard = Notification.Name("dashboard")
    static let history = Notification.Name("history")
    static let addRequest = Notification.Name("addRequest")
    static let viewAllDismissAction = Notification.Name("viewAllDismissAction")
    static let myProfile = Notification.Name("myProfile")
    static let qrCodeValidation = Notification.Name("qrCodeValidation")
}
extension UIView{
    @objc func applyBottomShadow() {
        self.backgroundColor = UIColor.groupTableViewBackground
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.2, height: 1)
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 1.0;
    }
}
@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
extension UITextField {
    @IBInspectable var placeholderColor: UIColor {
        get {
            guard let currentAttributedPlaceholderColor = attributedPlaceholder?.attribute(NSAttributedStringKey.foregroundColor, at: 0, effectiveRange: nil) as? UIColor else { return UIColor.clear }
            return currentAttributedPlaceholderColor
        }
        set {
            guard let currentAttributedString = attributedPlaceholder else { return }
            let attributes = [NSAttributedStringKey.foregroundColor : newValue]
            
            attributedPlaceholder = NSAttributedString(string: currentAttributedString.string, attributes: attributes)
        }
    }
}
