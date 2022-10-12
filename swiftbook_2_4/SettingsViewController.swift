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
    
    // MARK: Public variables
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: Private variables
    private var redValue: CGFloat = 0
    private var greenValue: CGFloat = 0
    private var blueValue: CGFloat = 0
    private var alphaValue: CGFloat = 0

    // MARK: Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10
        
        color.getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alphaValue)
        initSliders()
        initLabels()
        updateColorViewer()
        
        redSliderTF.delegate = self
        greenSliderTF.delegate = self
        blueSliderTF.delegate = self
        
        let bar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(toolbarDoneButtonTapped))
        bar.items = [flexSpace, doneButton]
        bar.sizeToFit()
        redSliderTF.inputAccessoryView = bar
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    // MARK: IBActions
    @IBAction func sliderChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            redValue = CGFloat(redSlider.value)
            labelsUpdate(for: .red)
        case greenSlider:
            greenValue = CGFloat(greenSlider.value)
            labelsUpdate(for: .green)
        default:
            blueValue = CGFloat(blueSlider.value)
            labelsUpdate(for: .blue)
        }
        
        updateColorViewer()
    }
    
    @IBAction func doneButtonTapped() {
        color = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
        delegate.setNewBackground(for: color)
        dismiss(animated: true)
    }
}

// MARK: Private functions
extension SettingsViewController {
    enum SliderType {
        case red, green, blue
    }
    
    private func updateColorViewer() {
        colorView.backgroundColor = UIColor(
            red: redValue,
            green: greenValue,
            blue: blueValue,
            alpha: 1
        )
    }
    
    private func initSliders() {
        redSlider.value = Float(redValue)
        greenSlider.value = Float(greenValue)
        blueSlider.value = Float(blueValue)
    }
    
    private func initLabels() {
        labelsUpdate(for: .red)
        labelsUpdate(for: .green)
        labelsUpdate(for: .blue)
    }
    
    private func labelsUpdate(for sliderColor: SliderType) {
        switch sliderColor {
        case .red:
            redSliderLabel.text = String(format: "%.2f", redValue)
            redSliderTF.text = String(format: "%.2f", redValue)
        case .green:
            greenSliderLabel.text = String(format: "%.2f", greenValue)
            greenSliderTF.text = String(format: "%.2f", greenValue)
        case .blue:
            blueSliderLabel.text = String(format: "%.2f", blueValue)
            blueSliderTF.text = String(format: "%.2f", blueValue)
        }
    }
    
    @objc private func toolbarDoneButtonTapped() {
        view.endEditing(true)
    }
    
    private func showAlert(withTitle title: String, andMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func stringToCGFloat(_ str: String?) -> CGFloat {
        if let number = NumberFormatter().number(from: str ?? "0") {
            let floatedNumber = CGFloat(truncating: number)
            return floatedNumber
        } else {
            return 0
        }
    }
}

// MARK: UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case redSliderTF:
            redValue = stringToCGFloat(redSliderTF.text)
            redSlider.setValue(Float(redValue), animated: true)
            labelsUpdate(for: .red)
        case greenSliderTF:
            greenValue = stringToCGFloat(greenSliderTF.text)
            greenSlider.setValue(Float(greenValue), animated: true)
            labelsUpdate(for: .green)
        default:
            blueValue = stringToCGFloat(blueSliderTF.text)
            blueSlider.setValue(Float(blueValue), animated: true)
            labelsUpdate(for: .blue)
        }
        
        updateColorViewer()
    }
}
