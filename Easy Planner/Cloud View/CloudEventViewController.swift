//
//  CloudEventDetailViewController.swift
//  Easy Planner
//
//  Created by Marcos Tirao on 3/31/17.
//  Copyright © 2017 Marcos Tirao. All rights reserved.
//

import UIKit

class CloudEventViewController: UIViewController {
    
    let fontSize : CGFloat = 25
    let labelHeight = 30
    
    let nameLabel = UILabel()
    
    private let activityIndicator: ActivityIndicator = ActivityIndicator(frame: CGRect.zero)
    private let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        //let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(CloudEventViewController.saveAction))
        
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        nameLabel.textAlignment = .left
        self.view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(35)
            make.leading.equalTo(8)
            make.trailing.equalTo(8)
            make.top.equalTo(72)
        }
        
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        self.view.addSubview(line)
        line.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(1)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8))
            make.top.equalTo(nameLabel.snp.bottom)
        }
        
        let confirmationLabel = SwitchFieldView(frame: CGRect.zero, label: "Require Confirmation")
        self.view.addSubview(confirmationLabel)
        confirmationLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(70)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.equalTo(line.snp.bottom).offset(16)
        }
        
        let sendLabel = SwitchFieldView(frame: CGRect.zero, label: "Send Notification")
        self.view.addSubview(sendLabel)
        sendLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(70)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.equalTo(confirmationLabel.snp.bottom).offset(16)
        }
        
        let menuLabel = SwitchFieldView(frame: CGRect.zero, label: "Menu Suggestion")
        self.view.addSubview(menuLabel)
        menuLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(70)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.equalTo(sendLabel.snp.bottom).offset(16)
        }
        
        
        saveButton.layer.backgroundColor = Theme.barTint.cgColor
        saveButton.layer.cornerRadius = 20
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitle("Save", for: .highlighted)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        saveButton.addTarget(self, action: #selector(CloudEventViewController.saveAction), for: .touchUpInside)
        self.view.addSubview(saveButton)
        saveButton.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(40)
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.bottom.equalTo(self.view.snp.bottom).inset(UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
        }
        
        self.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.equalTo(self.view).inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
            make.top.equalTo(menuLabel.snp.bottom).offset(16)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.view.layoutSubviews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @objc func saveAction() {
        let cloudEvent = CloudEvent()
        
        activityIndicator.startAnimating()
        activityIndicator.label.text = "Uploading..."
        
        cloudEvent.saveToCloud(progress: self.activityIndicator.label) {[unowned self] in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.label.text = "Event uploaded"
            }
        }
        
    }

}
