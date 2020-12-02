//
//  TabBarController.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 02/12/2020.
//

import UIKit

class TabBarController: UITabBarController {

    let vc1 = HomeController()
    let vc2 = ToDoListController()
    let vc3 = PlannerController()
    let vc4 = NotesController()
    let vc5 = PlacesController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    func configureTabBar() {
        
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
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
