//
//  PJRegisterView.swift
//  PuntoJalisco
//
//  Created by Felix on 9/7/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit

class PJRegisterView: UIViewController {

    enum Gender {
        case Male
        case Female
    }
    var genderType:Gender!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var maleSwitch: AIFlatSwitch!
    @IBOutlet weak var femaleSwitch: AIFlatSwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.addTarget(self, action: #selector(datePickerChanged), forControlEvents: UIControlEvents.ValueChanged)        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonPressed(sender: AnyObject) {
        PJNetworkCalls().registerUser()
    }
    
    @IBAction func onSwitchValueChange(sender: AnyObject) {
        if let flatSwitch = sender as? AIFlatSwitch {
            if flatSwitch == maleSwitch {
                if maleSwitch.selected {
                    genderType = .Male
                    if femaleSwitch.selected {
                        print("male \(flatSwitch.selected)")
                        femaleSwitch.setSelected(!maleSwitch.selected, animated: true)
                    }
                }
            }else{
                if femaleSwitch.selected {
                    genderType = .Female
                    if maleSwitch.selected {
                        print("female \(flatSwitch.selected)")
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
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
