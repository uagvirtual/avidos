//
//  PJRegisterContainer.swift
//  PuntoJalisco
//
//  Created by Felix on 9/8/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit

class PJRegisterContainer: UIViewController {

    @IBOutlet weak var customView: UIView!
    
    lazy var registerViewController: PJRegisterView = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "PJRegisterView") as! PJRegisterView
        
        // Add View Controller as Child View Controller
        self.addViewControllerAsChildViewController(viewController)
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerViewController.view.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    fileprivate func addViewControllerAsChildViewController(_ viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        self.customView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = self.customView.bounds
        //viewController.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    fileprivate func removeViewControllerAsChildViewController(_ viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }

}
