//
//  MainViewController.swift
//  swiftbook_2_4
//
//  Created by dobrets on 12.10.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewBackground(for color: UIColor)
}

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor ?? UIColor.white
        settingsVC.delegate = self
    }
    
}

extension MainViewController: SettingsViewControllerDelegate {
    func setNewBackground(for color: UIColor) {
        view.backgroundColor = color
    }
}
