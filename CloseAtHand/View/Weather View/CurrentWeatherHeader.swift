//
//  CurrentWeatherHeader.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 16/12/2020.
//

import UIKit

class CurrentWeatherHeader: UIView {

    //MARK: - Properties
    
    private let placeIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constant.placeIcon)
        image.tintColor = UIColor(named: Constant.textColor)
        image.contentMode = .scaleAspectFit
        image.image = image.image?.withRenderingMode(.alwaysTemplate)

        return image
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Gdansk"
        label.font = UIFont.systemFont(ofSize: 20)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()
        
    private let dateLabel:  UILabel = {
        let label = UILabel()
        label.text = "Thursday, December 10"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
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
    
    var currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "19°"
        label.textColor = UIColor.init(named: Constant.textColor)
        label.font = UIFont.systemFont(ofSize: 35)

        return label
    }()
    
    var currentWeatherImage: UIImageView = {
        let image = UIImageView()
     //   image.image = UIImage(named: )
        image.tintColor = UIColor.init(named: Constant.textColor)
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    let currentDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Few clouds"
        label.font = UIFont.systemFont(ofSize: 15)
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
        label.font = UIFont.systemFont(ofSize: 12)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()
    
    private let maxTemp: UILabel = {
        let label = UILabel()
        label.text = "23°"
        label.font = UIFont.systemFont(ofSize: 12)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()
    
    private lazy var minMaxTempView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var feelsTemp = 23
    
    private lazy var feelsTempLabel: UILabel = {
        let label = UILabel()
        label.text = "Feels like \(feelsTemp)°"
        label.font = UIFont.systemFont(ofSize: 12)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()
        
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Function
    
    func configureUI() {
        
        let locationView = UIView()
        locationView.layer.cornerRadius = 5
        locationView.backgroundColor = UIColor(named: Constant.secendaryBackgroundColor)
        locationView.addShadow()
        
        locationView.addSubview(dateLabel)
        dateLabel.anchor(top: locationView.topAnchor, right: locationView.rightAnchor,
                         paddingTop: 10, paddingRight: 15)
        dateLabel.dimensions(width: 150)
        
        locationView.addSubview(timeLabel)
        timeLabel.anchor(top: dateLabel.bottomAnchor, bottom: locationView.bottomAnchor, right: locationView.rightAnchor,
                         paddingTop: 1, paddingBottom: 10, paddingRight: 15)
        
        locationView.addSubview(placeIcon)
        placeIcon.centerY(inView: locationView)
        placeIcon.anchor(left: locationView.leftAnchor, paddingLeft: 15)
        placeIcon.dimensions(width: 16, height: 16)
        
        locationView.addSubview(locationLabel)
        locationLabel.centerY(inView: locationView)
        locationLabel.anchor(left: placeIcon.rightAnchor, right: dateLabel.leftAnchor,
                             paddingLeft: 5, paddingRight: 3)
        
        let temperatureView = UIView()
        temperatureView.layer.cornerRadius = 5
        temperatureView.backgroundColor = UIColor(named: Constant.secendaryBackgroundColor)
        temperatureView.addShadow()
        
        temperatureView.addSubview(currentWeatherImage)
        currentWeatherImage.anchor(top: temperatureView.topAnchor, left: temperatureView.leftAnchor, bottom: temperatureView.bottomAnchor,
                            paddingTop: 15, paddingLeft: 15, paddingBottom: 15)
        
        temperatureView.addSubview(currentTemperatureLabel)
        currentTemperatureLabel.centerY(inView: currentWeatherImage)
        currentTemperatureLabel.anchor(left: currentWeatherImage.rightAnchor, paddingLeft: 5)
        
        temperatureView.addSubview(currentDescriptionLabel)
        currentDescriptionLabel.anchor(top: temperatureView.topAnchor, right: temperatureView.rightAnchor,
                                paddingTop: 10, paddingRight: 15)
        
        temperatureView.addSubview(feelsTempLabel)
        feelsTempLabel.anchor(top: currentDescriptionLabel.bottomAnchor, right: temperatureView.rightAnchor,
                              paddingTop: 3, paddingRight: 15)
        
        temperatureView.addSubview(minTemp)
        minTemp.anchor(bottom: temperatureView.bottomAnchor, right: temperatureView.rightAnchor, paddingBottom: 15, paddingRight: 15)
        
        let imageMinTemp = UIImageView()
        imageMinTemp.image = UIImage(named: Constant.minTemp)
        imageMinTemp.image = imageMinTemp.image?.withRenderingMode(.alwaysTemplate)
        imageMinTemp.tintColor = UIColor.init(named: Constant.textColor)
        imageMinTemp.contentMode = .scaleAspectFill
        imageMinTemp.dimensions(width: 13, height: 13)
        
        temperatureView.addSubview(imageMinTemp)
        imageMinTemp.centerY(inView: minTemp)
        imageMinTemp.anchor(top: feelsTempLabel.bottomAnchor, right: minTemp.leftAnchor, paddingTop: 8, paddingRight: 5)
        
        temperatureView.addSubview(maxTemp)
        maxTemp.anchor(right: imageMinTemp.leftAnchor, paddingRight: 12)
        maxTemp.centerY(inView: minTemp)
        
        let imageMaxTemp = UIImageView()
        imageMaxTemp.image = UIImage(named: Constant.maxTemp)
        imageMaxTemp.image = imageMaxTemp.image?.withRenderingMode(.alwaysTemplate)
        imageMaxTemp.tintColor = UIColor.init(named: Constant.textColor)
        imageMaxTemp.contentMode = .scaleAspectFill
        imageMaxTemp.dimensions(width: 13, height: 13)
        
        temperatureView.addSubview(imageMaxTemp)
        imageMaxTemp.centerY(inView: minTemp)
        imageMaxTemp.anchor(right: maxTemp.leftAnchor, paddingRight: 5)
        
        addSubview(locationView)
        addSubview(temperatureView)
        
        locationView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 5)
        temperatureView.anchor(top: locationView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingBottom: 5)
    }
}
