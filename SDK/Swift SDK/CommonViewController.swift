//
//  CommonViewController.swift
//  Swift SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {
    @IBOutlet weak var blindView: UIView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var blind: Bool {
        get {
            return self.navigationItem.hidesBackButton
        }
        
        set(blind) {
            if blind == true {
                self.navigationItem.hidesBackButton = true
                
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                
                self.blindView            .isHidden = false
                self.activityIndicatorView.isHidden = false
                
                self.activityIndicatorView.startAnimating()
                
                RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))     // Update View
            }
            else {
                self.activityIndicatorView.stopAnimating()
                
                self.blindView            .isHidden = true
                self.activityIndicatorView.isHidden = true
                
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                
                self.navigationItem.hidesBackButton = false
                
//                RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))     // Update View(No need)
            }
        }
    }
    
    func appendRefreshButton(_ action: Selector) {
        let item: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: action)
        
        self.navigationItem.rightBarButtonItem = item
    }
    
    func showSimpleAlert(title: String?,
                         message: String?,
                         buttonTitle: String?,
                         buttonStyle: UIAlertAction.Style,
                         completion: ((UIAlertController) -> Void)? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let action = UIAlertAction(title: buttonTitle, style: buttonStyle, handler: nil)
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.async {
            completion?(alertController)
        }
    }
    
    func showAlert(title: String, buttonTitles: [String], handler: ((Int) -> Void)?) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        for i: Int in 0..<buttonTitles.count {
            alert.addAction(UIAlertAction(title: buttonTitles[i], style: .default, handler: { _ in
                DispatchQueue.main.async {
                    handler?(i + 1)
                }
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
