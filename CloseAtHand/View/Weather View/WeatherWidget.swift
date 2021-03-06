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
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(named: Constant.textColor)
        label.numberOfLines = 1
        label.lineBreakMode = .byClipping
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        
        return label
    }()
    
    var countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(named: Constant.textColor)
        label.numberOfLines = 1
        label.lineBreakMode = .byClipping
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var locationContainerView: UIView = {
        let view = UIView()
        view.addSubview(cityLabel)
        cityLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        view.addSubview(countryLabel)
        countryLabel.anchor(top: cityLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 1)
        
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
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(named: Constant.textColor)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.font = label.font.withSize(label.frame.height)
        label.font = UIFont.systemFont(ofSize: 30)
        label.baselineAdjustment = .alignCenters
        label.lineBreakMode = .byClipping
        label.textAlignment = .center

        return label
    }()
    
    var weatherImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = UIColor.init(named: Constant.textColor)
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private lazy var temperatureContainerView: UIView = {
        let view = UIView()
        let tempView = UIView()
        let imageView = UIView()
        
        tempView.addSubview(temperatureLabel)
        temperatureLabel.anchor(top: tempView.topAnchor, left: tempView.leftAnchor,
                                bottom: tempView.bottomAnchor, right: tempView.rightAnchor,
                                paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 15)
        
        imageView.addSubview(weatherImage)
        weatherImage.centerX(inView: imageView)
        weatherImage.anchor(top: imageView.topAnchor, left: imageView.leftAnchor,
                            bottom: imageView.bottomAnchor, right: imageView.rightAnchor,
                            paddingTop: 15, paddingLeft: 15, paddingBottom: 5, paddingRight: 5)

        let stack = UIStackView(arrangedSubviews: [imageView, tempView])
        stack.spacing = 25
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        return view
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(named: Constant.textColor)
        label.numberOfLines = 1
        label.lineBreakMode = .byClipping
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        
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
    
    var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(named: Constant.textColor)
        label.font = UIFont.systemFont(ofSize: 11)
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
        locationContainerView.anchor(top: titleView.bottomAnchor, left: leftAnchor,
                                     paddingTop: 2, paddingLeft: 10)
        locationContainerView.dimensions(height: 36)
        
        addSubview(weatherButton)
        weatherButton.dimensions(width: 20)
        weatherButton.anchor(left: locationContainerView.rightAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: 10)
        weatherButton.centerY(inView: locationContainerView)
        
        let separator1 = UIView().createSeparator(color: UIColor.init(named: Constant.textColor) ?? .white)
        addSubview(separator1)
        separator1.anchor(top: locationContainerView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: 10)
        
        addSubview(windImage)
        windImage.dimensions(width: 16, height: 16)
        windImage.anchor(left: leftAnchor, bottom: bottomAnchor,
                         paddingLeft: 10, paddingBottom: 5)
        
        addSubview(windSpeedLabel)
        windSpeedLabel.centerY(inView: windImage)
        windSpeedLabel.anchor(left: windImage.rightAnchor, paddingLeft: 5)
        
        addSubview(fahrenheitButton)
        fahrenheitButton.anchor(bottom: bottomAnchor, right: rightAnchor,
                                paddingBottom: 5, paddingRight: 10)
        fahrenheitButton.dimensions(width: 19, height: 19)
        
        addSubview(celciusButton)
        celciusButton.anchor(bottom: bottomAnchor, right: fahrenheitButton.leftAnchor,
                             paddingBottom: 5)
        celciusButton.dimensions(width: 19, height: 19)
        
        let separator2 = UIView().createSeparator(color: UIColor.init(named: Constant.textColor) ?? .white)
        addSubview(separator2)
        separator2.anchor(left: leftAnchor, bottom: windImage.topAnchor, right: rightAnchor,
                          paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
        
        addSubview(descriptionLabel)
        descriptionLabel.dimensions(height: 15)
        descriptionLabel.anchor(left: leftAnchor, bottom: separator2.topAnchor, right: rightAnchor,
                                paddingLeft: 10, paddingBottom: 3, paddingRight: 10)
        
        addSubview(temperatureContainerView)
        temperatureContainerView.anchor(top: separator1.bottomAnchor, left: leftAnchor,
                                        bottom: descriptionLabel.topAnchor, right: rightAnchor,
                                        paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
    }
    
    // MARK: - Selectors

    @objc func handleShowWeatherController() {
        delegate?.showWeatherController()
    }
}
