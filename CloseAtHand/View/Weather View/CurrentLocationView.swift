//
//  CurrentLocationView.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 10/12/2020.
//

import UIKit

class CurrentLocationView: UIView {

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
        
        addSubview(dateLabel)
        dateLabel.anchor(top: topAnchor, right: rightAnchor,
                         paddingTop: 15, paddingRight: 15)
        dateLabel.dimensions(width: 150)
        
        addSubview(timeLabel)
        timeLabel.anchor(top: dateLabel.bottomAnchor, bottom: bottomAnchor, right: rightAnchor,
                         paddingTop: 1, paddingBottom: 15, paddingRight: 15)
        
        addSubview(placeIcon)
        placeIcon.centerY(inView: self)
        placeIcon.anchor(left: leftAnchor, paddingLeft: 15)
        placeIcon.dimensions(width: 15, height: 15)
        
        addSubview(locationLabel)
        locationLabel.centerY(inView: self)
        locationLabel.anchor(left: placeIcon.rightAnchor, right: dateLabel.leftAnchor,
                             paddingLeft: 5, paddingRight: 3)
    }
}
