//
//  DetailViewController.swift
//  SteamPoweredApp
//
//  Created by Kory E King on 11/2/16.
//  Copyright © 2016 Kory E King. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var mWebView: UIWebView!
    
    @IBOutlet weak var mToolBar: UIToolbar!
    
    @IBOutlet weak var pubDateBI: UIBarButtonItem!
    
    var detailButtonItem : UIBarButtonItem!
    
    var dTitle : String!
    var pubDate : String!
    var detailLink : NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mWebView.hidden = true
        mToolBar.hidden = true
        detailButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DetailViewController.showDetailViewController as (DetailViewController) -> () -> ()))
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DetailViewController.handleFirstViewControllerDisplayModeChangeWithNotification(_:)), name: "PrimaryVCDisplayModeChangeNotification", object: nil)
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if detailLink != nil{
            let request : NSURLRequest = NSURLRequest(URL: detailLink)
            mWebView.loadRequest(request)
            
            if mWebView.hidden{
                mWebView.hidden = false
                mToolBar.hidden = false
            }
            if self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.Compact{
                mToolBar.items?.insert(self.splitViewController!.displayModeButtonItem(), atIndex: 0)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showPubDate(sender: AnyObject) {
        let popoverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idPopover") as? PopoverViewController
        popoverVC?.modalPresentationStyle = UIModalPresentationStyle.Popover
        popoverVC?.popoverPresentationController?.delegate = self
        self.presentViewController(popoverVC!, animated: true, completion: nil)
        popoverVC?.popoverPresentationController?.barButtonItem = pubDateBI
        popoverVC?.popoverPresentationController?.permittedArrowDirections = .Any
        popoverVC?.preferredContentSize = CGSizeMake(200.0, 80.0)
        popoverVC?.mDatePub.text = "Publish Date:\n\(pubDate)"
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func showDetailViewController(){
        splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
    }
    
    
    func handleFirstViewControllerDisplayModeChangeWithNotification(notification: NSNotification){
        let displayModeObject = notification.object as? NSNumber
        let nextDisplayMode = displayModeObject?.integerValue
        
        if mToolBar.items?.count == 3{
            mToolBar.items?.removeAtIndex(0)
        }
        
        if nextDisplayMode == UISplitViewControllerDisplayMode.PrimaryHidden.rawValue {
            mToolBar.items?.insert(detailButtonItem, atIndex: 0)
        }
        else{
            mToolBar.items?.insert(splitViewController!.displayModeButtonItem(), atIndex: 0)
        }
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.verticalSizeClass == UIUserInterfaceSizeClass.Compact{
            let firstItem = mToolBar.items![0] as UIBarButtonItem!
            if firstItem?.title == "Tutorials"{
                mToolBar.items?.removeAtIndex(0)
            }
        }
        else if previousTraitCollection?.verticalSizeClass == UIUserInterfaceSizeClass.Regular{
            if mToolBar.items?.count == 3{
                mToolBar.items?.removeAtIndex(0)
            }
            
            if splitViewController?.displayMode == UISplitViewControllerDisplayMode.PrimaryHidden {
                mToolBar.items?.insert(detailButtonItem, atIndex: 0)
            }
            else{
                mToolBar.items?.insert(self.splitViewController!.displayModeButtonItem(), atIndex: 0)
            }
        }

    }
    
    
 
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
