//
//  HourlyForecastView.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 10/12/2020.
//

import UIKit

class HourlyForecastView: UIView {

    //MARK: - Properties
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "21:00"
        label.font = UIFont.systemFont(ofSize: 15)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
    }()
    
    private var weatherImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constant.clearSky)
        return image
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "18°"
        label.font = UIFont.systemFont(ofSize: 15)
        label.tintColor = UIColor(named: Constant.textColor)
        return label
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
    
    private lazy var precipitationView: UIView = {
        let view = UIView()
        view.addSubview(rainImage)
        rainImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor)
        
        view.addSubview(probabilityOfPrecipitationLabel)
        probabilityOfPrecipitationLabel.anchor(left: rainImage.rightAnchor, right: view.rightAnchor, paddingLeft: 2)
        probabilityOfPrecipitationLabel.centerY(inView: rainImage)
        
        return view
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
    
    private func configureUI() {
        backgroundColor = UIColor(named: Constant.secendaryBackgroundColor)
        
        addSubview(timeLabel)
        timeLabel.anchor(top: topAnchor, paddingTop: 5)
        timeLabel.centerX(inView: self)
        
        addSubview(weatherImage)
        weatherImage.anchor(top: timeLabel.bottomAnchor, paddingTop: 4)
        weatherImage.dimensions(width: 20, height: 20)
        weatherImage.centerX(inView: timeLabel)
        
        addSubview(temperatureLabel)
        temperatureLabel.anchor(top: weatherImage.bottomAnchor, paddingTop: 4)
        temperatureLabel.centerX(inView: timeLabel)
        
        addSubview(precipitationView)
        precipitationView.anchor(top: temperatureLabel.bottomAnchor, bottom: self.bottomAnchor)
        precipitationView.centerX(inView: timeLabel)
        precipitationView.dimensions(height: 10)
    }

}
