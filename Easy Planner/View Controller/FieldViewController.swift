//
//  FieldViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/9/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit

class FieldViewController: UIViewController {

    @IBOutlet weak var editText: UITextField!
    @IBOutlet weak var editTextView: UITextView!
    @IBOutlet weak var staticText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.editText?.delegate = self
        self.editTextView?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    
}
