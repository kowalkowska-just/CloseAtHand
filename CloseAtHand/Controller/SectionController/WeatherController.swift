//
//  WeatherController.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 02/12/2020.
//

import UIKit
import CoreData


class WeatherController: UIViewController {
    
//MARK: - Properties
    
  //  private var weatherModels = [WeatherModel]()
    private var tableView = UITableView()
    
    private lazy var currentWeatherHeader: CurrentWeatherHeader = {
        let frame = CGRect(x: 15, y: 0, width: view.frame.width - 30, height: 150)
        let view = CurrentWeatherHeader(frame: frame)
        return view
    }()
    
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

//MARK: - Helper functions
    
    private func configureUI() {
        configureNavBar()
        configureTableView()
        view.backgroundColor = UIColor.init(named: Constant.backgroundColor)
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 15, paddingBottom: 15, paddingRight: 15)
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 60
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: Constant.dailyTableViewCell)
        tableView.register(HourlyTableViewCell.self, forCellReuseIdentifier: Constant.hourlyTableViewCell)
        
        tableView.backgroundColor = UIColor(named: Constant.backgroundColor)
        tableView.isScrollEnabled = true
        
        tableView.tableHeaderView = currentWeatherHeader
        tableView.tableFooterView = UIView()
        }
    
    private func configureNavBar() {
        configureNavigationBar(withTitle: "Weather", withColor: UIColor.init(named: Constant.backgroundColor)!)
        
        if let navigationBar = self.navigationController?.navigationBar {
            
            let menuFrame = CGRect(x: navigationBar.frame.width - navigationBar.frame.height,
                                   y: 20, width: navigationBar.frame.height - 22,
                                   height: navigationBar.frame.height - 22)
            let plusFrame = CGRect(x: navigationBar.frame.width - (2 * navigationBar.frame.height) - 10,
                                   y: 20, width: navigationBar.frame.height - 19,
                                   height: navigationBar.frame.height - 19)
            let backFrame = CGRect(x: 20,
                                   y: 20, width: navigationBar.frame.height - 22,
                                   height: navigationBar.frame.height - 22)
            
            let menuButton = UIButton.init(frame: menuFrame)
            menuButton.setImage(UIImage(named: Constant.menuIcon)?.withRenderingMode(.alwaysTemplate), for: .normal)
            menuButton.tintColor = UIColor.init(named: Constant.textColor)!

            let plusButton = UIButton.init(frame: plusFrame)
            plusButton.setImage(UIImage(named: Constant.plusIcon)?.withRenderingMode(.alwaysTemplate), for: .normal)
            plusButton.tintColor = UIColor.init(named: Constant.textColor)!
            
            let backButton = UIButton.init(frame: backFrame)
            backButton.setImage(UIImage(named: Constant.backIcon)?.withRenderingMode(.alwaysTemplate), for: .normal)
            backButton.tintColor = UIColor.init(named: Constant.textColor)!
            backButton.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
            
            navigationBar.addSubview(menuButton)
            navigationBar.addSubview(plusButton)
            navigationBar.addSubview(backButton)
        }
    }

//MARK: - Selectors

    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITableViewDelegate/DataSource

extension WeatherController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
       // return weatherModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
    }
}

