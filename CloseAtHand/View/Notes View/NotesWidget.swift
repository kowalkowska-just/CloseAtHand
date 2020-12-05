//
//  NotesWidget.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 03/12/2020.
//

import UIKit

class NotesWidget: UIView {

    // MARK: - Properties
    
    private lazy var titleView: UIView = {
        let view = UIView().inputContainerViewForTitle(title: "Notes", imageColor: Constatnt.notesColor, image: Constatnt.notesIcon)
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
        backgroundColor = UIColor.init(named: Constatnt.secendaryBackgroundColor)
        addShadow()
        
        addSubview(titleView)
        titleView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0)
        titleView.dimensions(height: 40)

        let separator0 = UIView().createSeparator(color: UIColor.init(named: Constatnt.notesColor)!)
        separator0.addShadow()
        addSubview(separator0)
        separator0.anchor(top: titleView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingLeft: 0, paddingRight: 0)
    }
    
    // MARK: - Selectors

}
