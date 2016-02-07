//
//  MenuViewController.swift
//  NavigationDrawer
//
//  Created by Martin Mitrevski on 2/6/16.
//  Copyright © 2016 Martin Mitrevski. All rights reserved.
//

import UIKit
import MMDrawerController

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    weak var drawerController: MMDrawerController?
    private var controllers: Array<UINavigationController> = []
    
    let menuItems : Array<MenuItem> =  { () -> Array<MenuItem> in
        let path = NSBundle.mainBundle().pathForResource("menuItems", ofType: "json")!
        let pathUrl = NSURL(fileURLWithPath: path)
        do {
            let jsonData: NSData = try NSData(contentsOfURL: pathUrl, options: NSDataReadingOptions())
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData,
                options: NSJSONReadingOptions.AllowFragments)
            let array: Array<Dictionary<String, String>> =
            json["menuItems"] as! Array<Dictionary<String, String>>
            return array.map({ (dictionary) -> MenuItem in
                return MenuItem(dictionary: dictionary)
            })
        } catch {
            print("error reading menu data")
            return Array<MenuItem>()
        }
    }()
    
    func viewControllers() -> Array<UINavigationController> {
        if !controllers.isEmpty {
            return controllers
        } else {
            controllers = menuItems.map({ (menuItem) -> UINavigationController in
                let webViewController = WebViewController(nibName: "WebViewController",
                bundle: NSBundle.mainBundle());
                webViewController.requestUrl = menuItem.remoteUrl
                webViewController.drawerController = self.drawerController
                return UINavigationController(rootViewController: webViewController)
            })
            return controllers
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // table view
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MenuCell")
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MenuCell")
        }
        
        let menuItem = menuItems[indexPath.row]
        cell?.textLabel?.text = menuItem.title
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let nextNavigation = viewControllers()[indexPath.row]
        let nextWebVC = nextNavigation.topViewController as! WebViewController
        nextWebVC.drawerController = self.drawerController
        drawerController?.setCenterViewController(viewControllers()[indexPath.row],
            withCloseAnimation: true, completion: nil)
    }
    
}
