//
//  ViewController.swift
//  mvgarbuzovPW2
//
//  Created by Matvey Garbuzov on 23.09.2021.
//

import UIKit

class ViewController: UIViewController {
    private let settingsView = UIView()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.appearance().backgroundColor = UIColor.darkGray
        setupSettingsView()
        setupSettingsButton()
        // Do any additional setup after loading the view.
    }
    
    private func setupSettingsButton() {
        let settingsButton = UIButton(type: .system)
        view.addSubview(settingsButton)
        settingsButton.setImage(
        UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal), for: .normal
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
        settingsView.backgroundColor = UIColor.systemYellow
        settingsView.alpha = 0
        
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 10
        ).isActive = true
        
        settingsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -10
        ).isActive = true
        
        
        settingsView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        settingsView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    @objc private func settingsButtonPressed() {
        UIView.animate(withDuration: 0.1, animations: {
        self.settingsView.alpha = 1 - self.settingsView.alpha
        })
    }
}

