//
//  TextFieldTableViewCell.swift
//  Swift SDK
//
//  Created by **** on 2017/**/**.
//  Copyright © 2017年 Star Micronics. All rights reserved.
//

import UIKit

protocol TextViewTableViewCellDelegate {
    func shouldChangeCharactersIn(tableViewCellTag tag: Int, textValue: String, range: NSRange, replacementString string: String) -> Bool
}

class TextViewTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    var delegate: TextViewTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        textField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {

        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textValue = self.textField.text
        
        return self.delegate!.shouldChangeCharactersIn(tableViewCellTag: self.tag, textValue: textValue!, range: range, replacementString: string)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    @IBAction func didEndOnExit(_ sender: UIView) {
        
    }
}
