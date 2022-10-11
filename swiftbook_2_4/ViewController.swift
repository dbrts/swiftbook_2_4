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
    
    @IBOutlet var redSliderTF: UITextField!
    @IBOutlet var greenSliderTF: UITextField!
    @IBOutlet var blueSliderTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        labelsUpdate(for: .red)
        labelsUpdate(for: .green)
        labelsUpdate(for: .blue)
        
        colorView.layer.cornerRadius = 10
        updateColor()
    }

    // MARK: IBActions
    @IBAction func redSliderChanged() {
        labelsUpdate(for: .red)
        updateColor()
    }
    
    @IBAction func greenSliderChanged() {
        labelsUpdate(for: .green)
        updateColor()
    }
    
    @IBAction func blueSliderChanged() {
        labelsUpdate(for: .blue)
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

extension ViewController {
    enum SliderType {
        case red, green, blue
    }
    
    private func labelsUpdate(for sliderColor: SliderType) {
        let value: Float
        switch sliderColor {
        case .red:
            value = redSlider.value
            redSliderLabel.text = String(format: "%.2f", value)
            redSliderTF.text = String(format: "%.2f", value)
        case .green:
            value = greenSlider.value
            greenSliderLabel.text = String(format: "%.2f", value)
            greenSliderTF.text = String(format: "%.2f", value)
        case .blue:
            value = blueSlider.value
            blueSliderLabel.text = String(format: "%.2f", value)
            blueSliderTF.text = String(format: "%.2f", value)
        }
    }
}
