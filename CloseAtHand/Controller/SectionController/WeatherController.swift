//
//  WeatherController.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 02/12/2020.
//

import UIKit

class WeatherController: UIViewController {
    
//MARK: - Properties
    
    
//MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.backgroundColor = UIColor.init(named: Constant.backgroundColor)
    }

//MARK: - Helper functions
    
    func configureNavBar() {
        configureNavigationBar(withTitle: "Weather", withColor: UIColor.init(named: Constant.backgroundColor)!)
        
        if let navigationBar = self.navigationController?.navigationBar {
            
            let menuFrame = CGRect(x: navigationBar.frame.width - navigationBar.frame.height, y: 20, width: navigationBar.frame.height - 20, height: navigationBar.frame.height - 20)
            
            let plusFrame = CGRect(x: navigationBar.frame.width - (2 * navigationBar.frame.height) + 10, y: 20, width: navigationBar.frame.height - 20, height: navigationBar.frame.height - 20)
            
            let menuButton = UIButton.init(frame: menuFrame)
            menuButton.setImage(UIImage(named: Constant.menuIcon)?.withRenderingMode(.alwaysTemplate), for: .normal)
            menuButton.tintColor = UIColor.init(named: Constant.textColor)!
            
            let plusButton = UIButton.init(frame: plusFrame)
            plusButton.setImage(UIImage(named: Constant.plusIcon)?.withRenderingMode(.alwaysTemplate), for: .normal)
            plusButton.tintColor = UIColor.init(named: Constant.textColor)!
            
            navigationBar.addSubview(menuButton)
            navigationBar.addSubview(plusButton)
        }
    }

//MARK: - Selectors

}
