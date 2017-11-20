//
//  RegisterViewController.swift
//  My Clerkie
//
//  Created by Jeyashri Natarajan on 11/18/17.
//  Copyright © 2017 Clerkie. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var usernameTextfield: UITextField!
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var phonenumberTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var confirmTextfield: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    
    var activeTextfield:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //design the register buttton
        registerButton.layer.borderColor = UIColor.white.cgColor
        registerButton.layer.cornerRadius = 6
        registerButton.clipsToBounds = true
        registerButton.layer.borderWidth = 1
        
        //move textfield up on keyboard up
        let center:NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardDidShow(notification:Notification) {
        let info:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height
        let editingTextfieldY:CGFloat! = self.activeTextfield?.frame.origin.y
        
        if self.view.frame.origin.y >= 0{
            //checking if the textfield is hidden behind the keyboard
            if editingTextfieldY > keyboardY - 60 {
                UIView.animate(withDuration: 0.25,delay:0.0,options:UIViewAnimationOptions.curveEaseIn,animations:{self.view.frame = CGRect(x:0,y:self.view.frame.origin.y - (editingTextfieldY - (keyboardY - 120)),width:self.view.bounds.width,height:self.view.bounds.height)},completion:nil)
            }
        }
        
    }
    
    @objc func keyboardWillHide (notification:Notification) {
        UIView.animate(withDuration: 0.25,delay:0.0,options:UIViewAnimationOptions.curveEaseIn,animations:{self.view.frame = CGRect(x:0,y:0,width:self.view.bounds.width,height:self.view.bounds.height)},completion:nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextfield = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextfield:
            emailTextfield.becomeFirstResponder()
        case emailTextfield:
            phonenumberTextfield.becomeFirstResponder()
        case phonenumberTextfield:
            passwordTextfield.becomeFirstResponder()
        case passwordTextfield:
            confirmTextfield.becomeFirstResponder()
        default:
            confirmTextfield.resignFirstResponder()
        }
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if emailTextfield.text == "" || usernameTextfield.text == "" || passwordTextfield.text == "" || confirmTextfield.text == "" || phonenumberTextfield.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please fill all the fields", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
}


