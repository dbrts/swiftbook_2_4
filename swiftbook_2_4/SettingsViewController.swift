//
//  ViewController.swift
//  swiftbook_2_4
//
//  Created by dobrets on 25.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {

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
    
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
    
        labelsUpdate(for: .red)
        labelsUpdate(for: .green)
        labelsUpdate(for: .blue)
        
        colorView.layer.cornerRadius = 10
        updateColor()
    }

    // MARK: IBActions
    @IBAction func sliderChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            labelsUpdate(for: .red)
        case greenSlider:
            labelsUpdate(for: .green)
        default:
            labelsUpdate(for: .blue)
        }
        
        updateColor()
    }
    
    @IBAction func doneButtonTapped() {
        color = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
        delegate.setNewBackground(for: color)
        dismiss(animated: true)
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

extension SettingsViewController {
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
