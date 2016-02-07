//
//  WebViewController.swift
//  NavigationDrawer
//
//  Created by Martin Mitrevski on 2/6/16.
//  Copyright © 2016 Martin Mitrevski. All rights reserved.
//

import UIKit
import MMDrawerController

class WebViewController: UIViewController {
    
    weak var drawerController: MMDrawerController?
    var requestUrl: NSURL?
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let request = NSURLRequest(URL: requestUrl!)
        webView.loadRequest(request)
        addNavigationButton()
    }
    
    func addNavigationButton() {
        let image = UIImage(named: "drawer_icon.png")
        let barButton = UIBarButtonItem(image: image,
            style: UIBarButtonItemStyle.Done,
            target: self,
            action: "navigationButtonClicked")
        
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func navigationButtonClicked() {
        if drawerController?.openSide == MMDrawerSide.Left {
            drawerController?.closeDrawerAnimated(true, completion: nil)
        } else {
            drawerController?.openDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        }
    }

}
