//
//  TabBarController.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 02/12/2020.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Properties
    
    private let vc1 = UINavigationController(rootViewController: HomeController())
    private let vc2 = UINavigationController(rootViewController: ToDoListController())
    private let vc3 = UINavigationController(rootViewController: PlannerController())
    private let vc4 = UINavigationController(rootViewController: NotesController())
    private let vc5 = UINavigationController(rootViewController: PlacesController())
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    // MARK: - Helper functions
    
    func configureTabBar() {
        
        tabBar.barTintColor = UIColor.clear

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
        
        guard let items = self.tabBar.items else { return }
        
        let images = [Constant.homeIconCircle, Constant.toDoListIconCircle, Constant.plannerIconCircle, Constant.notesIconCircle, Constant.placesIconCircle]
        
        let imagesSelected = [Constant.homeIconSelected, Constant.toDoListIconSelected, Constant.plannerIconSelected, Constant.notesIconSelected, Constant.placesIconSelected]
        
        for x in 0..<items.count {
            items[x].image = UIImage(named: images[x])!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            items[x].selectedImage = UIImage(named: imagesSelected[x])!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            items[x].title = nil
        }
    }
}
