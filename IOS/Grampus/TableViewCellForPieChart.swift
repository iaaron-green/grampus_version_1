//
//  TableViewCellForPieChart.swift
//  Grampus
//
//  Created by MacBook Pro on 5/27/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

class TableViewCellForPieChart: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
