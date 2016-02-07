//
//  MenuItem.swift
//  NavigationDrawer
//
//  Created by Martin Mitrevski on 2/6/16.
//  Copyright © 2016 Martin Mitrevski. All rights reserved.
//

import Foundation

let titleConstant = "title"
let remoteUrlConstant = "remoteUrl"

struct MenuItem {
    let title: String
    let remoteUrl: NSURL
    
    init(dictionary: Dictionary<String, String>) {
        title = dictionary[titleConstant]!
        remoteUrl = NSURL(string: dictionary[remoteUrlConstant]!)!
    }
}