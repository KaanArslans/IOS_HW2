import UIKit

class CurrencyVC: UIViewController {
    
    @IBOutlet weak var currency1: UILabel!
    @IBOutlet weak var currency2: UILabel!
    @IBOutlet weak var currencytext1: UITextField!
    @IBOutlet weak var currencytext2: UITextField!
    @IBOutlet weak var mSegment: UISegmentedControl!
    @IBOutlet weak var mImageView: UIImageView!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    let EURtoTL: Double = 36.0
    let USDtoTL: Double = 33.0
    let GBPtoTL: Double = 38.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mImageView.image = UIImage(named: "tl_usd")
        
        
        // Set up decimal pad keyboard type for text fields
        currencytext1.keyboardType = .decimalPad
        currencytext2.keyboardType = .decimalPad
        
        // Set initial currency labels
        currency1.text = "TL"
        currency2.text = "USD"
        
        // Set placeholder text
        currencytext1.placeholder = "Enter amount in TL"
        currencytext2.placeholder = "Converted amount"
        
        // Add gesture recognizer to image view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        mImageView.addGestureRecognizer(tapGesture)
        mImageView.isUserInteractionEnabled = true
    }
    
    @IBAction func SegmentChnged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mImageView.image = UIImage(named: "tl_usd")
            currency1.text="TL"
            currency2.text="USD"
            
        case 1:
            mImageView.image = UIImage(named: "tl_euro")
            currency1.text="TL"
            currency2.text="euro"
            
        case 2:
            mImageView.image = UIImage(named: "tl_gbp")
            currency1.text="TL"
            currency2.text="gbp"
        default:
            break
        }
        convertCurrency()
    }
    
    @objc func imageViewTapped() {
        // Cycle through currency options
        switch mSegment.selectedSegmentIndex {
        case 0:
            mSegment.selectedSegmentIndex = 1
            SegmentChnged(mSegment)
        case 1:
            mSegment.selectedSegmentIndex = 2
            SegmentChnged(mSegment)
        case 2:
            mSegment.selectedSegmentIndex = 0
            SegmentChnged(mSegment)
        default:
            break
        }
       
    }
    
    @IBAction func currencyTextField(_ sender: UITextField) {
        convertCurrency() //for did change
    }
    
    
    
    @IBAction func editingDidbegin(_ sender: UITextField) {
        currencytext1.text = ""
        currencytext2.text = ""
    }
    
    func convertCurrency() {
        guard let inputText = currencytext1.text, let amount = Double(inputText) else {
            currencytext2.text = ""
            return
        }
        
        var convertedAmount: Double = 0.0
        
        switch mSegment.selectedSegmentIndex {
        case 0: // TL to USD
            convertedAmount = amount / USDtoTL
        case 1: // TL to EUR
            convertedAmount = amount / EURtoTL
        case 2: // TL to GBP
            convertedAmount = amount / GBPtoTL
        default:
            break
        }
        
   
        currencytext2.text = String(format: "%.2f", convertedAmount)
    }
    }
    
    

