//
//  ViewController.swift
//  SteamPoweredApp
//
//  Created by Kory E King on 11/2/16.
//  Copyright © 2016 Kory E King. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, XMLParserDelegate {
    
    var xmlParser: XMLParser!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let mUrl = NSURL(string: "http://store.steampowered.com/feeds/news.xml")
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingFromURL(mUrl!)
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return xmlParser.arrParsedData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let mDictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        cell.textLabel?.text = mDictionary["title"]
        return cell;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80;
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        let title = dictionary["title"]
        let detailLink = dictionary["link"]
        let pubDate = dictionary["pubDate"]
        
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idDetailVC") as! DetailViewController
        
        detailVC.detailLink = NSURL(string: detailLink!)
        detailVC.pubDate = pubDate
        detailVC.dTitle = title
        
        showDetailViewController(detailVC, sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func parsingWasFinished() {
        self.tableView.reloadData()
    }
    


}

