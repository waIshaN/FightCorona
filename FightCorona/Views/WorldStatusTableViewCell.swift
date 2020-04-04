//
//  WorldStatusTableViewCell.swift
//  FightCorona
//
//  Created by Wai Shan on 2/4/20.
//  Copyright © 2020 Wai Shan. All rights reserved.
//

import UIKit

class WorldStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var infoNameLabel: UILabel!
    @IBOutlet weak var infoValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Utilities.createCardView(cardView)
    }
    
    func worldCellConfig(_ data: WorldModel?, row: Int) {
        guard let data = data else { return }
        infoNameLabel.text = Utilities.getInfoName(row: row == 5 ? -1 : row)
        infoValueLabel.text = Utilities.getInfoNameValueForWorldModel(row == 5 ? -1 : row, data: data)
    }
    
    func countryDetailCellConfig(_ data: CountryModel?, row: Int) {
        guard let data = data else { return }
        infoNameLabel.text = Utilities.getInfoName(row: row)
        infoValueLabel.text = Utilities.getInfoNameValueForCountryModel(row, data: data)
    }

}
