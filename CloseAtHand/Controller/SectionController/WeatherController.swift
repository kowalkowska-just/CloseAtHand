//
//  WeatherController.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 02/12/2020.
//

import UIKit

class WeatherController: UIViewController {
    
//MARK: - Properties
    
    private let locationContainerView = CurrentLocationView()
    private let temperatureContainerView = CurrentTemperatureView()
    
//MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

//MARK: - Helper functions
    
    private func configureUI() {
        configureNavBar()
        view.backgroundColor = UIColor.init(named: Constant.backgroundColor)
        
        view.addSubview(locationContainerView)
        locationContainerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                 paddingTop: 15, paddingLeft: 15, paddingRight: 15)
        
        view.addSubview(temperatureContainerView)
        temperatureContainerView.anchor(top: locationContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                    paddingTop: 5, paddingLeft: 15, paddingRight: 15)
    }
    
    private func configureNavBar() {
        configureNavigationBar(withTitle: "Weather", withColor: UIColor.init(named: Constant.backgroundColor)!)
        
        if let navigationBar = self.navigationController?.navigationBar {
            
            let menuFrame = CGRect(x: navigationBar.frame.width - navigationBar.frame.height,
                                   y: 20, width: navigationBar.frame.height - 22,
                                   height: navigationBar.frame.height - 22)
            let plusFrame = CGRect(x: navigationBar.frame.width - (2 * navigationBar.frame.height) - 10,
                                   y: 20, width: navigationBar.frame.height - 19,
                                   height: navigationBar.frame.height - 19)
            let backFrame = CGRect(x: 20,
                                   y: 20, width: navigationBar.frame.height - 22,
                                   height: navigationBar.frame.height - 22)
            
            let menuButton = UIButton.init(frame: menuFrame)
            menuButton.setImage(UIImage(named: Constant.menuIcon)?.withRenderingMode(.alwaysTemplate), for: .normal)
            menuButton.tintColor = UIColor.init(named: Constant.textColor)!

            let plusButton = UIButton.init(frame: plusFrame)
            plusButton.setImage(UIImage(named: Constant.plusIcon)?.withRenderingMode(.alwaysTemplate), for: .normal)
            plusButton.tintColor = UIColor.init(named: Constant.textColor)!
            
            let backButton = UIButton.init(frame: backFrame)
            backButton.setImage(UIImage(named: Constant.backIcon)?.withRenderingMode(.alwaysTemplate), for: .normal)
            backButton.tintColor = UIColor.init(named: Constant.textColor)!
            backButton.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
            
            navigationBar.addSubview(menuButton)
            navigationBar.addSubview(plusButton)
            navigationBar.addSubview(backButton)
        }
    }

//MARK: - Selectors

    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
}
