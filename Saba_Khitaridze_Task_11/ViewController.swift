//
//  ViewController.swift
//  Saba_Khitaridze_Task_11
//
//  Created by Saba Khitaridze on 30.06.22.
//

import UIKit

/*
 შექმენით აპლიკაცია, რომელსაც ექნება:
 1. სამი ცალი ლეიბლი,რენდომ რიცხვების მნიშვნელობით
 2.სლაიდერი, რომელიც განსაზღვრავს ლეიბლებზე გამოსახული რენდომ რიცხვების რეინჯს
 3. ტექსტფილდი, სადაც მომხმარებელი შეიყვანს სამ მნიშვნელობას: “maximum”, “average”, “sum” (მაგ.: maximum -ის შეყვანის შემთხვევაში, ამ რიცხვებიდან მაქსიმუმი აიღოს, თქვენ განსაზღვრეთ edge case-ები)
 4. მეოთხე ლეიბლი, სადაც აჩვენებთ წინა პუნქტის შედეგს
 */

class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var firstNumLabel: UILabel!
    @IBOutlet weak var secondNumLabel: UILabel!
    @IBOutlet weak var thirdNumLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    //4
    @IBOutlet weak var resultLabel: UILabel!
    
    //MARK: - Vars
    var range = 0 {
        didSet {
            //1
            firstNumLabel.text = String(Int.random(in: 0...range))
            secondNumLabel.text = String(Int.random(in: 0...range))
            thirdNumLabel.text = String(Int.random(in: 0...range))
            labelNums.removeAll()
        }
    }
    
    var labelNums: [Int?] = []
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
    
    //MARK: - IBAction
    
    //2
    @IBAction func rangeSlider(_ sender: UISlider) {
        range = Int(sender.value)
        labelNums = [Int(firstNumLabel.text!),
                     Int(secondNumLabel.text!),
                     Int(thirdNumLabel.text!) ]
    }
}

//MARK: - Extensions

extension ViewController: UITextFieldDelegate {
    
    //3
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.text {
        case "maximum":
            resultLabel.text = getMax()
        case "average":
            resultLabel.text = "\(labelNums.average)"
        case "sum":
            resultLabel.text = "\(labelNums.sum)"
        default:
            resultLabel.text = textField.text != "" ? "Error" : ""
        }
        return true
    }
    
    //maximum
    func getMax() -> String {
        //prevent crash if numbers are not shown/randomized yet
        guard labelNums.count != 0 else { return "Error, numbers are not randomized yet" }
        let sorted = labelNums.sorted(by: {$0! < $1! })
        let last = labelNums.sorted(by: {$0! < $1! }).last!!
        let beforeLast = sorted[sorted.count-2]
        
        return sorted.last == beforeLast ? "There are more than one maximum value which is \(last)" : "\(last)"
    }
}


extension Array {
    //sum
    var sum: Int {
        self.map { $0 as! Int }.reduce(0, +)
    }
    
    //average
    var average: Double {
        (Double(self.sum) / Double(self.count) * 10).rounded() / 10
    }
}
