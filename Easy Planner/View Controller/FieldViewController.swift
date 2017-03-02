//
//  FieldViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/9/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

enum DataType {
    case Currency
    case Text
    case Number
};

class FieldViewController: UIViewController {

    @IBOutlet weak var editText: UITextField!
    @IBOutlet weak var editTextView: UITextView!
    @IBOutlet weak var staticText: UILabel!
    
    let currencyFormat = NumberFormatter()
    
    var data : NSString? {
        
        didSet(newValue) {
            
            if let type = fieldType {
                switch type {
                case .Currency:
                    let format = NumberFormatter()
                    format.numberStyle = .currency
                    let val = data?.integerValue
                    editText?.text = format.string(from: NSNumber(integerLiteral: val!))
                    break;
                case .Text:
                    editText?.text = newValue as String?
                    break;
                case .Number:
                    let format = NumberFormatter()
                    format.numberStyle = .decimal
                    let val = data?.integerValue
                    editText?.text = format.string(from: NSNumber(integerLiteral: val!))
                    break;
                }
            }
            
        }
        
    }
    
    var fieldType: DataType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.editText?.delegate = self
        self.editTextView?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func convertToCurrency(text: String) -> String {
        
        let format = NumberFormatter()
        format.numberStyle = .currency
        //data = format.number(from: editText.text!)?.stringValue as NSString?
        
        if let num = Double(editText.text!) {
            return NSNumber(value: num).stringValue
        }
        
        if let num = format.number(from: editText.text!) {
            return num.stringValue
        }
        
        return format.string(from: NSNumber(value:0.00))!
    }
}


extension FieldViewController: UITextViewDelegate, UITextFieldDelegate {
    
    @objc(textFieldShouldReturn:) func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.returnKeyType == UIReturnKeyType.default) {
            if let next = textField.superview?.viewWithTag(textField.tag+1) as? UITextField {
                next.becomeFirstResponder()
                return false
            }
        }
        textField.resignFirstResponder()
        return false
    }
    
    
    @objc(textView:shouldChangeTextInRange:replacementText:) func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }else {
            return true
        }
        
    }
    
    @objc(textFieldDidEndEditing:) func textFieldDidEndEditing(_ textField: UITextField) {
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        if let type = fieldType {
            switch type {
            case .Currency:
                let format = NumberFormatter()
                format.numberStyle = .currency
                data = convertToCurrency(text: editText.text!) as NSString?
                break;
            case .Text:
                break;
            case .Number:
                let format = NumberFormatter()
                format.numberStyle = .decimal
                data = format.number(from: editText.text!)?.stringValue as NSString?
                break;
            }
        }
        
    }
    
    
}
