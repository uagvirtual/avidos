//
//  PJRegisterView.swift
//  PuntoJalisco
//
//  Created by Felix on 9/7/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit
import Alamofire

class PJRegisterView: UIViewController {

    enum Gender {
        case Male
        case Female
    }
    var genderType:Gender!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var maleSwitch: AIFlatSwitch!
    @IBOutlet weak var femaleSwitch: AIFlatSwitch!
    @IBOutlet weak var loadingIndicatorContainer: UIView!
    @IBOutlet weak var activitiIndicator: UIActivityIndicatorView!
    @IBOutlet weak var updateAlertContainer: UIView!
    
    let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var params:[String:String] = [:]
    let registerPath = Constants.Paths.mainPath + Constants.Paths.registerPath
    
    var rawResponse = ""
    var parsedResponse = ""
    var token = ""
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.addTarget(self, action: #selector(datePickerChanged), forControlEvents: UIControlEvents.ValueChanged)
        
        loadingIndicatorContainer.layer.cornerRadius = 10
        loadingIndicatorContainer.alpha = 0
        
        updateAlertContainer.layer.cornerRadius = 10
        updateAlertContainer.alpha = 0
        
        if !defaults.boolForKey(Constants.isRegistred) {
            titleLabel.text = "Registrate aquí"
            registerButton.setTitle("Registrarme", forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonPressed(sender: AnyObject) {
        registerUser()
    }
    
    @IBAction func onSwitchValueChange(sender: AnyObject) {
        print("switch")
        if let flatSwitch = sender as? AIFlatSwitch {
            if flatSwitch == maleSwitch {
                if maleSwitch.selected {
                    genderType = .Male
                    print("male \(flatSwitch.selected)")
                    if femaleSwitch.selected {
                        femaleSwitch.setSelected(!maleSwitch.selected, animated: true)
                    }
                }
            }else{
                if femaleSwitch.selected {
                    genderType = .Female
                    print("female \(flatSwitch.selected)")
                    if maleSwitch.selected {
                        maleSwitch.setSelected(!femaleSwitch.selected, animated: true)
                    }
                }
            }
        }
    }
    
    func datePickerChanged(datePicker:UIDatePicker){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        print(strDate)
        params[Constants.Register.birthDateKey] = strDate
    }

    func registerUser(){
        showActivityIndicator()
        validateFields()
        Alamofire.request(.GET, registerPath, parameters:params)
            .validate()
            .responseString { response in
                print("Success: \(response.result.isSuccess)")
                if response.result.isSuccess{
                    self.rawResponse = response.result.value!
                    let range = self.rawResponse.startIndex.advancedBy(0)..<self.rawResponse.startIndex.advancedBy(44)
                    self.parsedResponse = self.rawResponse.substringWithRange(range)
                    if self.parseToken(self.parsedResponse){
                        if !self.defaults.boolForKey(Constants.isRegistred){
                            self.hideActivityIndicator(false)
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let viewController = mainStoryboard.instantiateViewControllerWithIdentifier("mainTabBarController") as! UITabBarController
                            UIView.transitionFromView((UIApplication.sharedApplication().keyWindow?.rootViewController?.view)!,
                                toView: viewController.view,
                                duration: 0.5,
                                options: UIViewAnimationOptions.TransitionFlipFromLeft,
                                completion: { (finished) in
                                    UIApplication.sharedApplication().keyWindow?.rootViewController = viewController;
                            })
                            self.defaults.setBool(true, forKey: Constants.isRegistred)
                            self.defaults.synchronize()
                        }else{
                            self.hideActivityIndicator(true)
                        }
                    }
                }
        }
    }
    
    func parseToken(response:String) -> Bool{
        if response.characters.count > 0 {
            let range = response.startIndex.advancedBy(6)..<response.endIndex.advancedBy(-2)
            token = response.substringWithRange(range)
            if token.characters.count > 0 {
                self.defaults.setObject(token, forKey: Constants.tokenKey)
                self.defaults.synchronize()
                print(token)
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    func validateFields(){
        if let fullName = fullNameTextField.text {
            if fullName.characters.count > 0 {
                params[Constants.Register.nameKey] = fullName
            }
        }
        
        if let email = emailTextField.text{
            if email.characters.count > 0 {
                params[Constants.Register.emailKey] = email
            }
        }
        
        let genderSelected = genderType == .Male ? "H" : "M"
        params[Constants.Register.genderKey] = genderSelected
        
        print(params)
    }
    
    func showActivityIndicator(){
        activitiIndicator.startAnimating()
        UIView.animateWithDuration(0.3, animations: {
            self.loadingIndicatorContainer.alpha = 1
            }, completion: nil)
    }
    
    func hideActivityIndicator(showAlert:Bool){
        activitiIndicator.stopAnimating()
        UIView.animateWithDuration(0.3, animations: { 
            self.loadingIndicatorContainer.alpha = 0
            }) { (completed) in
                if showAlert{
                    self.showUpdatedAlert()
                }
        }
    }
    
    func showUpdatedAlert(){
        UIView.animateWithDuration(0.3) { 
            self.updateAlertContainer.alpha = 1
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(hideUpdateAler), userInfo: nil, repeats: false)
    }
    
    func hideUpdateAler(){
        UIView.animateWithDuration(0.3) { 
            self.updateAlertContainer.alpha = 0
        }
        timer.invalidate()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
