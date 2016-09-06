//
//  ViewController.swift
//  smarTips_5
//
//  Created by user on 12/20/15.
//  Copyright © 2015 Jean. All rights reserved.
//

import UIKit

class ViewController: UIViewController
    {

    @IBOutlet weak var smarTitle: UILabel!
    @IBOutlet weak var tipTiltle: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var tipPercentageView: UIView!
    @IBOutlet weak var splitOptionsView: UIView!
    @IBOutlet weak var totalByTwoLabel: UILabel!

    @IBOutlet weak var totalByThreeLabel: UILabel!
    
    @IBOutlet weak var totalByFourLabel: UILabel!
    
    @IBOutlet weak var totalByFiveLabel: UILabel!
    
    @IBOutlet weak var totalBySixLabel: UILabel!
    
    @IBOutlet weak var totalBySevenLabel: UILabel!
    
    var tipPercentages = [0.18, 0.20, 0.22]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
//        smarTitle.hidden = false
//        tipTiltle.hidden = false
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        totalByTwoLabel.text = "$0.00"
        totalByThreeLabel.text = "$0.00"
        totalByFourLabel.text = "$0.00"
        totalByFiveLabel.text = "$0.00"
        totalBySixLabel.text = "$0.00"
         totalBySevenLabel.text = "$0.00"
        
        
        billField.becomeFirstResponder()
        billField.placeholder = currencyFormatter.currencySymbol
        
        refreshTipPercentages()
        selectSegment()
        calculate()
        
        

        
        
        let now = NSDate()
        let before = NSUserDefaults.standardUserDefaults().objectForKey("saved_time") as? NSDate
        
        if (before != nil && now.timeIntervalSinceDate(before!) < 600){
            billField.text = NSUserDefaults.standardUserDefaults().stringForKey("$saved_amt")
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
               refreshTipPercentages()

        print("refreshed tips")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        
        NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "saved_time")
        NSUserDefaults.standardUserDefaults().setObject(billField.text, forKey: "saved_amt")
        NSUserDefaults.standardUserDefaults().setObject(tipControl.selectedSegmentIndex, forKey: "selected_segment")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    func animation() {
        if (billField.text ==  "0") || (billField.text == "") {
            UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                self.tipPercentageView.transform = CGAffineTransformMakeTranslation(0, 0)
                self.splitOptionsView.transform = CGAffineTransformMakeTranslation(0, 0)
              
                }, completion: nil)
            
        } else {
            UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                self.tipPercentageView.transform = CGAffineTransformMakeTranslation(0, -50)
                self.splitOptionsView.transform = CGAffineTransformMakeTranslation(0, -50)
                }, completion: nil)
        }
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        animation()
        
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)!
        totalLabel.text = currencyFormatter.stringFromNumber(total)!
        totalByTwoLabel.text = currencyFormatter.stringFromNumber(total/2)!
        totalByThreeLabel.text = currencyFormatter.stringFromNumber(total/3)!
        totalByFourLabel.text = currencyFormatter.stringFromNumber(total/4)!
        totalByFiveLabel.text = currencyFormatter.stringFromNumber(total/5)!
        totalBySixLabel.text = currencyFormatter.stringFromNumber(total/6)!
        totalBySevenLabel.text = currencyFormatter.stringFromNumber(total/7)!
        
    
        
        
    }
    
    func animateOnTap() {
        if (billField.text >= "1") {
            UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                self.tipPercentageView.transform = CGAffineTransformMakeTranslation(0,-170)
                self.splitOptionsView.transform = CGAffineTransformMakeTranslation(0,-170)
                
                }, completion: nil)
            
        } else {
            UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                self.tipPercentageView.transform = CGAffineTransformMakeTranslation(0, 0)
                 self.splitOptionsView.transform = CGAffineTransformMakeTranslation(0, 0)
                }, completion: nil)
        }
    }

    

    @IBAction func onSwipeDown(sender: AnyObject) {
        
        
        if (billField.text >= "1") {
            UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                
                self.tipPercentageView.transform = CGAffineTransformMakeTranslation(0, 150)
                self.splitOptionsView.transform = CGAffineTransformMakeTranslation(0, 150)
                
                }, completion: nil)


    }
    }
    
    @IBAction func onTap(sender: AnyObject)
    {view.endEditing(true)
//        
        animateOnTap()
//        smarTitle.hidden = true
//        tipTiltle.hidden = true
        
        
        
    }
    
    
    func calculate() {
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
 
        
 
        tipLabel.text = currencyFormatter.stringFromNumber(tip)!
        totalLabel.text = currencyFormatter.stringFromNumber(total)!
        totalByTwoLabel.text = currencyFormatter.stringFromNumber(total/2)!
        totalByThreeLabel.text = currencyFormatter.stringFromNumber(total/3)!
        totalByFourLabel.text = currencyFormatter.stringFromNumber(total/4)!
        totalByFiveLabel.text = currencyFormatter.stringFromNumber(total/5)!
        totalBySixLabel.text = currencyFormatter.stringFromNumber(total/6)!
        totalBySevenLabel.text = currencyFormatter.stringFromNumber(total/7)!
    }
    
    func selectSegment() {
        var selectedSegment = NSUserDefaults.standardUserDefaults().stringForKey("selected_segment")
        
        if (selectedSegment == nil) { selectedSegment = "0" }
        
        tipControl.selectedSegmentIndex = Int(selectedSegment!)!
    }
    
    
    
    func refreshTipPercentages(){
        var tipLow = NSUserDefaults.standardUserDefaults().stringForKey("tip_low")
        var tipMid = NSUserDefaults.standardUserDefaults().stringForKey("tip_mid")
        var tipHigh = NSUserDefaults.standardUserDefaults().stringForKey("tip_high")

        
        if (tipLow == nil ) { tipLow = "18.0" }
        if (tipMid == nil ) { tipMid = "20.0" }
        if (tipHigh == nil ) { tipHigh = "22.0" }
        
        
        tipPercentages[0] = NSString(string: tipLow!).doubleValue / 100.0
        tipPercentages[1] = NSString(string: tipMid!).doubleValue / 100.0
        tipPercentages[2] = NSString(string: tipHigh!).doubleValue / 100.0
        
        tipLow! += "%"
        tipMid! += "%"
        tipHigh! += "%"

        
        tipControl.setTitle(tipLow, forSegmentAtIndex: 0)
        tipControl.setTitle(tipMid, forSegmentAtIndex: 1)
        tipControl.setTitle(tipHigh, forSegmentAtIndex: 2)
        
    }

}

