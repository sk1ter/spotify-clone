//
//  TabBarViewController.swift
//  Spotify
//
//  Created by Javlonbek Sharipov on 20/03/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeViewController = HomeViewController()
        let searchViewController = SearchViewController()
        let libraryViewController = LibraryViewController()
        
        homeViewController.title = "Browse"
        homeViewController.navigationItem.largeTitleDisplayMode = .always
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        searchViewController.title = "Search"
        searchViewController.navigationItem.largeTitleDisplayMode = .always
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        libraryViewController.title = "Library"
        libraryViewController.navigationItem.largeTitleDisplayMode = .always
        libraryViewController.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 0)
        
        let homeNavigation = UINavigationController(rootViewController: homeViewController)
        let searchNavigation = UINavigationController(rootViewController: searchViewController)
        let libraryNavigation = UINavigationController(rootViewController: libraryViewController)
        
        homeNavigation.navigationBar.prefersLargeTitles = true
        searchNavigation.navigationBar.prefersLargeTitles = true
        libraryNavigation.navigationBar.prefersLargeTitles = true
        
        setViewControllers([homeNavigation, searchNavigation, libraryNavigation], animated: true)
    }
}
