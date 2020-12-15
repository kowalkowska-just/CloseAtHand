//
//  HomeController.swift
//  CloseAtHand
//
//  Created by Justyna Kowalkowska on 26/11/2020.
//

import UIKit
import Firebase
import CoreData

class HomeController: UIViewController {

    //MARK: - Properties
    
    private var weatherWidget = WeatherWidget()
    
    private let calendarWidget = CalendarWidget()
    private let toDoListWidget = ToDoListWidget()
    private let plannerWidget = PlannerWidget()
    private let placesWidget = PlacesWidget()
    private let notesWidget = NotesWidget()
    
    private let locationManager = CLLocationManager()
    var weatherManager = WeatherManager()

    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherWidget.delegate = self
        weatherManager.delegate = self
        //        signOut()
        configureUI()
        checkIfUserIsLoggedIn()
    }
    
    //MARK: - API
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser?.uid == nil {
            print("DEBUG: User not logged in..")
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            print("DEBUG: User is logged in..")
            
        }
    }
    
    func signOut() {
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Error signing out..")
        }
    }
    
    //MARK: - Helper functions
    
    func configureUI() {
        configureNavBar()
        
        let tabBarHeight = tabBarController?.tabBar.frame.size.height ?? 0
        let statusBarHeight = navigationController?.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
        let heightView = view.bounds.size.height - tabBarHeight - statusBarHeight - navigationBarHeight
                
        view.backgroundColor = UIColor.init(named: Constant.backgroundColor)

        view.addSubview(weatherWidget)
        weatherWidget.dimensions(width: (view.bounds.size.width - 45) / 2,
                                 height: (heightView - 60) / 3)
        weatherWidget.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                             paddingTop: 15, paddingLeft: 15)
        weatherWidget.layer.cornerRadius = 4.5
        
        view.addSubview(calendarWidget)
        calendarWidget.dimensions(width: (view.bounds.size.width - 45) / 2,
                                  height: (heightView - 60) / 3)
        calendarWidget.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: weatherWidget.rightAnchor,
                              paddingTop: 15, paddingLeft: 15)
        calendarWidget.layer.cornerRadius = 4.5

        view.addSubview(toDoListWidget)
        toDoListWidget.dimensions(width: (view.bounds.size.width - 45) / 2,
                                  height: (heightView - 60) / 3)
        toDoListWidget.anchor(top: weatherWidget.bottomAnchor, left: view.leftAnchor,
                              paddingTop: 15, paddingLeft: 15)
        toDoListWidget.layer.cornerRadius = 4.5

        view.addSubview(plannerWidget)
        plannerWidget.dimensions(width: (view.bounds.size.width - 45) / 2,
                                 height: (heightView - 60) / 3)
        plannerWidget.anchor(top: calendarWidget.bottomAnchor, left: toDoListWidget.rightAnchor,
                             paddingTop: 15, paddingLeft: 15)
        plannerWidget.layer.cornerRadius = 4.5

        view.addSubview(notesWidget)
        notesWidget.dimensions(width: (view.bounds.size.width - 45) / 2,
                                height: (heightView - 60) / 3)
        notesWidget.anchor(top: toDoListWidget.bottomAnchor, left: view.leftAnchor,
                            paddingTop: 15, paddingLeft: 15)
        notesWidget.layer.cornerRadius = 4.5

        view.addSubview(placesWidget)
        placesWidget.dimensions(width: (view.bounds.size.width - 45) / 2,
                               height: (heightView - 60) / 3)
        placesWidget.anchor(top: plannerWidget.bottomAnchor, left: notesWidget.rightAnchor,
                           paddingTop: 15, paddingLeft: 15)
        placesWidget.layer.cornerRadius = 4.5
    }
    
    func configureNavBar() {
        configureNavigationBar(withTitle: "Home", withColor: UIColor.init(named: Constant.backgroundColor)!)
        
        if let navigationBar = self.navigationController?.navigationBar {
            
            let buttonFrame = CGRect(x: navigationBar.frame.width - navigationBar.frame.height, y: 20, width: navigationBar.frame.height - 16, height: navigationBar.frame.height - 16)
            
            let personButton = UIButton.init(frame: buttonFrame)
            personButton.setImage(UIImage(named: Constant.personIcon)?.withRenderingMode(.alwaysTemplate), for: .normal)
            personButton.tintColor = UIColor.init(named: Constant.textColor)!
            
            navigationBar.addSubview(personButton)
        }
    }
    
    enum AddressName: Int {
        case country
        case city
    }
    
    func getAddressFromLatLong(lat: Double, long: Double, completion: @escaping(String, String) -> Void ) {
        
        var center = CLLocationCoordinate2D()
        center.latitude = lat
        center.longitude = long
        
        let geoCoder = CLGeocoder()
        
        let location = CLLocation(latitude: center.latitude, longitude: center.longitude)
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                print("DEBUG: Failed get address from lat and long with error:\(String(describing: error))")
            }
            
            guard let placemark = placemarks?.first else { return }
            guard let country = placemark.country else { return }
            guard let city = placemark.locality else { return }
            
            let countryName = country
            let cityName = city
            
            completion(cityName, countryName)
        }
    }
    
    //MARK: - Selectors

    @objc func handlePersonController() {
        
    }
}

//MARK: - WeatherWidgetDelegate

extension HomeController: WeatherWidgetDelegate {
    func showWeatherController() {
        
        print("Show Weather Controller")
        let controller = UINavigationController(rootViewController: WeatherController())
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
        }
}

//MARK: - Weather Manager Delegate

extension HomeController: WeatherManagerDelegate {
    func didFailWithError(error: Error) {
        print("Failed parse JSON with error: \(error)")
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            let lat = weather.latitude
            let long = weather.longitude
            
            self.getAddressFromLatLong(lat: lat, long: long) { (city, country) in
                self.weatherWidget.cityLabel.text = city
                self.weatherWidget.countryLabel.text = country
            }
            
            self.weatherWidget.temperatureLabel.text = String(weather.temperature)
        }
    }
}

//MARK: - CCLocationManagerDelegatec

extension HomeController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(longitude: lon, latitude: lat)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("DEBUG: Failed update location with error: \(error)")
    }
}
