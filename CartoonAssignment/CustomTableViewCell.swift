//
//  CustomTableViewCell.swift
//  CartoonAssignment
//
//  Created by iOS on 21/09/19.
//  Copyright © 2019 in.bitcode. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var companylbl: UILabel!
    @IBOutlet weak var doblbl: UILabel!
    @IBOutlet weak var cimgview: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
