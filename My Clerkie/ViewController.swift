//
//  ViewController.swift
//  My Clerkie
//
//  Created by Jeyashri Natarajan on 11/18/17.
//  Copyright © 2017 Clerkie. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var signinButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
     var activeTextfield:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //design the signin button
        signinButton.layer.cornerRadius = 6
        signinButton.clipsToBounds = true
        
        //design the register buttton
        registerButton.layer.borderColor = UIColor.white.cgColor
        registerButton.layer.cornerRadius = 6
        registerButton.clipsToBounds = true
        registerButton.layer.borderWidth = 1
        
        //move textfield up on keyboard up
        let center:NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //to dismiss keyboard
        self.hideKeyboard()
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
            case usernameTextField:
                passwordTextfield.becomeFirstResponder()
            default:
                passwordTextfield.resignFirstResponder()
            }
            return true
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func signinPressed(_ sender: UIButton) {
        if self.usernameTextField.text == "" || self.passwordTextfield.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.usernameTextField.text!, password: self.passwordTextfield.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
