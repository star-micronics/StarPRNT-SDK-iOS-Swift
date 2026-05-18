//
//  CommonLabelViewController.swift
//  StarPRNTSDK
//
//  Created by StarMicronics on 2024/08/06.
//  Copyright © 2024 Star Micronics. All rights reserved.
//

import UIKit

class CommonLabelViewController: CommonViewController {
    
    @IBOutlet private weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commentLabel.text = ""
        self.commentLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    func setCommentLabel(text: String, color: UIColor) {
        self.commentLabel.text = text
        self.commentLabel.textColor = color
        self.beginAnimationCommantLabel()
    }
    
    func beginAnimationCommantLabel() {
        self.commentLabel.alpha = 0.0
        
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       options: [.repeat, .autoreverse, .curveEaseIn],
                       animations: {
            self.commentLabel.alpha = 1.0
        })
    }
    
    func endAnimationCommantLabel() {
        self.commentLabel.layer.removeAllAnimations()
    }
    
    func setCommentLabelHidden(_ value: Bool) {
        self.commentLabel.isHidden = value
    }
}
