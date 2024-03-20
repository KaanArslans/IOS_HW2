//
//  CalculationVC.swift
//  KaanArslan_HW2
//
//  Created by kaan2 on 18.03.2024.
//

import UIKit

class CalculationVC: UIViewController,AddControllerDelegate{
    var shapeArray = ["Sphere", "Cone", "Cylinder"]
    var selectedShape = 0
    var radius:Double=0.0
    var height:Double=0.0
    
    func addControllerDidFinish(controller: InputVC, num1:Double,num2:Double){
       radius=num1
       height=num2
       //print(radius)
       //print(height)
        
   
      
        
        // Pops the top view controller from the navigation stack and updates the display
        controller.navigationController?.popViewController(animated: true)
        displayResults(r: radius,h: height)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            let vc = segue.destination as! InputVC
            vc.delegate = self
            if(selectedShape==0){
                vc.isShapeSphere=true
            }
            else{
                vc.isShapeSphere=false
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mPickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mPickerView.dataSource = self
        mPickerView.delegate = self
        mImageView.image = UIImage(named: shapeArray[0].lowercased())
        // Do any additional setup after loading the view.
    }
    
    func displayResults(r: Double, h: Double) {
        if selectedShape == 0 {
            let sa = sphereSurfaceArea(r:r)
            let v = sphereVolume(r:r)
            let output = String(format: "Sphere Surface Area = %0.2f and Volume = %0.2f", sa, v)
            displayAlert(header: "Result", msg: output)
        }
        else if selectedShape == 1 {
            let sa = coneSurfaceArea(r: r, h: h)
            let v = coneVolume(r: r, h: h)
            let output = String(format: "Cone Surface Area = %0.2f and Volume = %0.2f", sa, v)
            displayAlert(header: "Result", msg: output)
        }
        else {
            let sa = cylinderSurfaceArea(r: r, h: h)
            let v = cylinderVolume(r: r, h: h)
            let output = String(format: "Cylinder Surface Area = %0.2f and Volume = %0.2f", sa, v)
            displayAlert(header: "Result", msg: output)
        }
    }
    
    func sphereSurfaceArea(r: Double) -> Double {
        return ( 4.0 * .pi * pow(r,2.0) )
    }
    
    func sphereVolume(r: Double) -> Double {
        return ( 4.0/3.0 * .pi * pow(r,3.0) )
    }
    
    func coneSurfaceArea(r: Double, h: Double) -> Double {
        return ( .pi * r * ( r + sqrt(pow(r,2.0) + pow(h,2.0)) ) )
    }
    
    func coneVolume(r: Double, h: Double) -> Double {
        return ( 1.0/3.0 * .pi * pow(r,2.0) * h )
    }
    
    func cylinderSurfaceArea(r: Double, h: Double) -> Double {
        return ( 2 * .pi * r * (h + r) )
    }
    
    func cylinderVolume(r: Double, h: Double) -> Double {
        return ( .pi * pow(r,2.0) * h )
    }
    
    func displayAlert(header: String, msg: String) {
        // Creating an Alert and display the result
        let mAlert = UIAlertController(title: header, message: msg, preferredStyle: UIAlertController.Style.alert)
        // Event Handler for the button
        mAlert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        // Displaying the Alert
        self.present(mAlert, animated: true, completion: nil)
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

extension CalculationVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return shapeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return shapeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedShape = row
        mImageView.image = UIImage(named: shapeArray[row].lowercased())
        
    }
}

