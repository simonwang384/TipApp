//
//  SettingsViewController.swift
//  TipApp
//
//  Created by MacLab on 2/5/19.
//  Copyright © 2019 MacLab. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let defaults = UserDefaults.standard
    
    var tipPercentage = ["1","2","3","4","5","6","7","8","9","10",
                         "11","12","13","14","15","16","17","18","19","20",
                         "21","22","23","24","25","26","27","28","29","30"]
    
    var seperate = ["1","2","3","4","5"]
    
    @IBOutlet weak var tipPickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tipPickerView.delegate = self
        tipPickerView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tipPickerView.selectRow(Int(defaults.string(forKey: TIP_KEY)!)! - 1, inComponent: 0, animated: false)
        tipPickerView.selectRow(Int(defaults.string(forKey: SPLIT_KEY)!)! - 1, inComponent: 1, animated: false)
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveBtn(_ sender: UIButton) {
        let tip = tipPercentage[tipPickerView.selectedRow(inComponent: 0)]
        let split = seperate[tipPickerView.selectedRow(inComponent: 1)]
        defaults.set(tip, forKey: TIP_KEY)
        defaults.set(split, forKey: SPLIT_KEY)
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return tipPercentage.count
        } else {
            return seperate.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return tipPercentage[row]
        } else {
            return seperate[row]
        }
    }
    
    
    
    
    

}
