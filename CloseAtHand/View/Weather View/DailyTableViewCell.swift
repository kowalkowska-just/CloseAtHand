//
//  WeekForecastView.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 10/12/2020.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Function

    private func configureUI() {
        backgroundColor = UIColor(named: Constant.secendaryBackgroundColor)
    }
}
