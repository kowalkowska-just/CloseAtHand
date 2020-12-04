//
//  TabBarController.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 02/12/2020.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Properties
    
    let vc1 = UINavigationController(rootViewController: HomeController())
    let vc2 = UINavigationController(rootViewController: ToDoListController())
    let vc3 = UINavigationController(rootViewController: PlannerController())
    let vc4 = UINavigationController(rootViewController: NotesController())
    let vc5 = UINavigationController(rootViewController: PlacesController())
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    // MARK: - Helper functions
    
    func configureTabBar() {
        
        tabBar.barTintColor = UIColor.clear
//        UITabBar.appearance().tintColor = UIColor.selectedColorInTabBar
//        UITabBar.appearance().unselectedItemTintColor = UIColor.navigationButtonColor


        if #available(iOS 13.0, *) {
            // ios 13.0 and above
            let appearance = tabBar.standardAppearance
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            appearance.backgroundEffect = nil
            appearance.backgroundColor = .clear
            tabBar.standardAppearance = appearance
        } else {
            // below ios 13.0
            let image = UIImage()
            tabBar.shadowImage = image
            tabBar.backgroundImage = image
            tabBar.backgroundColor = .clear
        }
        
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
        tabBar.barStyle = .black
        modalPresentationStyle = .fullScreen
        
        vc1.title = "Home"
        vc2.title = "To Do List"
        vc3.title = "Planner"
        vc4.title = "Notes"
        vc5.title = "Places"
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["house", "checkmark.square", "calendar", "square.and.pencil", "pin"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
    }
    
}
