//
//  PJRegisterView.swift
//  PuntoJalisco
//
//  Created by Felix on 9/7/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit
import Alamofire
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class PJRegisterView: UIViewController {

    enum Gender {
        case male
        case female
        case none
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
    
    let defaults:UserDefaults = UserDefaults.standard
    var params:[String:String] = [:]
    let registerPath = Constants.Paths.mainPath + Constants.Paths.registerPath
    
    var rawResponse = ""
    var parsedResponse = ""
    var token = ""
    var timer = Timer()
    var devMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        devMode = defaults.bool(forKey: Constants.isDevMode)
        
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: UIControlEvents.valueChanged)
        
        loadingIndicatorContainer.layer.cornerRadius = 10
        loadingIndicatorContainer.alpha = 0
        
        updateAlertContainer.layer.cornerRadius = 10
        updateAlertContainer.alpha = 0
        
        if !defaults.bool(forKey: Constants.isRegistred) {
            titleLabel.text = "Registrate aquí"
            registerButton.setTitle("Registrarme", for: UIControlState())
        }
        genderType = Gender.none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonPressed(_ sender: AnyObject) {
        if devMode{
            presentMainScreen()
        }else{
            registerUser()
        }
    }
    
    @IBAction func onSwitchValueChange(_ sender: AnyObject) {
        print("switch")
        if let flatSwitch = sender as? AIFlatSwitch {
            if flatSwitch == maleSwitch {
                if maleSwitch.isSelected {
                    genderType = .male
                    print("male \(flatSwitch.isSelected)")
                    if femaleSwitch.isSelected {
                        femaleSwitch.setSelected(!maleSwitch.isSelected, animated: true)
                    }
                }
            }else{
                if femaleSwitch.isSelected {
                    genderType = .female
                    print("female \(flatSwitch.isSelected)")
                    if maleSwitch.isSelected {
                        maleSwitch.setSelected(!femaleSwitch.isSelected, animated: true)
                    }
                }
            }
        }
    }
    
    func datePickerChanged(_ datePicker:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        let strDate = dateFormatter.string(from: datePicker.date)
        print(strDate)
        params[Constants.Register.birthDateKey] = strDate
    }

    func registerUser(){
        validateFields()
    }
    
    func networkCall(){
        Alamofire.request(registerPath, parameters:params)
            .validate()
            .responseString { response in
                print("Success: \(response.result.isSuccess)")
                print("URL: \(response.request?.url?.absoluteString)")
                if response.result.isSuccess{
                    self.rawResponse = response.result.value!
                    //let range = self.rawResponse.startIndex.advancedBy(0)..<self.rawResponse.startIndex.advancedBy(44)
                    let range = self.rawResponse.index(self.rawResponse.startIndex, offsetBy: 44)..<self.rawResponse.endIndex
                    self.parsedResponse = self.rawResponse.substring(with: range)
                    if self.parseToken(self.parsedResponse){
                        if !self.defaults.bool(forKey: Constants.isRegistred){
                            self.presentMainScreen()
                        }else{
                            self.hideActivityIndicator(true)
                        }
                    }
                }else{
                    self.hideActivityIndicator(false)
                    let alertController = UIAlertController(title: "Atención", message:"Ha ocurrido un error de conexión, por favor intentalo mas tarde.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
        }
    }
    
    func presentMainScreen(){
        self.hideActivityIndicator(false)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController
        UIView.transition(from: (UIApplication.shared.keyWindow?.rootViewController?.view)!,
                                  to: viewController.view,
                                  duration: 0.5,
                                  options: UIViewAnimationOptions.transitionFlipFromLeft,
                                  completion: { (finished) in
                                    UIApplication.shared.keyWindow?.rootViewController = viewController;
        })
        self.defaults.set(true, forKey: Constants.isRegistred)
        self.defaults.synchronize()
    }
    
    func parseToken(_ response:String) -> Bool{
        if response.characters.count > 0 {
            let range = response.characters.index(response.startIndex, offsetBy: 6)..<response.characters.index(response.endIndex, offsetBy: -2)
            token = response.substring(with: range)
            if token.characters.count > 0 {
                self.defaults.set(token, forKey: Constants.tokenKey)
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
        
        if genderType != Gender.none{
            let genderSelected = genderType == .male ? "H" : "M"
            params[Constants.Register.genderKey] = genderSelected
        }
        
        if fullNameTextField.text?.characters.count > 0 || emailTextField.text?.characters.count > 0 {
            showActivityIndicator()
            networkCall()
        }else{
            let alertController = UIAlertController(title: "Alerta", message:"Los campos no deben estar vacios, por favor verificalos", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
        
        print(params)
    }
    
    func showActivityIndicator(){
        activitiIndicator.startAnimating()
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingIndicatorContainer.alpha = 1
            }, completion: nil)
    }
    
    func hideActivityIndicator(_ showAlert:Bool){
        activitiIndicator.stopAnimating()
        UIView.animate(withDuration: 0.3, animations: { 
            self.loadingIndicatorContainer.alpha = 0
            }, completion: { (completed) in
                if showAlert{
                    self.showUpdatedAlert()
                }
        }) 
    }
    
    func showUpdatedAlert(){
        UIView.animate(withDuration: 0.3, animations: { 
            self.updateAlertContainer.alpha = 1
        }) 
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(hideUpdateAler), userInfo: nil, repeats: false)
    }
    
    func hideUpdateAler(){
        UIView.animate(withDuration: 0.3, animations: { 
            self.updateAlertContainer.alpha = 0
        }) 
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
