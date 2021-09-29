//
//  ViewController.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 23.09.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    private let settingsView = UIView()
    private let locationTextView = UITextView()
    private let locationManager = CLLocationManager()
    private let locationToggle = UISwitch(frame: CGRect.zero)
    private let settingsButton = UIButton(type: .system)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        
        setupLocationTextView()
        setupSettingsButton()
        locationManager.requestWhenInUseAuthorization()
        setupLocationManager()
        setupSettingsView()
        setupLocationToggle()
    }
    
    private func setupSettingsButton() {
        view.addSubview(settingsButton)
        settingsButton.setImage(
            UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal),
            for: .normal
        )
        
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed),
        for: .touchUpInside)
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 15
        ).isActive = true
        
        settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -15
        ).isActive = true
        
        settingsButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupSettingsView() {
        view.addSubview(settingsView)
        settingsView.backgroundColor = UIColor.lightGray
        settingsView.alpha = 0
        settingsView.layer.cornerRadius = 12
        
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 45
        ).isActive = true
        
        settingsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -45
        ).isActive = true
        
        
        settingsView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        settingsView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func setupLocationTextView() {
        view.addSubview(locationTextView)
        
        locationTextView.backgroundColor = UIColor.white
        locationTextView.layer.cornerRadius = 20
        locationTextView.translatesAutoresizingMaskIntoConstraints = false

        locationTextView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 60
        ).isActive = true
        locationTextView.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
        ).isActive = true
        locationTextView.heightAnchor.constraint(
            equalToConstant: 300
        ).isActive = true
        locationTextView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 15
        ).isActive = true
        locationTextView.isUserInteractionEnabled = false
    }

    private func setupLocationToggle() {
        settingsView.addSubview(locationToggle)
        
        locationToggle.tintColor = UIColor.blue
        locationToggle.thumbTintColor = UIColor.black
        locationToggle.onTintColor = UIColor.systemYellow
        
        
        locationToggle.layer.cornerRadius = 15
        locationToggle.clipsToBounds = true
        
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        locationToggle.topAnchor.constraint(equalTo: settingsView.topAnchor,
            constant: 30
        ).isActive = true
        locationToggle.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor,
            constant: -10
        ).isActive = true
        
        locationToggle.addTarget(self,
            action: #selector(locationToggleSwitched),
            for: .valueChanged
        )
    }
    
    private func setupLocationManager() {
        let locationLabel = UILabel()
        settingsView.addSubview(locationLabel)
        locationLabel.text = "Location"
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        locationLabel.topAnchor.constraint(
            equalTo: settingsView.topAnchor,
            constant: 35
        ).isActive = true
        locationLabel.leadingAnchor.constraint(
            equalTo: settingsView.leadingAnchor,
            constant: 25
        ).isActive = true
        locationLabel.trailingAnchor.constraint(
            equalTo: settingsView.trailingAnchor,
            constant: -10
        ).isActive = true
    }
    
    @objc private func locationToggleSwitched(_ sender: UISwitch) {
        if sender.isOn {
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            } else {
                sender.setOn(false, animated: true)
            }
            
        } else {
            locationToggle.clipsToBounds = true
            locationTextView.text = ""
            locationManager.stopUpdatingLocation()
        }
    }
    
    @objc private func settingsButtonPressed() {
        UIView.animate(withDuration: 0.1, animations: {
        self.settingsView.alpha = 1 - self.settingsView.alpha
        })
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        locationTextView.text = "Coordinates = \(coord.latitude) \(coord.longitude)"
    }
}
