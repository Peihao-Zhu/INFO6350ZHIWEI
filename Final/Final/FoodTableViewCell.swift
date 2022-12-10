//
//  FoodTableViewCell.swift
//  Final
//
//  Created by 竺培豪 on 12/9/22.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFood: UILabel!
    @IBOutlet weak var imgFood: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
