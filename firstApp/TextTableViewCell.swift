//
//  TextTableViewCell.swift
//  firstApp
//
//  Created by Leandro Gartner on 11/9/17.
//  Copyright © 2017 Leandro Gartner. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    @IBOutlet weak var textNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateText(text: String) {
        self.textNameLabel.text = text
    }

}
