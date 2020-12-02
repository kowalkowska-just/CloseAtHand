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
        view.addGradientWithColors(.lightGray, .darkGray, direction: .topLeftCornerToBottomRightCorner)
        
        view.addSubview(weatherWidget)
        weatherWidget.dimensions(width: (view.bounds.size.width / 2) - 30 , height: 170)
        weatherWidget.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingLeft: 20)
        
    }
    
    //MARK: - Selectors

}
