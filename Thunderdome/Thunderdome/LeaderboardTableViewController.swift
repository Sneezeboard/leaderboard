//
//  LeaderboardTableViewController.swift
//  Thunderdome
//
//  Created by Will Dalton on 10/7/15.
//  Copyright © 2015 patrick. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {

    var leagues: [League] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLeagues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func loadLeagues() {
        // instantiate a fake global league
        let globalLeague = League()
        globalLeague.name = League.globalLeagueName()  // this name is negotiable
        
        ParseClient.sharedInstance.allLeagues { (leagues, error) -> () in
            self.leagues = [globalLeague]
            for league in leagues {
                self.leagues.append(league)
            }
            self.tableView.reloadData()
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LeagueTableViewCell", forIndexPath: indexPath) as! LeagueTableViewCell
        cell.league = leagues[indexPath.row]

        return cell
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
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! LeagueDetailTableViewController
        let cell = sender as! LeagueTableViewCell
        vc.league = cell.league
    }

}
