//
//  BrowseFolderController.swift
//  Blue Notes
//
//  Created by Arnaud Ferreri on 11/24/15.
//  Copyright © 2015 Arnaud Ferreri. All rights reserved.
//

import UIKit
import SwiftyDropbox

class BrowseFolderController: UITableViewController {
    internal var files : [Files.Metadata] = []
    internal var path : String = ""
    internal var sortType : String = "alpha"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.title ?? "All Files"
    }

    override func viewWillAppear(animated: Bool) {
        listFiles(self.path)
    }
    
    func listFiles(path: String) {
        if let client = Dropbox.authorizedClient {
            client.files.listFolder(path: path).response { response, error in
                if let result = response {
                    self.files = []
                    for entry in result.entries {
                        self.files.append(entry)
                        if entry.name.hasSuffix(".md") {
                            self.sortType = "date"
                        }
                    }
                    self.sortFiles()
                    self.tableView.reloadData()
                } else {
                    print("Error: \(error!)")
                }
            }
        }
    }
    
    func sortFiles() {
        if self.sortType == "alpha" {
            self.files = self.files.sort { $0.name.lowercaseString < $1.name.lowercaseString }
        } else {
            self.files = self.files.sort {
                ($0 as! Files.FileMetadata).clientModified.timeIntervalSince1970 > ($1 as! Files.FileMetadata).clientModified.timeIntervalSince1970
            }
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let entry = self.files[indexPath.row]
        cell.textLabel!.text = entry.name
        if (entry is Files.FolderMetadata) {
            cell.imageView!.image = UIImage(named: "folder.png")
        } else {
            cell.imageView!.image = UIImage(named: "document.png")
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.files.count;
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let entry = self.files[indexPath.row]
        if entry is Files.FolderMetadata {
            openFolder("\(self.path)/\(entry.name)", title: entry.name)
        } else {
            openFile("\(self.path)/\(entry.name)", title: entry.name)
        }
    }
    
    func openFolder(path: String, title: String) {
        let vc = BrowseFolderController()
        vc.path = path
        vc.title = title
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openFile(path: String, title: String) {
        let vc = NoteEditViewController()
        vc.path = path
        vc.title = title
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

