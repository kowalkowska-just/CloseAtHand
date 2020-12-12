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
    
    private var hourlyForecasteTableView: UITableView!
    private var weekForecasteTableView: UITableView!
    private let locationContainerView = CurrentLocationView()
    private let temperatureContainerView = CurrentTemperatureView()
    
    private let locationManager = LocationHandler.shared.locationManager
    
    private let weatherModels = [WeatherData]()
    private var currentWeatherModels = [CurrentWeatherData]()
    private var hourlyForecastModels = [HourlyForecastData]()
    private var dailyForecastModels = [DailyForecastData]()
    
//MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

//MARK: - Helper functions
    
    private func configureUI() {
        configureNavBar()
       // configureTableView()
        view.backgroundColor = UIColor.init(named: Constant.backgroundColor)
        
        view.addSubview(locationContainerView)
        locationContainerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                 paddingTop: 15, paddingLeft: 15, paddingRight: 15)
        
        view.addSubview(temperatureContainerView)
        temperatureContainerView.anchor(top: locationContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                    paddingTop: 5, paddingLeft: 15, paddingRight: 15)
        
//        view.addSubview(hourlyForecasteTableView)
//        hourlyForecasteTableView.layer.cornerRadius = 5
//        hourlyForecasteTableView.anchor(top: temperatureContainerView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingRight: 15)
//        
//        view.addSubview(weekForecasteTableView)
//        weekForecasteTableView.layer.cornerRadius = 5
//        weekForecasteTableView.anchor(top: hourlyForecasteTableView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingRight: 15)
    }
    
    func configureTableView() {
        weekForecasteTableView.delegate = self
        weekForecasteTableView.dataSource = self
        
        weekForecasteTableView.backgroundColor = UIColor(named: Constant.secendaryBackgroundColor)
        weekForecasteTableView.separatorStyle = .none
        weekForecasteTableView.isScrollEnabled = true
        weekForecasteTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.weekForecastCell)
        
        hourlyForecasteTableView.delegate = self
        hourlyForecasteTableView.dataSource = self
        
        hourlyForecasteTableView.backgroundColor = UIColor(named: Constant.secendaryBackgroundColor)
        hourlyForecasteTableView.separatorStyle = .none
        hourlyForecasteTableView.isScrollEnabled = true
        hourlyForecasteTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.weekForecastCell)
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

        switch tableView {
        case hourlyForecasteTableView:
            return hourlyForecastModels.count
        case weekForecasteTableView:
            return dailyForecastModels.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        switch tableView {
        case hourlyForecasteTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: Constant.hourlyForecastCell, for: indexPath) as! HourlyForecastCell
            return cell
        case weekForecasteTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: Constant.weekForecastCell, for: indexPath) as! WeekForecastCell
            return cell
        default:
            return UITableViewCell()

        }
    }
}
