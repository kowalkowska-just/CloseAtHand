//
//  WeatherWidget.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 01/12/2020.
//

import UIKit

class WeatherWidget: UIView {

    // MARK: - Properties
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Gdańsk"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        
        return label
    }()
    
    private let cantryLabel: UILabel = {
        let label = UILabel()
        label.text = "POLAND"
        label.textColor = .black
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
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleShowWeathercontroller), for: .touchUpInside)
        return button
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "19°C"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 42)
        
        return label
    }()
    
    private var weatherImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "cloud.sun")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let rainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "cloud.rain")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private var probabilityOfPrecipitationLabel: UILabel = {
        let label = UILabel()
        label.text = "25%"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let windImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "wind")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit

        return image
    }()
    
    private var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "34 km/h"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let celciusButton: UIButton = {
        let button = UIButton()
        button.setTitle("°C", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    private let fahrenheitButton: UIButton = {
        let button = UIButton()
        button.setTitle("°F", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
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
        backgroundColor = UIColor(white: 1, alpha: 0.5)
        layer.cornerRadius = 10
        
        addSubview(locationContainerView)
        locationContainerView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10)
        locationContainerView.dimensions(height: 40)
        
        addSubview(weatherButton)
        weatherButton.dimensions(width: 45)
        weatherButton.anchor(left: locationContainerView.rightAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: 10)
        weatherButton.centerY(inView: locationContainerView)
        
        let separator1 = UIView().createSeparator(color: .black)
        addSubview(separator1)
        separator1.anchor(top: locationContainerView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: 10)
        
        addSubview(temperatureLabel)
        temperatureLabel.anchor(top: separator1.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 10)
        
        addSubview(weatherImage)
        weatherImage.centerY(inView: temperatureLabel)
        weatherImage.anchor(left: temperatureLabel.rightAnchor, right: rightAnchor, paddingLeft: 5, paddingRight: 10)
        weatherImage.dimensions(width: 60, height: 45)
        
        let separator2 = UIView().createSeparator(color: .black)
        addSubview(separator2)
        separator2.anchor(top: weatherImage.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 10, paddingRight: 10)
        
        addSubview(rainImage)
        rainImage.dimensions(width: 20, height: 20)
        rainImage.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 10, paddingBottom: 10)
        
        addSubview(probabilityOfPrecipitationLabel)
        probabilityOfPrecipitationLabel.centerY(inView: rainImage, constant: 4)
        probabilityOfPrecipitationLabel.anchor(left: rainImage.rightAnchor, paddingLeft: 0.3)
        
        addSubview(windImage)
        windImage.dimensions(width: 20, height: 20)
        windImage.anchor(left: probabilityOfPrecipitationLabel.rightAnchor, bottom: bottomAnchor, paddingLeft: 5, paddingBottom: 10)
        
        addSubview(windSpeedLabel)
        windSpeedLabel.centerY(inView: rainImage, constant: 4)
        windSpeedLabel.anchor(left: windImage.rightAnchor, paddingLeft: 0.3)
        
        addSubview(fahrenheitButton)
        fahrenheitButton.anchor(bottom: bottomAnchor, right: rightAnchor, paddingBottom: 10, paddingRight: 10)
        fahrenheitButton.dimensions(width: 15, height: 15)
        
        addSubview(celciusButton)
        celciusButton.anchor(bottom: bottomAnchor, right: fahrenheitButton.leftAnchor, paddingBottom: 10)
        celciusButton.dimensions(width: 15, height: 15)
    }
    
    // MARK: - Selectors

    @objc func handleShowWeathercontroller() {
        
    }
}
