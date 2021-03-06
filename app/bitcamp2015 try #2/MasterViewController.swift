//
//  MasterViewController.swift
//  bitcamp2015 try #2
//
//  Created by Suraj Rampure on 2015-04-11.
//  Copyright (c) 2015 Suraj Rampure. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = [News]()
    

    var testImage = UIImage(named: "ScreenShot")
    
    //lazy var data = NSMutableData()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        objects.append(News(title: "Hey there!", summary: "What's up?", fulltext: "What is going on man aaaaaa", imageurl: "https://tctechcrunch2011.files.wordpress.com/2015/04/reviews-e1428677213553.jpg?w=738"))
        objects.append(News(title: "Whaddup", summary: "My name is Ioana Crant", fulltext: "ABCDEFGHIJKLMNOPQRSTUVWXYZ", imageurl: "https://tctechcrunch2011.files.wordpress.com/2015/04/6800805548_f3d337452d_o.jpg?w=738"))
        
        //let nibName = UINib(nibName: "NewsCell", bundle:nil)
        //self.tableView.registerNib(nibName, forCellReuseIdentifier: "newsCell")
        
        parseJSON(getJSON("http://localhost:5000/"))

        
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        //objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row]
            (segue.destinationViewController as! DetailViewController).detailItem = object.summary
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("newsCell", forIndexPath: indexPath) as! NewsCell
        let object = objects[indexPath.row]
        
        cell.title.text = object.title
        cell.backgroundImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: object.imageurl)!)!)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData){
        let json = JSON(data: inputData)
        //var json1 = ["news":"hello","a":"b"]
    
        println(json[0][0].string)

    }
    
    
}