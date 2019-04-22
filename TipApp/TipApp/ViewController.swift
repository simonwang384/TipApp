//
//  ViewController.swift
//  TipApp
//
//  Created by MacLab on 1/29/19.
//  Copyright © 2019 MacLab. All rights reserved.
//

import UIKit

let TIP_KEY = "TIPDEFAULTKEY"
let SPLIT_KEY = "SPLITDEFAULTKEY"


class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    var tipDefault = "15"
    var splitDefault = "1"
    
    var amount = 0.00
    let fmt = NumberFormatter()
    var splitAmount = 1
    var tip = 0.0
    var totalAmount = 0.0
    var tipEach = 0.0
    var totalEach = 0.0
    
    @IBOutlet weak var amountText: UITextField!
    @IBOutlet weak var tipOutlet: UILabel!
    
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var totalEachText: UITextField!
    @IBOutlet weak var tipEachText: UITextField!
    @IBOutlet weak var totalAmountText: UITextField!
    @IBOutlet weak var totalTipText: UITextField!
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fmt.numberStyle = .currency
        fmt.locale = Locale(identifier: "en_US")
        amountText.text = String(amount)
        update()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDefault()
        update()
    }

    @IBAction func calculateBtn(_ sender: UIButton) {
        update()
        amountText.resignFirstResponder()
    }
    
    func performCalculation() {
        if let d = Double(amountText.text!) {
            amount = d
            tip = amount * Double(Int(sliderOutlet.value))/100
            totalAmount = amount + tip
            tipEach = tip/Double(splitAmount)
            totalEach = totalAmount/Double(splitAmount)
        } else {
            amount = 0.0
        }
    }
    
    func update() {
        performCalculation()
        totalAmountText.text = fmt.string(for: totalAmount)
        totalTipText.text = fmt.string(for: tip)
        tipEachText.text = fmt.string(for: tipEach)
        totalEachText.text = fmt.string(for: totalEach)
    }
    
    
    @IBAction func tipSlider(_ sender: UISlider) {
        tipOutlet.text = String(Int(sender.value)) + "%"
        update()
    }
    
    @IBAction func tipSegment(_ sender: UISegmentedControl) {
        // splitAmount = sender.selectedSegmentIndex+1
        if let x = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            splitAmount = Int(x)!
        } else {
            splitAmount = 1
        }
        update()
    }
    
    @IBAction func resetBtn(_ sender: UIButton) {
        amount = 0.00
        sliderOutlet.value = 15
        tipOutlet.text = String(Int(sliderOutlet.value)) + "%"
        amountText.text = String(amount)
        segmentOutlet.selectedSegmentIndex = 0
        
        if let x = segmentOutlet.titleForSegment(at: 0) {
            splitAmount = Int(x)!
        } else {
            splitAmount = 1
        }
        update()
    }
    
    func getDefault() {
        if let tipPick = defaults.string(forKey: TIP_KEY),
           let splitPick = defaults.string(forKey: SPLIT_KEY) {
            segmentOutlet.selectedSegmentIndex = Int(splitPick)! - 1
            if let x = segmentOutlet.titleForSegment(at: segmentOutlet.selectedSegmentIndex) {
                splitAmount = Int(x)!
            } else {
                splitAmount = 1
            }
            sliderOutlet.value = Float(tipPick)!
            tipOutlet.text = String(Int(sliderOutlet.value)) + "%"
        } else {
            tipOutlet.text = tipDefault + "%"
            segmentOutlet.selectedSegmentIndex = Int(splitDefault)! - 1
            if let x = segmentOutlet.titleForSegment(at: segmentOutlet.selectedSegmentIndex) {
                splitAmount = Int(x)!
            } else {
                splitAmount = 1
            }
            defaults.set(tipDefault, forKey: TIP_KEY)
            defaults.set(splitDefault, forKey: SPLIT_KEY)
        }
    }
    
    
    
}

