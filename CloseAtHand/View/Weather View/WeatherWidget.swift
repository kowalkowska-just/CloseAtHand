//
//  WeatherWidget.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 01/12/2020.
//

import UIKit

protocol WeatherWidgetDelegate: class {
    func showWeatherController()
}

class WeatherWidget: UIView {

    // MARK: - Properties
    
    weak var delegate: WeatherWidgetDelegate?
    
    private lazy var titleView: UIView = {
        let view = UIView().inputContainerViewForTitle(title: "Weather", imageColor: Constant.weatherColor, image: Constant.weatherIcon)
        return view
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Gdańsk"
        label.textColor = UIColor.init(named: Constant.textColor)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        
        return label
    }()
    
    private let cantryLabel: UILabel = {
        let label = UILabel()
        label.text = "POLAND"
        label.textColor = UIColor.init(named: Constant.textColor)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var locationContainerView: UIView = {
        let view = UIView()
        view.addSubview(cityLabel)
        cityLabel.anchor(top: view.topAnchor, left: view.leftAnchor)
        view.addSubview(cantryLabel)
        cantryLabel.anchor(top: cityLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 1)
        
        return view
    }()
    
    private let weatherButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.init(named: Constant.textColor)
        button.addTarget(self, action: #selector(handleShowWeatherController), for: .touchUpInside)
        return button
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "19°"
        label.textColor = UIColor.init(named: Constant.textColor)
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.font = UIFont.systemFont(ofSize: 120)

        return label
    }()
    
    private var weatherImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constant.clearSky)
        image.tintColor = UIColor.init(named: Constant.textColor)
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private lazy var temperatureContainerView: UIView = {
        let view = UIView()
        let tempView = UIView()
        let imageView = UIView()
        
        tempView.addSubview(temperatureLabel)
        temperatureLabel.anchor(top: tempView.topAnchor, left: tempView.leftAnchor, bottom: tempView.bottomAnchor, right: tempView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5)
        
        imageView.addSubview(weatherImage)
        weatherImage.anchor(top: imageView.topAnchor, left: imageView.leftAnchor, bottom: imageView.bottomAnchor, right: imageView.rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 15, paddingRight: 15)

        let stack = UIStackView(arrangedSubviews: [tempView, imageView])
        stack.spacing = 5
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        return view
    }()
    
    private let rainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.init(named: Constant.wetImage)
        image.tintColor = UIColor.init(named: Constant.textColor)
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private var probabilityOfPrecipitationLabel: UILabel = {
        let label = UILabel()
        label.text = "25%"
        label.textColor = UIColor.init(named: Constant.textColor)
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private let windImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.init(named: Constant.windImage)
        image.tintColor = UIColor.init(named: Constant.textColor)
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.contentMode = .scaleAspectFit

        return image
    }()
    
    private var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "11 km/h"
        label.textColor = UIColor.init(named: Constant.textColor)
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private let celciusButton: UIButton = {
        let button = UIButton()
        button.setTitle("°C", for: .normal)
        button.setTitleColor(UIColor.init(named: Constant.textColor) ?? .white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    private let fahrenheitButton: UIButton = {
        let button = UIButton()
        button.setTitle("°F", for: .normal)
        button.setTitleColor(UIColor.init(named: Constant.textColor) ?? .white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    func configureUI() {
        backgroundColor = UIColor.init(named: Constant.secendaryBackgroundColor)
        addShadow()
        
        addSubview(titleView)
        titleView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
        
        addSubview(locationContainerView)
        locationContainerView.anchor(top: titleView.bottomAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 10)
        locationContainerView.dimensions(height: 40)
        
        addSubview(weatherButton)
        weatherButton.dimensions(width: 45)
        weatherButton.anchor(left: locationContainerView.rightAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: 10)
        weatherButton.centerY(inView: locationContainerView)
        
        let separator1 = UIView().createSeparator(color: UIColor.init(named: Constant.textColor) ?? .white)
        addSubview(separator1)
        separator1.anchor(top: locationContainerView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: 10)
        
        addSubview(temperatureContainerView)
        temperatureContainerView.anchor(top: separator1.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 3, paddingLeft: 10, paddingRight: 10)
        
        let separator2 = UIView().createSeparator(color: UIColor.init(named: Constant.textColor) ?? .white)
        addSubview(separator2)
        separator2.anchor(top: temperatureContainerView.bottomAnchor, left: leftAnchor, right: rightAnchor,paddingTop: 3, paddingLeft: 10, paddingRight: 10)
        
        addSubview(rainImage)
        rainImage.dimensions(width: 22.5, height: 22.5)
        rainImage.anchor(top: separator2.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10)
        
        addSubview(probabilityOfPrecipitationLabel)
        probabilityOfPrecipitationLabel.centerY(inView: rainImage, constant: 4)
        probabilityOfPrecipitationLabel.anchor(left: rainImage.rightAnchor, paddingLeft: 0.8)
        
        addSubview(windImage)
        windImage.dimensions(width: 22.5, height: 22.5)
        windImage.anchor(top: separator2.bottomAnchor, left: probabilityOfPrecipitationLabel.rightAnchor, bottom: bottomAnchor, paddingTop: 5, paddingLeft: 2.5, paddingBottom: 10)
        
        addSubview(windSpeedLabel)
        windSpeedLabel.centerY(inView: rainImage, constant: 4)
        windSpeedLabel.anchor(left: windImage.rightAnchor, paddingLeft: 0.8)
        
        addSubview(fahrenheitButton)
        fahrenheitButton.anchor(top: separator2.bottomAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingBottom: 10, paddingRight: 10)
        fahrenheitButton.dimensions(width: 19, height: 19)
        
        addSubview(celciusButton)
        celciusButton.anchor(top: separator2.bottomAnchor, bottom: bottomAnchor, right: fahrenheitButton.leftAnchor, paddingTop: 5, paddingBottom: 10)
        celciusButton.dimensions(width: 19, height: 19)
    }
    
    // MARK: - Selectors

    @objc func handleShowWeatherController() {
        
        delegate?.showWeatherController()
    }
}
