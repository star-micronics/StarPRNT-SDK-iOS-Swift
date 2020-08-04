//
//  SwitchTableViewCell.swift
//  Swift SDK
//
//  Created by Yuji on 2016/**/**.
//  Copyright © 2016年 Star Micronics. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate {
    func tableView(_ tableView: UITableView, valueChangedStateSwitch on: Bool, indexPath: IndexPath)
}

class SwitchTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var stateSwitch: UISwitch!
    
    var delegate: SwitchTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
//  @IBAction func valueChangedStateSwitch(var sender: UIView) {
    @IBAction func valueChangedStateSwitch  (_ sender: UIView) {
        var sender = sender
        
        while sender.isKind(of: UITableView.self) == false {
            sender = sender.superview!
        }
        
        let indexPath: IndexPath = (sender as! UITableView).indexPath(for: self)!
        
        self.delegate?.tableView(sender as! UITableView, valueChangedStateSwitch: self.stateSwitch.isOn, indexPath: indexPath)
    }
}
