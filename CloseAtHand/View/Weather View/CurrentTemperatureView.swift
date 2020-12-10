//
//  CurrentTemperatureView.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 10/12/2020.
//

import UIKit

class CurrentTemperatureView: UIView {

    //MARK: - Properties

    private var currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "19°"
        label.textColor = UIColor.init(named: Constant.textColor)
        label.font = UIFont.systemFont(ofSize: 35)

        return label
    }()
    
    private var currentWeatherImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constant.fewClouds)
        image.tintColor = UIColor.init(named: Constant.textColor)
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private let currentDescriptionLabel: UILabel = {
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
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Helper Functions
    
    func configureUI() {
        layer.cornerRadius = 5
        backgroundColor = UIColor(named: Constant.secendaryBackgroundColor)
        addShadow()
        
        addSubview(currentWeatherImage)
        currentWeatherImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor,
                            paddingTop: 15, paddingLeft: 15, paddingBottom: 15)
        
        addSubview(currentTemperatureLabel)
        currentTemperatureLabel.centerY(inView: currentWeatherImage)
        currentTemperatureLabel.anchor(left: currentWeatherImage.rightAnchor, paddingLeft: 5)
        
        addSubview(currentDescriptionLabel)
        currentDescriptionLabel.anchor(top: topAnchor, right: rightAnchor,
                                paddingTop: 10, paddingRight: 15)
        
        addSubview(feelsTempLabel)
        feelsTempLabel.anchor(top: currentDescriptionLabel.bottomAnchor, right: rightAnchor,
                              paddingTop: 5, paddingRight: 15)
        
        addSubview(minTemp)
        minTemp.anchor(top: feelsTempLabel.bottomAnchor, bottom: bottomAnchor, right: rightAnchor,
                       paddingTop: 5, paddingBottom: 15, paddingRight: 15)
        
        let imageMinTemp = UIImageView()
        imageMinTemp.image = UIImage(named: Constant.minTemp)
        imageMinTemp.image = imageMinTemp.image?.withRenderingMode(.alwaysTemplate)
        imageMinTemp.tintColor = UIColor.init(named: Constant.textColor)
        imageMinTemp.contentMode = .scaleAspectFill
        imageMinTemp.dimensions(width: 10, height: 10)
        
        addSubview(imageMinTemp)
        imageMinTemp.centerY(inView: minTemp)
        imageMinTemp.anchor(right: minTemp.leftAnchor, paddingRight: 2)
        
        addSubview(maxTemp)
        maxTemp.anchor(right: imageMinTemp.leftAnchor, paddingRight: 5)
        maxTemp.centerY(inView: minTemp)
        
        let imageMaxTemp = UIImageView()
        imageMaxTemp.image = UIImage(named: Constant.maxTemp)
        imageMaxTemp.image = imageMaxTemp.image?.withRenderingMode(.alwaysTemplate)
        imageMaxTemp.tintColor = UIColor.init(named: Constant.textColor)
        imageMaxTemp.contentMode = .scaleAspectFill
        imageMaxTemp.dimensions(width: 10, height: 10)
        
        addSubview(imageMaxTemp)
        imageMaxTemp.centerY(inView: minTemp)
        imageMaxTemp.anchor(right: maxTemp.leftAnchor, paddingRight: 2)
    }
}
