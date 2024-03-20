//
//  BMRVC.swift
//  KaanArslan_HW2
//
//  Created by kaan2 on 18.03.2024.
//

import UIKit

class BMRVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
   
    @IBAction func calculate(_ sender: UIButton) {
        let bmr = calculateBMR()
                
                // Display BMR in an alert dialog
                let alert = UIAlertController(title: "Basal Metabolic Rate (BMR)", message: "Your BMR is: \(bmr)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    var height: Double = 0.0 // Global variable to store height
    var weight: Double = 0.0
    @IBOutlet weak var mHeight: UITextField!
    
    
    
    @IBOutlet weak var mWeight: UITextField!
    
    var selectedActivityLevel: String?
    var activityLevels: [String] = []
    @IBOutlet weak var mPickerView: UIPickerView!
    @IBOutlet weak var AgeLabel: UILabel!
    var selectedGender: String = "Male"
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        let isMale = sender.isOn
               updateGenderLabel(isMale: isMale)
               selectedGender = isMale ? "Male" : "Female"
        print(selectedGender)
    }
    @IBOutlet weak var mswitch: UISwitch!
    @IBOutlet weak var genderLabel: UILabel!
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        let currentValue = Int(sender.value)
               updateAgeLabel(value: currentValue)
               selectedAge = currentValue // Update selectedAge variable
        print(selectedAge)
    }
    @IBOutlet weak var ageSlider: UISlider!
    var selectedAge: Int = 0
    @IBOutlet var superview: UIView!
    @IBOutlet weak var myView: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let plistPath = Bundle.main.path(forResource: "types", ofType: "plist"),
                   let plistData = FileManager.default.contents(atPath: plistPath),
                   let levels = try? PropertyListSerialization.propertyList(from: plistData, options: .mutableContainers, format: nil) as? [String] {
                    activityLevels = levels
                }
                
                // Set the initial selected value
                selectedActivityLevel = activityLevels.first
        mPickerView.dataSource = self
        mPickerView.delegate = self
        updateGenderLabel(isMale: mswitch.isOn)
        mswitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        ageSlider.minimumValue = 10
        ageSlider.maximumValue = 100
        ageSlider.value = 25
        updateAgeLabel(value: Int(ageSlider.value))
        selectedAge = Int(ageSlider.value)
        ageSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
                       
        //superview.layer.zPosition=0
//        myView.layer.zPosition=1
        
        
        
        //print("bmr works")
        // Do any additional setup after loading the view.
        mHeight.keyboardType = .decimalPad
               mWeight.keyboardType = .decimalPad
        
    }
    func updateAgeLabel(value: Int) {
            AgeLabel.text = "Age: \(value)"
    }
    func updateGenderLabel(isMale: Bool) {
           genderLabel.text = isMale ? "Gender: Male" : "Gender: Female"
       }
       
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return activityLevels.count
        }
        
        // MARK: - UIPickerViewDelegate methods
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return activityLevels[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedActivityLevel = activityLevels[row]
            // You can use selectedActivityLevel for further calculations or actions
            print("Selected activity level: \(selectedActivityLevel ?? "Unknown")")
        }
    
    func calculateBMR() -> Double {
          // Get the height, weight, and activity level from text fields and switch
        guard let heightText = mHeight.text, let height = Double(heightText),
                let weightText = mWeight.text, let weight = Double(weightText) else {
              return 0.0
          }
          
          // Calculate BMR based on gender
          var bmr: Double
          if selectedGender == "Male" {
              bmr = 10.0 * weight + 6.25 * height - 5.0 * Double(selectedAge) + 5.0
          } else {
              bmr = 10.0 * weight + 6.25 * height - 5.0 * Double(selectedAge) - 161.0
          }
          
          // Adjust BMR based on activity level
          switch selectedActivityLevel {
          case "Not active":
              bmr *= 1.0
          case "Lightly active":
              bmr *= 1.375
          case "Moderately active":
              bmr *= 1.55
          case "Very active":
              bmr *= 1.725
          case "Extremely active":
              bmr *= 1.9
          default:
              break
          }
          
          return bmr
      }
    
        

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
