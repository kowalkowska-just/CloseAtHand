//
//  WeatherController.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 02/12/2020.
//

import UIKit

class WeatherController: UIViewController {
    
//MARK: - Properties
    
    private let placeIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constant.placeIcon)
        image.tintColor = UIColor(named: Constant.textColor)
        image.contentMode = .scaleAspectFit
        image.image = image.image?.withRenderingMode(.alwaysTemplate)

        return image
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Gdansk"
        label.font = UIFont.systemFont(ofSize: 20)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()
        
    private let dateLabel:  UILabel = {
        let label = UILabel()
        label.text = "Thursday, December 10"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .right
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "20:36"
        label.font = UIFont.systemFont(ofSize: 11)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()
    
    private lazy var locationContainer: UIView = {
        let locationView = UIView()
        locationView.layer.cornerRadius = 5
        locationView.backgroundColor = UIColor(named: Constant.secendaryBackgroundColor)
        locationView.addShadow()
        
        locationView.addSubview(dateLabel)
        dateLabel.anchor(top: locationView.topAnchor, right: locationView.rightAnchor,
                         paddingTop: 15, paddingRight: 15)
        dateLabel.dimensions(width: 150)
        
        locationView.addSubview(timeLabel)
        timeLabel.anchor(top: dateLabel.bottomAnchor, bottom: locationView.bottomAnchor, right: locationView.rightAnchor,
                         paddingTop: 1, paddingBottom: 15, paddingRight: 15)
        
        locationView.addSubview(placeIcon)
        placeIcon.centerY(inView: locationView)
        placeIcon.anchor(left: locationView.leftAnchor, paddingLeft: 15)
        placeIcon.dimensions(width: 15, height: 15)
        
        locationView.addSubview(locationLabel)
        locationLabel.centerY(inView: locationView)
        locationLabel.anchor(left: placeIcon.rightAnchor, right: dateLabel.leftAnchor,
                             paddingLeft: 5, paddingRight: 3)
        
        return locationView
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "19°"
        label.textColor = UIColor.init(named: Constant.textColor)
        label.font = UIFont.systemFont(ofSize: 35)

        return label
    }()
    
    private var weatherImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constant.fewClouds)
        image.tintColor = UIColor.init(named: Constant.textColor)
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Few clouds"
        label.font = UIFont.systemFont(ofSize: 13)
        label.tintColor = UIColor(named: Constant.textColor)
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        
        return label
    }()
    
    private let minTemp: UILabel = {
        let label = UILabel()
        label.text = "22°"
        label.font = UIFont.systemFont(ofSize: 11)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()
    
    private let maxTemp: UILabel = {
        let label = UILabel()
        label.text = "23°"
        label.font = UIFont.systemFont(ofSize: 11)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()
    
    private var feelsTemp = 23
    
    private lazy var feelsTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Feels like \(feelsTemp)°"
        label.font = UIFont.systemFont(ofSize: 11)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()
    
    private lazy var temperatureContainer: UIView = {
        let temperatureView = UIView()
        temperatureView.layer.cornerRadius = 5
        temperatureView.backgroundColor = UIColor(named: Constant.secendaryBackgroundColor)
        temperatureView.addShadow()
        
        temperatureView.addSubview(weatherImage)
        weatherImage.anchor(top: temperatureView.topAnchor, left: temperatureView.leftAnchor, bottom: temperatureView.bottomAnchor,
                            paddingTop: 15, paddingLeft: 15, paddingBottom: 15)
        
        temperatureView.addSubview(temperatureLabel)
        temperatureLabel.centerY(inView: weatherImage)
        temperatureLabel.anchor(left: weatherImage.rightAnchor, paddingLeft: 5)
        
        temperatureView.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: temperatureView.topAnchor, right: temperatureView.rightAnchor,
                                paddingTop: 10, paddingRight: 15)
        
        temperatureView.addSubview(feelsTempLabel)
        feelsTempLabel.anchor(top: descriptionLabel.bottomAnchor, right: temperatureView.rightAnchor,
                              paddingTop: 5, paddingRight: 15)
        
        temperatureView.addSubview(minTemp)
        minTemp.anchor(top: feelsTempLabel.bottomAnchor, bottom: temperatureView.bottomAnchor, right: temperatureView.rightAnchor,
                       paddingTop: 5, paddingBottom: 15, paddingRight: 15)
        
        let imageMinTemp = UIImageView()
        imageMinTemp.image = UIImage(named: Constant.minTemp)
        imageMinTemp.image = imageMinTemp.image?.withRenderingMode(.alwaysTemplate)
        imageMinTemp.tintColor = UIColor.init(named: Constant.textColor)
        imageMinTemp.contentMode = .scaleAspectFill
        imageMinTemp.dimensions(width: 10, height: 10)
        
        temperatureView.addSubview(imageMinTemp)
        imageMinTemp.centerY(inView: minTemp)
        imageMinTemp.anchor(right: minTemp.leftAnchor, paddingRight: 2)
        
        temperatureView.addSubview(maxTemp)
        maxTemp.anchor(right: imageMinTemp.leftAnchor, paddingRight: 5)
        maxTemp.centerY(inView: minTemp)
        
        let imageMaxTemp = UIImageView()
        imageMaxTemp.image = UIImage(named: Constant.maxTemp)
        imageMaxTemp.image = imageMaxTemp.image?.withRenderingMode(.alwaysTemplate)
        imageMaxTemp.tintColor = UIColor.init(named: Constant.textColor)
        imageMaxTemp.contentMode = .scaleAspectFill
        imageMaxTemp.dimensions(width: 10, height: 10)
        
        temperatureView.addSubview(imageMaxTemp)
        imageMaxTemp.centerY(inView: minTemp)
        imageMaxTemp.anchor(right: maxTemp.leftAnchor, paddingRight: 2)
        
        return temperatureView
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
        
        view.addSubview(locationContainer)
        locationContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                 paddingTop: 15, paddingLeft: 15, paddingRight: 15)
        
        view.addSubview(temperatureContainer)
        temperatureContainer.anchor(top: locationContainer.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
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
