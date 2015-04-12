//
//  MasterViewController.swift
//  bitcamp2015 try #2
//
//  Created by Suraj Rampure on 2015-04-11.
//  Copyright (c) 2015 Suraj Rampure. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, NSURLConnectionDelegate {

    var objects = [News]()
    
    var testImage = UIImage(named: "ScreenShot")
    
    //lazy var data = NSMutableData()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        objects.append(News(title: "hello", summary: "my name", fulltext: "is ioana", imageurl: "X"))
        objects.append(News(title: "hi", summary: "my name", fulltext: "is ioana", imageurl: "X"))
        
        //let nibName = UINib(nibName: "newsCell", bundle:nil)
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
            (segue.destinationViewController as! DetailViewController).detailItem = object.fulltext
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
        cell.backgroundImage.image = testImage
        
        
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
        println(json.type)
        println(json["news"])
        /*var error: NSError?
        let jsonDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: nil, error: &error) as? NSDictionary
        println(jsonDictionary)
        return jsonDictionary!*/
    }
    
    /*func startConnection(){
        let urlPath: String = "http://localhost:5000/"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }

    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
        
    }
    
    
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var err: NSError
        // throwing an error on the line below (can't figure out where the error message is)
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        println(jsonResult)
    }
    */
    
}