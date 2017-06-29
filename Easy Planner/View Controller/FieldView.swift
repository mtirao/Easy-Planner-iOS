//
//  FieldViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 9/9/16.
//  Copyright © 2016 Marcos Tirao. All rights reserved.
//

import UIKit
import SnapKit

enum DataType {
    case currency
    case text
    case number
};

class FieldView: UIView {
    
    private let editText : UITextField
    private let staticText: UILabel
    private let fieldType : DataType
    private let currencyFormat = NumberFormatter()
    
    var data : String? {
        set(newValue) {
            
            switch fieldType {
            case .currency:
                self.editText.text = convertToCurrency(text: editText.text!)
                break;
            case .text:
                editText.text = newValue as String?
                break;
            case .number:
                self.editText.text = convertToNumber(text: editText.text!).stringValue
                break;
            }
        }
        
        get {
            var text = ""
            switch fieldType {
            case .currency:
                text = convertFromCurrency(text: editText.text!)
                break;
            case .text:
                text = editText.text!
                break;
            case .number:
                text = convertToNumber(text: editText.text!).stringValue
                break;
            }
            
            return text
        }
    }
    
    var dataAsNumber : NSNumber {
        get {
            
            var number = NSNumber(value: 0)
            switch fieldType {
            case .currency:
                number = convertToNumber(text: convertFromCurrency(text: editText.text!))
                break;
            case .text:
                break;
            case .number:
                number = convertToNumber(text: editText.text!)
                break;
            }
            
            return number
            
        }
    }
    
    var deleteWhenStartEditting = false
    
    var placeHolder : String? {
        set {
            self.editText.placeholder = newValue
        }
        
        get {
            return self.editText.placeholder
        }
    }
    
    
    init(frame: CGRect, type: DataType, label: String) {
        
        self.fieldType = type
        
        editText = UITextField()
        staticText = UILabel();
        
        self.editText.font = UIFont.systemFont(ofSize: 14)
        self.staticText.font = UIFont.boldSystemFont(ofSize: 17)
        
        
        super.init(frame: frame)
        
        staticText.text = label
        
        if self.fieldType == .currency || self.fieldType == .number {
            self.editText.keyboardType = .decimalPad
        }
        
        self.addSubview(staticText)
        staticText.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(21)
            make.width.equalTo(100)
            make.leading.equalTo(self)
            make.top.equalTo(0)
        }
        
        self.addSubview(editText)
        editText.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(17)
            make.leading.equalTo(staticText)
            make.trailing.equalTo(0)
            make.top.equalTo(staticText.snp.bottom)
        }
        
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        self.addSubview(line)
        line.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(1)
            make.leading.equalTo(staticText)
            make.trailing.equalTo(0)
            make.top.equalTo(editText.snp.bottom).offset(4)
        }
        
        self.editText.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.fieldType = .text
        
        editText = UITextField()
        staticText = UILabel();
        
        super.init(coder: aDecoder)
    }
    
    func convertToNumber(text: String) -> NSNumber {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        return format.number(from:text) ?? NSNumber(value: 0)
    }
    
    func convertToCurrency(text: String) -> String {
        
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        if format.number(from: editText.text!) == nil {
            let number = convertToNumber(text: text)
            return format.string(from: number) ?? "0.00"
        }
        
        return text
    }
    
    func convertFromCurrency(text: String) -> String {
        
        let format = NumberFormatter()
        format.numberStyle = .currency
        return format.number(from: text)?.stringValue ?? ""
        
    }
}


extension FieldView: UITextFieldDelegate {
    
    @objc(textFieldShouldReturn:) func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.editText.resignFirstResponder()
        
        return false
    }
    
    @objc(textFieldDidEndEditing:) func textFieldDidEndEditing(_ textField: UITextField) {
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        switch fieldType {
        case .currency:
            self.editText.text = convertToCurrency(text: editText.text!)
            break;
        case .text:
            break;
        case .number:
            self.editText.text = convertToNumber(text: editText.text!).stringValue
            break;
        }
    }
    
    @objc(textFieldDidBeginEditing:) func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.deleteWhenStartEditting {
            self.editText.text = ""
        }
    }
    
    
}
