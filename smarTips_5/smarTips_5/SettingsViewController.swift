//
//  SettingsViewController.swift
//  smarTips_5
//
//  Created by user on 12/23/15.
//  Copyright © 2015 Jean. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var setTipControl: UISegmentedControl!
    @IBOutlet weak var setTipStepper: UIStepper!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view did load")
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")

    

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
        

    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
        
        //        NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "saved_time")
        //        NSUserDefaults.standardUserDefaults().setObject(setTipControl.selectedSegmentIndex, forKey: "low_tip")
        //        NSUserDefaults.standardUserDefaults().setObject(setTipControl.selectedSegmentIndex, forKey: "selected_segment")
        //                NSUserDefaults.standardUserDefaults().setObject(setTipControl.selectedSegmentIndex, forKey: "selected_segment")
        
        NSUserDefaults.standardUserDefaults().synchronize()
        saveValues()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
   
    
    @IBAction func onSetTipControl(sender: UISegmentedControl) {
        setStepperValue()
    }
    
    
    @IBAction func onSetTipStepper(sender: UIStepper) {
        let newTipPercentage = String(Int(sender.value)) + "%"
        let currentIndex = setTipControl.selectedSegmentIndex
        
        setTipControl.setTitle(newTipPercentage, forSegmentAtIndex: currentIndex)

    }

    
    

    func setStepperValue() {
        let currentTipPercentage = setTipControl.titleForSegmentAtIndex(setTipControl.selectedSegmentIndex)!
        let endIndex = currentTipPercentage.endIndex.advancedBy(-1)
        
        setTipStepper.value = Double(currentTipPercentage.substringToIndex(endIndex))!
    }
    
    func saveValues() {
        let tip_low_with_symbol = setTipControl.titleForSegmentAtIndex(0)!
        let tip_mid_with_symbol = setTipControl.titleForSegmentAtIndex(1)!
        let tip_high_with_symbol = setTipControl.titleForSegmentAtIndex(2)!
 
        let tip_low = tip_low_with_symbol.substringToIndex(tip_low_with_symbol.endIndex.advancedBy(-1))
        let tip_mid = tip_mid_with_symbol.substringToIndex(tip_mid_with_symbol.endIndex.advancedBy(-1))
        let tip_high = tip_high_with_symbol.substringToIndex(tip_high_with_symbol.endIndex.advancedBy(-1))

        
        NSUserDefaults.standardUserDefaults().setObject(String(tip_low), forKey: "tip_low")
        NSUserDefaults.standardUserDefaults().setObject(String(tip_mid), forKey: "tip_mid")
        NSUserDefaults.standardUserDefaults().setObject(String(tip_high), forKey: "tip_high")
        NSUserDefaults.standardUserDefaults().setObject(setTipControl.selectedSegmentIndex, forKey: "selected_segment")
        
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func refreshTipPercentages(){
//        func animation() {
//            if (billField.text ==  "0") || (billField.text == "") {
//                UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
//                    self.tipPercentageView.transform = CGAffineTransformMakeTranslation(0, 0)
//                    
//                    }, completion: nil)
//                
//            } else {
//                UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
//                    self.tipPercentageView.transform = CGAffineTransformMakeTranslation(0, -115)
//                    }, completion: nil)
//            }
//        }
        
        
        var tipLow = NSUserDefaults.standardUserDefaults().stringForKey("tip_low")
        var tipMid = NSUserDefaults.standardUserDefaults().stringForKey("tip_mid")
        var tipHigh = NSUserDefaults.standardUserDefaults().stringForKey("tip_high")
        
        
        if (tipLow == nil ) { tipLow = "18.0" }
        if (tipMid == nil ) { tipMid = "20.0" }
        if (tipHigh == nil ) { tipHigh = "22.0" }
 
        
        tipLow! += "%"
        tipMid! += "%"
        tipHigh! += "%"
        
        
        setTipControl.setTitle(tipLow, forSegmentAtIndex: 0)
        setTipControl.setTitle(tipMid, forSegmentAtIndex: 1)
        setTipControl.setTitle(tipHigh, forSegmentAtIndex: 2)
        
    }
    
    func selectSegment() {
        var selectedSegment = NSUserDefaults.standardUserDefaults().stringForKey("selected_segment")
        
        if (selectedSegment == nil) { selectedSegment = "0" }
        
        setTipControl.selectedSegmentIndex = Int(selectedSegment!)!
    }
 
    
        // Dispose of any resources that can be recreated.
    }
 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


