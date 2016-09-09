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
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewControllerWithIdentifier("PJRegisterView") as! PJRegisterView
        
        // Add View Controller as Child View Controller
        self.addViewControllerAsChildViewController(viewController)
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        registerViewController.view.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func addViewControllerAsChildViewController(viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        self.customView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = self.customView.bounds
        //viewController.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        // Notify Child View Controller
        viewController.didMoveToParentViewController(self)
    }
    
    private func removeViewControllerAsChildViewController(viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMoveToParentViewController(nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }

}
