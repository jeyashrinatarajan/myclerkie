//
//  HomeViewController.swift
//  My Clerkie
//
//  Created by Jeyashri Natarajan on 11/19/17.
//  Copyright © 2017 Clerkie. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var tabBarView: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var tabs: [UIButton]!
    @IBOutlet var chatTab: UIButton!
    @IBOutlet var chartTab: UIButton!
    @IBOutlet var settingsTab: UIButton!
    
    var chatViewController: UIViewController!
    var chartViewController: UIViewController!
    var settingsViewController: UIViewController!
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Tab bar view appearance
        self.tabBarView.layer.borderWidth = 1
        self.tabBarView.layer.borderColor = UIColor(red:3/255.0, green:188/255.0, blue:229/255.0, alpha:1.0).cgColor
        self.tabBarView.layer.cornerRadius = 4
        self.chatTab.setImage(UIImage(named:"chat_selected"), for: .selected)
        self.chartTab.setImage(UIImage(named:"chart_selected"), for: .selected)
        self.settingsTab.setImage(UIImage(named:"settings_selected"), for: .selected)
        
        //Instantiate the view controllers
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        chatViewController = storyboard.instantiateViewController(withIdentifier: "Chat")
        chartViewController = storyboard.instantiateViewController(withIdentifier: "Chart")
        settingsViewController = storyboard.instantiateViewController(withIdentifier: "Settings")
        viewControllers = [chatViewController, chartViewController, settingsViewController]
        
        tabs[selectedIndex].isSelected = true
        didPressTab(tabs[selectedIndex])
    }
    
    @IBAction func didPressTab(_ sender: UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        tabs[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        sender.isSelected = true
        let vc = viewControllers[selectedIndex]
        addChildViewController(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        
    }
    

}
