//
//  PJRouteDetailTableViewCell.swift
//  PuntoJalisco
//
//  Created by Felix Olivares on 9/30/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit

protocol ViewMapButtonDelegate{
    func goToViewMap()
}

class PJRouteDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var firstTripLabel: UILabel!
    @IBOutlet weak var lastTripLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var route:PJRouteObject!
    var delegate:ViewMapButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func goToMapPressed(_ sender: AnyObject) {
        print("go to map pressed")
        PJRouteManager.sharedInstance.setRoute(route)
        delegate?.goToViewMap()
    }
    
}
