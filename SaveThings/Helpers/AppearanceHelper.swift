//
//  AppearanceHelper.swift
//  SaveThings
//
//  Created by Dongwoo Pae on 1/6/20.
//  Copyright © 2020 Dongwoo Pae. All rights reserved.
//

import UIKit

enum AppearanceHelper {
    
    static var mainColorDarkBlue = #colorLiteral(red: 0.0995137468, green: 0.263354212, blue: 0.4718250036, alpha: 1)
    // set up appearance based on userDefaults being saved after choosing bright mode in setting
    static func setDefaultAppearance() {
        
        //NavigationBar title color
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
        
        
        //Navigation button color
        UINavigationBar.appearance().tintColor = .systemTeal
        
        //UISearchBar
        UISearchBar.appearance().tintColor = .systemTeal
        
        //TabBar
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = .systemTeal
    }
    
    static func setWhiteAppearance() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: mainColorDarkBlue]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
        
        UINavigationBar.appearance().barTintColor = .white
        
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.0995137468, green: 0.263354212, blue: 0.4718250036, alpha: 1)
    }
}
