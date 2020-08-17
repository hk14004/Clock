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
        let timer = TimerViewController()
        timer.tabBarItem = {
            let item = UITabBarItem()
            item.title = "Timer"
            item.image = UIImage(systemName: "timer")
            return item
        }()
        
        let stopwatch = StopwatchViewController()
        stopwatch.tabBarItem = {
            let item = UITabBarItem()
            item.title = "Stopwatch"
            item.image = UIImage(systemName: "stopwatch.fill")
            return item
        }()
        
        let bedtimeVC = BedtimeViewController()
        bedtimeVC.tabBarItem = {
            let item = UITabBarItem()
            item.title = "Bedtime"
            item.image = UIImage(systemName: "bed.double.fill")
            return item
        }()
        
        let alarmVC = AlarmViewController()
        alarmVC.tabBarItem = {
            let item = UITabBarItem()
            item.title = "Alarm"
            item.image = UIImage(systemName: "alarm.fill")
            return item
        }()
        
        let worldClockVC = WorldClockViewController()
        worldClockVC.tabBarItem = {
            let item = UITabBarItem()
            item.title = "World Clock"
            item.image = UIImage(systemName: "globe")
            return item
        }()
        
        viewControllers = [worldClockVC, alarmVC, bedtimeVC, stopwatch, timer]
        
        selectedViewController = timer
    }
}
