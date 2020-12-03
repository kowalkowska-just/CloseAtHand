//
//  PlacesWidget.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 03/12/2020.
//

import UIKit

class PlacesWidget: UIView {

    // MARK: - Properties

    
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
        backgroundColor = UIColor.green.withAlphaComponent(0.5)
        layer.cornerRadius = 10
        addShadow()
    }
    
    // MARK: - Selectors

}
