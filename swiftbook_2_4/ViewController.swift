//
//  ViewController.swift
//  swiftbook_2_4
//
//  Created by dobrets on 25.09.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redSliderLabel: UILabel!
    @IBOutlet var greenSliderLabel: UILabel!
    @IBOutlet var blueSliderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        redSliderLabel.text = String(format: "%.2f", redSlider.value)
        greenSliderLabel.text = String(format: "%.2f", greenSlider.value)
        blueSliderLabel.text = String(format: "%.2f", blueSlider.value)
        
        colorView.layer.cornerRadius = 10
        updateColor()
    }

    // MARK: IBActions
    @IBAction func redSliderChanged() {
        redSliderLabel.text = String(format: "%.2f", redSlider.value)
        updateColor()
    }
    
    @IBAction func greenSliderChanged() {
        greenSliderLabel.text = String(format: "%.2f", greenSlider.value)
        updateColor()
    }
    
    @IBAction func blueSliderChanged() {
        blueSliderLabel.text = String(format: "%.2f", blueSlider.value)
        updateColor()
    }
    
    // MARK: Private functions
    private func updateColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
}

