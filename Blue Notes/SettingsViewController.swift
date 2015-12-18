//
//  SettingsViewController
//  Blue Notes
//
//  Created by Arnaud Ferreri on 11/24/15.
//  Copyright © 2015 Arnaud Ferreri. All rights reserved.
//

import UIKit
import SwiftyDropbox

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "Logout"
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        Dropbox.unlinkClient()
        let tab = UIApplication.sharedApplication().keyWindow?.rootViewController as! TabViewController
        tab.startLogin()
    }


}

