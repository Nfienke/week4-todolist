//
//  ViewController.swift
//  4todolist
//
//  Created by Nienke Pot on 17-11-15.
//  Copyright © 2015 Nienke Pot. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //var
    var todolist:[String] = []
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var tekstfield: UITextField!
    
    func list(){
        todolist.append(tekstfield.text!)
        tekstfield.text = ""
        table.beginUpdates()
        table.insertRowsAtIndexPaths([NSIndexPath(forRow: todolist.count-1, inSection: 0)], withRowAnimation: .Automatic)
        table.endUpdates()
    }
    
    @IBAction func addbutton(sender: AnyObject) {
        list()
        NSUserDefaults.standardUserDefaults().setObject(todolist, forKey: "key")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        list()
        //print
        if NSUserDefaults.standardUserDefaults().objectForKey("key") != nil{
        todolist = NSUserDefaults.standardUserDefaults().objectForKey("key") as! [String]
       }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todolist.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.table.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell.textLabel?.text = self.todolist[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         print("You selected cell #\(indexPath.row)!")
    }
    
    //remove with a swipe.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            todolist.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(todolist, forKey: "key")
            table.reloadData()
        }
    }
}

