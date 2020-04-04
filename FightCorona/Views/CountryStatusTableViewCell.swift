//
//  IndividualStatusTableViewCell.swift
//  FightCorona
//
//  Created by Wai Shan on 2/4/20.
//  Copyright © 2020 Wai Shan. All rights reserved.
//

import UIKit
import Kingfisher

class CountryStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var casesCardView: UIView!
    @IBOutlet weak var deathsCardView: UIView!
    @IBOutlet weak var recoveredCardView: UIView!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var casesValueLabel: UILabel!
    @IBOutlet weak var deathsValueLabel: UILabel!
    @IBOutlet weak var recoveredValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Utilities.createCardView(casesCardView)
        Utilities.createCardView(deathsCardView)
        Utilities.createCardView(recoveredCardView)
    }

    func config(_ data: CountryModel?) {
        guard let data = data else { return }
        casesValueLabel.text = String(data.cases ?? 0)
        deathsValueLabel.text = String(data.deaths ?? 0)
        recoveredValueLabel.text = String(data.recovered ?? 0)
        countryNameLabel.text = data.country
        guard let flagURL = URL(string: data.countryInfo.flag ?? Constant.Defaults.emptyString) else { return }
        countryImageView.kf.setImage(with: flagURL)
    }
    
}
