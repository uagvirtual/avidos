//
//  RouteDetailTableViewController.swift
//  PuntoJalisco
//
//  Created by Felix Olivares on 10/1/16.
//  Copyright © 2016 Felix. All rights reserved.
//

import UIKit
import ExpandableTableViewController

enum TableViewRows: Int {
    case Text = 0, DatePicker, List
}

class RouteDetailTableViewController: ExpandableTableViewController, ExpandableTableViewDelegate {

    
    @IBOutlet var expandableTB: ExpandableTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.expandableTableView.expandableDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func expandableTableView(expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func expandableTableView(expandableTableView: ExpandableTableView, cellForRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch(expandableIndexPath.row){
        case TableViewRows.Text.rawValue:
            cell = expandableTableView.dequeueReusableCellWithIdentifier("PJRouteDetailTableViewCell", forIndexPath: expandableIndexPath) as! PJRouteDetailTableViewCell
        case TableViewRows.DatePicker.rawValue:
            cell = expandableTableView.dequeueReusableCellWithIdentifier("PJRouteDetailTableViewCell", forIndexPath: expandableIndexPath) as! PJRouteDetailTableViewCell
        case TableViewRows.List.rawValue:
            cell = expandableTableView.dequeueReusableCellWithIdentifier("PJRouteDetailTableViewCell", forIndexPath: expandableIndexPath) as! PJRouteDetailTableViewCell
        default:
            cell = UITableViewCell()
        }
        
        return cell
    }
    
    func expandableTableView(expandableTableView: ExpandableTableView, heightForRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> CGFloat {
        return 60.0
    }
    
    func expandableTableView(expandableTableView: ExpandableTableView, estimatedHeightForRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> CGFloat {
        return 60.0
    }
    
    func expandableTableView(expandableTableView: ExpandableTableView, didSelectRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) {
        switch(expandableIndexPath.row){
        case TableViewRows.Text.rawValue:
            break
        case TableViewRows.DatePicker.rawValue:
            break
        case TableViewRows.List.rawValue:
            break
        default:
            break
        }
        
        expandableTableView.deselectRowAtExpandableIndexPath(expandableIndexPath, animated: true)
    }
    
    // MARK: - SubRows
    func expandableTableView(expandableTableView: ExpandableTableView, numberOfSubRowsInRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> Int {
        switch(expandableIndexPath.row){
        case TableViewRows.Text.rawValue, TableViewRows.DatePicker.rawValue:
            return 1
        case TableViewRows.List.rawValue:
            return 3
        default:
            return 0
        }
    }
    
    func expandableTableView(expandableTableView: ExpandableTableView, subCellForRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch(expandableIndexPath.row){
        case TableViewRows.Text.rawValue:
            let descriptionCell = expandableTableView.dequeueReusableCellWithIdentifier("PJRouteDetailTableViewCell", forIndexPath: expandableIndexPath) as! PJRouteDetailTableViewCell
            cell = descriptionCell
        case TableViewRows.DatePicker.rawValue:
            cell = expandableTableView.dequeueReusableCellWithIdentifier("PJRouteDetailTableViewCell", forIndexPath: expandableIndexPath) as! PJRouteDetailTableViewCell
        case TableViewRows.List.rawValue:
            let listTextCell = expandableTableView.dequeueReusableCellWithIdentifier("PJRouteDetailTableViewCell", forIndexPath: expandableIndexPath) as! PJRouteDetailTableViewCell
            cell = listTextCell
        default:
            cell = UITableViewCell()
        }
        
        return cell
    }
    
    func expandableTableView(expandableTableView: ExpandableTableView, didSelectSubRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath){
        
    }
    
    func expandableTableView(expandableTableView: ExpandableTableView, heightForSubRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> CGFloat {
        switch(expandableIndexPath.row){
        case TableViewRows.Text.rawValue:
            return UITableViewAutomaticDimension
        case TableViewRows.DatePicker.rawValue:
            return 163.0
        case TableViewRows.List.rawValue:
            return 44.0
        default:
            return 0
        }
    }
    
    func expandableTableView(expandableTableView: ExpandableTableView, estimatedHeightForSubRowAtExpandableIndexPath expandableIndexPath: ExpandableIndexPath) -> CGFloat {
        switch(expandableIndexPath.row){
        case TableViewRows.Text.rawValue:
            return 100.0
        case TableViewRows.DatePicker.rawValue:
            return 163.0
        case TableViewRows.List.rawValue:
            return 44.0
        default:
            return 0
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
