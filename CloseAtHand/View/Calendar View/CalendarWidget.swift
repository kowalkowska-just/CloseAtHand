//
//  CalendarWidget.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 03/12/2020.
//

import UIKit

class CalendarWidget: UIView {

    // MARK: - Properties

    private lazy var titleView: UIView = {
        let view = UIView().inputContainerViewForTitle(title: "Calendar", imageColor: Constant.calendarColor, image: Constant.calendarIcon)
        return view
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

    }
    
    // MARK: - Selectors

}
