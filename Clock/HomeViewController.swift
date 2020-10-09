//
//  HomeViewController.swift
//  Clock
//
//  Created by Hardijs on 15/08/2020.
//  Copyright © 2020 Hardijs. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setupTabBar()
    }
    
    private func setupTabBar() {
        // Stylize tabbar
        tabBar.barStyle = .black
        tabBar.tintColor = .orange
        
        // Add tab bar items
        let timer = TimerVC()
        timer.tabBarItem = {
            let item = UITabBarItem()
            item.title = NSLocalizedString("Timer", comment: "")
            item.image = UIImage(systemName: "timer")
            return item
        }()
        
        let stopwatch = StopwatchVC()
        stopwatch.tabBarItem = {
            let item = UITabBarItem()
            item.title = NSLocalizedString("Stopwatch", comment: "")
            item.image = UIImage(systemName: "stopwatch.fill")
            return item
        }()
                
        let alarmVC = AlarmVC()
        let alarmNavVC = UINavigationController(rootViewController: alarmVC)
        alarmVC.tabBarItem = {
            let item = UITabBarItem()
            item.title = NSLocalizedString("Alarm", comment: "")
            item.image = UIImage(systemName: "alarm.fill")
            return item
        }()
        
        let worldClockVC = WorldClockVC()
        let worldClockNavVC = UINavigationController(rootViewController: worldClockVC)
        worldClockVC.tabBarItem = {
            let item = UITabBarItem()
            item.title = NSLocalizedString("World Clock", comment: "")
            item.image = UIImage(systemName: "globe")
            return item
        }()
        
        viewControllers = [worldClockNavVC, alarmNavVC, stopwatch, timer]
        
        selectedViewController = alarmNavVC
    }
}
