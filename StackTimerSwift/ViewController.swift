//
//  ViewController.swift
//  StackTimerSwift
//
//  Created by Shim Tw on 6/21/14.
//  Copyright (c) 2014 Tw Shim. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var tasks = [["Title": "Debasis", "Status": "Doing"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                                    
    }

    @IBOutlet var tableView : NSTableView = nil
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
                                    
    }

    func numberOfRowsInTableView(aTableView: NSTableView!) -> Int {
        return tasks.count
    }
    
    func tableView(tableView: NSTableView!, objectValueForTableColumn tableColumn: NSTableColumn!, row: Int) -> AnyObject! {
        return tasks[row][tableColumn.identifier]
    }
    
    @IBAction func createTask(sender : AnyObject) {
        tasks += ["Title": "Debasis", "Status": "Doing"]
        tableView.reloadData()
    }
}

