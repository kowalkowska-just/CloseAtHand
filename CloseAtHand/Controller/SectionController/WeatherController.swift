//
//  WeatherController.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 02/12/2020.
//

import UIKit

class WeatherController: UIViewController {
    
//MARK: - Properties
    
    private let placeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constant.placeIcon)
        image.tintColor = UIColor(named: Constant.textColor)
        image.contentMode = .scaleAspectFit
        image.image = image.image?.withRenderingMode(.alwaysTemplate)

        return image
    }()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Gdansk"
        label.font = UIFont.systemFont(ofSize: 20)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()
        
    private let dateLabel:  UILabel = {
        let label = UILabel()
        label.text = "Web, December 9"
        label.font = UIFont.systemFont(ofSize: 12)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "20:36"
        label.font = UIFont.systemFont(ofSize: 12)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()
    
    private lazy var cityNameContainer: UIView = {
        let cityNameView = UIView()
        cityNameView.layer.cornerRadius = 5
        cityNameView.backgroundColor = UIColor(named: Constant.secendaryBackgroundColor)
        cityNameView.addShadow()
        
        cityNameView.addSubview(placeImage)
        placeImage.anchor(top: cityNameView.topAnchor, left: cityNameView.leftAnchor,
                          paddingTop: 15, paddingLeft: 15)
        placeImage.dimensions(width: 15, height: 15)
        
        cityNameView.addSubview(cityNameLabel)
        cityNameLabel.centerY(inView: placeImage)
        cityNameLabel.anchor(left: placeImage.rightAnchor, right: cityNameView.rightAnchor,
                         paddingLeft: 3, paddingRight: 15)
        
        cityNameView.addSubview(dateLabel)
        dateLabel.anchor(top: cityNameLabel.bottomAnchor, left: cityNameLabel.leftAnchor, paddingTop: 3)
        
        cityNameView.addSubview(timeLabel)
        timeLabel.anchor(top: dateLabel.bottomAnchor, left: cityNameLabel.leftAnchor, paddingTop: 2)
        
        return cityNameView
    }()
    
//MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

//MARK: - Helper functions
    
    private func configureUI() {
        configureNavBar()
        view.backgroundColor = UIColor.init(named: Constant.backgroundColor)
        
        view.addSubview(cityNameContainer)
        cityNameContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15)
        cityNameContainer.dimensions(height: 79)
        
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
