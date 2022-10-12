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
    
        initTextFieldDelegates()
        createToolbars()
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
            updateLabel(for: .red)
        case greenSlider:
            greenValue = CGFloat(greenSlider.value)
            updateLabel(for: .green)
        default:
            blueValue = CGFloat(blueSlider.value)
            updateLabel(for: .blue)
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
        updateLabel(for: .red)
        updateLabel(for: .green)
        updateLabel(for: .blue)
    }
    
    private func initTextFieldDelegates() {
        redSliderTF.delegate = self
        greenSliderTF.delegate = self
        blueSliderTF.delegate = self
    }
    
    private func updateLabel(for sliderColor: SliderType) {
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
    
    private func showAlert(withTitle title: String, andMessage message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func stringToCGFloat(_ stringNumber: String?) -> CGFloat? {
        guard let stringNumber = stringNumber,
              let number = NumberFormatter().number(from: stringNumber) else { return nil }
        let floatedNumber = CGFloat(truncating: number)
        let eps = CGFloat(0.00001)
        return floatedNumber > -eps && floatedNumber < 1 + eps
            ? floatedNumber
            : nil
    }
    
    private func createToolbars() {
        let bar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(toolbarDoneButtonTapped))
        bar.items = [flexSpace, doneButton]
        bar.sizeToFit()
        redSliderTF.inputAccessoryView = bar
        greenSliderTF.inputAccessoryView = bar
        blueSliderTF.inputAccessoryView = bar
    }
    
    private func showWrongFormatAlert(andClean textField: UITextField? = nil) {
        showAlert(
            withTitle: "Wrong format",
            andMessage: "Value must be in interval 0 to 1",
            textField: textField
        )
    }
}

// MARK: UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = stringToCGFloat(textField.text) else {
            showWrongFormatAlert(andClean: textField)
            return
        }
        
        switch textField {
        case redSliderTF:
            redValue = value
            redSlider.setValue(Float(redValue), animated: true)
            updateLabel(for: .red)
        case greenSliderTF:
            greenValue = value
            greenSlider.setValue(Float(greenValue), animated: true)
            updateLabel(for: .green)
        default:
            blueValue = value
            blueSlider.setValue(Float(blueValue), animated: true)
            updateLabel(for: .blue)
        }
        
        updateColorViewer()
    }
}
