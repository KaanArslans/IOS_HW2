//
//  InputVC.swift
//  KaanArslan_HW2
//
//  Created by kaan2 on 18.03.2024.
//

import UIKit
protocol AddControllerDelegate {
    func addControllerDidFinish(controller: InputVC, num1:Double,num2:Double)
}




class InputVC: UIViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var radiusText: UITextField!
    @IBOutlet weak var heighttext: UITextField!
    var delegate: AddControllerDelegate?
    var isShapeSphere:Bool?
    var radius=0.0
    var height=0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        if(isShapeSphere!){
            heighttext.isHidden=true
            heightLabel.isHidden=true
        }
        else{
            heighttext.isHidden=false
            heightLabel.isHidden=false
        }
        radiusText.keyboardType = .decimalPad
               heighttext.keyboardType = .decimalPad         // Sphere
           

        // Do any additional setup after loading the view.
    }
    
    @IBAction func DoneCalculation(_ sender: UIButton) {
        if(isShapeSphere!){
            radius=Double(radiusText.text!)!
            height=1.0
            
        }
        else{
            radius=Double(radiusText.text!)!
            height=Double(heighttext.text!)!
        }
        
        if let tempDelegate = delegate {
            tempDelegate.addControllerDidFinish(controller: self,num1: radius,num2: height)
        }
        
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
