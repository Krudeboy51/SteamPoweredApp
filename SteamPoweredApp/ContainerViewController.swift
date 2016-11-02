//
//  ContainerViewController.swift
//  SteamPoweredApp
//
//  Created by Kory E King on 11/2/16.
//  Copyright © 2016 Kory E King. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var mVC : UISplitViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setEmbeddedVC(mSVC: UISplitViewController!){
        if mSVC != nil{
            mVC = mSVC
            
            self.addChildViewController(mVC)
            self.view.addSubview(mVC.view)
            mVC.didMoveToParentViewController(self)
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if size.width > size.height{
            self.setOverrideTraitCollection(UITraitCollection(horizontalSizeClass: UIUserInterfaceSizeClass.Regular), forChildViewController: mVC)
        }else{
            self.setOverrideTraitCollection(nil, forChildViewController: mVC)
        }
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
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
