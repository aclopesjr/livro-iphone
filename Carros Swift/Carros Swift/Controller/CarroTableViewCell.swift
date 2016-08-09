//
//  CarroTableViewCell.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/5/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import UIKit

class CarroTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet var lNome : UILabel!
    @IBOutlet var lDescricao : UILabel!
    @IBOutlet var ivImage : DownloadImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
