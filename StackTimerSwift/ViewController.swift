//
//  ViewController.swift
//  StackTimerSwift
//
//  Created by Shim Tw on 6/21/14.
//  Copyright (c) 2014 Tw Shim. All rights reserved.
//

import Cocoa
import CoreData

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    var tasks : NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }

    @IBOutlet var tableView : NSTableView = nil
    @IBOutlet var titleTextField : NSTextField = nil
    
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
                                    
    }

    func numberOfRowsInTableView(aTableView: NSTableView!) -> Int {
        return tasks.count
    }
    
    func tableView(tableView: NSTableView!, objectValueForTableColumn tableColumn: NSTableColumn!, row: Int) -> AnyObject! {
        var task : Task = tasks[row] as Task
        return task.valueForKey(tableColumn.identifier).description as NSString
    }
    
    @IBAction func startTask(sender : AnyObject) {
        if (titleTextField.stringValue != "") {
            let appDelegate : AppDelegate = NSApplication.sharedApplication().delegate as AppDelegate
            let context : NSManagedObjectContext = appDelegate.managedObjectContext!
            let entity = NSEntityDescription.entityForName("Tasks", inManagedObjectContext: context)
            var newTask = Task(entity: entity, insertIntoManagedObjectContext: context)
            newTask.start(titleTextField.stringValue)
            context.save(nil)
            
            println("\(newTask) object saved.")
            reload()
            titleTextField.stringValue = ""
        }
    }
    
    @IBAction func finishTask(sender : AnyObject) {
        let appDelegate : AppDelegate = NSApplication.sharedApplication().delegate as AppDelegate
        let context : NSManagedObjectContext = appDelegate.managedObjectContext!
        var task : Task = tasks[0] as Task
        task.finish()
        println("last \(task) finished")
        context.save(nil)
        reload()
    }
    
    
    func reload() {        // Do any additional setup after loading the view.
        let appDelegate : AppDelegate = NSApplication.sharedApplication().delegate as AppDelegate
        let context : NSManagedObjectContext = appDelegate.managedObjectContext!
        var request = NSFetchRequest(entityName: "Tasks")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "finished = nil")
        let sortDescriptor = NSSortDescriptor(key: "startedAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        tasks = context.executeFetchRequest(request, error: nil)
        tableView.reloadData()
    }
}

