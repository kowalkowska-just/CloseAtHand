//
//  HomeController.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 26/11/2020.
//

import UIKit
import Firebase

class HomeController: UIViewController {

    //MARK: - Properties
    
    let weatherWidget = WeatherWidget()
    let calendarWidget = CalendarWidget()
    let toDoListWidget = ToDoListWidget()
    let plannerWidget = PlannerWidget()
    let placesWidget = PlacesWidget()
    let notesWidget = NotesWidget()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        signOut()
        configureUI()
        checkIfUserIsLoggedIn()
    }
    
    //MARK: - API
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser?.uid == nil {
            print("DEBUG: User not logged in..")
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            print("DEBUG: User is logged in..")
        }
    }
    
    func signOut() {
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Error signing out..")
        }
    }
    
    //MARK: - Helper functions
    
    func configureUI() {
        let tabBarHeight = tabBarController?.tabBar.frame.size.height ?? 0
        let statusBarHeight = navigationController?.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let heightView = view.bounds.size.height - tabBarHeight - statusBarHeight - navigationBarHeight
        
        configureNavBar()
        
        view.backgroundColor = UIColor.init(named: Constatnt.backgroundColor)

        view.addSubview(weatherWidget)
        weatherWidget.dimensions(width: (view.bounds.size.width - 45) / 2,
                                 height: (heightView - 60) / 3)
        weatherWidget.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                             paddingTop: 15, paddingLeft: 15)
        weatherWidget.layer.cornerRadius = 4.5
//        weatherWidget.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 20)
        
        view.addSubview(calendarWidget)
        calendarWidget.dimensions(width: (view.bounds.size.width - 45) / 2,
                                  height: (heightView - 60) / 3)
        calendarWidget.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: weatherWidget.rightAnchor,
                              paddingTop: 15, paddingLeft: 15)
        calendarWidget.layer.cornerRadius = 4.5
//        calendarWidget.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 20)

        view.addSubview(toDoListWidget)
        toDoListWidget.dimensions(width: (view.bounds.size.width - 45) / 2,
                                  height: (heightView - 60) / 3)
        toDoListWidget.anchor(top: weatherWidget.bottomAnchor, left: view.leftAnchor,
                              paddingTop: 15, paddingLeft: 15)
        toDoListWidget.layer.cornerRadius = 4.5
//        toDoListWidget.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 20)

        view.addSubview(plannerWidget)
        plannerWidget.dimensions(width: (view.bounds.size.width - 45) / 2,
                                 height: (heightView - 60) / 3)
        plannerWidget.anchor(top: calendarWidget.bottomAnchor, left: toDoListWidget.rightAnchor,
                             paddingTop: 15, paddingLeft: 15)
        plannerWidget.layer.cornerRadius = 4.5
//        plannerWidget.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 20)

        view.addSubview(notesWidget)
        notesWidget.dimensions(width: (view.bounds.size.width - 45) / 2,
                                height: (heightView - 60) / 3)
        notesWidget.anchor(top: toDoListWidget.bottomAnchor, left: view.leftAnchor,
                            paddingTop: 15, paddingLeft: 15)
        notesWidget.layer.cornerRadius = 4.5
//        notesWidget.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 20)

        view.addSubview(placesWidget)
        placesWidget.dimensions(width: (view.bounds.size.width - 45) / 2,
                               height: (heightView - 60) / 3)
        placesWidget.anchor(top: plannerWidget.bottomAnchor, left: notesWidget.rightAnchor,
                           paddingTop: 15, paddingLeft: 15)
        placesWidget.layer.cornerRadius = 4.5
//        placesWidget.roundCorners([.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 20)
    }
    
    func configureNavBar() {
        configureNavigationBar(withTitle: "Home", withColor: UIColor.init(named: Constatnt.backgroundColor)!)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill"), style: .plain, target: self, action: #selector(handlePersonController))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.init(named: Constatnt.textColor)
        
    }
    
    //MARK: - Selectors

    @objc func handlePersonController() {
        
    }
}
