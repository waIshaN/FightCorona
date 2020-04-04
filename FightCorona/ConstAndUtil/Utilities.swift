//
//  Utilities.swift
//  FightCorona
//
//  Created by Wai Shan on 2/4/20.
//  Copyright © 2020 Wai Shan. All rights reserved.
//

import UIKit
import Foundation

struct Utilities {
    
}

// MARK: Alerts
extension Utilities {
    
    static func showInfoAlert(title: String, msg: String, alertButtonTitle: String, action: Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: alertButtonTitle, style: .default) { _ in
            action
        }
        alert.addAction(alertAction)
        return alert
        
    }
    
}

// MARK: InfoNames
extension Utilities {
    
    static func getInfoNameValueForWorldModel(_ row: Int, data: WorldModel) -> String {
        guard let infoType = Constant.InfoNamesType(rawValue: row) else { return Constant.Defaults.notAvailable }
        var infoValue: String = Constant.Defaults.emptyString
        switch infoType {
        case .cases:
            infoValue = String(data.cases ?? 0)
        case .deaths:
            infoValue = String(data.deaths ?? 0)
        case .recovered:
            infoValue = String(data.recovered ?? 0)
        case .updated:
            infoValue = String(data.updated ?? 0)
        case .active:
            infoValue = String(data.active ?? 0)
        case .affectedCountries:
            infoValue = String(data.affectedCountries ?? 0)
        default:
            infoValue = Constant.Defaults.notAvailable
        }
        return infoValue
    }
    
    static func getInfoNameValueForCountryModel(_ row: Int, data: CountryModel) -> String {
        guard let infoType = Constant.InfoNamesType(rawValue: row) else { return Constant.Defaults.notAvailable }
        var infoValue: String = Constant.Defaults.emptyString
        switch infoType {
        case .cases:
            infoValue = String(data.cases ?? 0)
        case .deaths:
            infoValue = String(data.deaths ?? 0)
        case .recovered:
            infoValue = String(data.recovered ?? 0)
        case .updated:
            infoValue = String(data.updated ?? 0)
        case .active:
            infoValue = String(data.active ?? 0)
        case .todayCases:
            infoValue = String(data.todayCases ?? 0)
        case .todayDeaths:
            infoValue = String(data.todayDeaths ?? 0)
        case .critical:
            infoValue = String(data.critical ?? 0)
        case .casesPerOneMillion:
            infoValue = String(data.casesPerOneMillion ?? 0)
        case .deathsPerOneMillion:
            infoValue = String(data.deathsPerOneMillion ?? 0)
        default:
            infoValue = Constant.Defaults.notAvailable
        }
        return infoValue
    }
    
    static func getInfoName(row: Int) -> String {
        let typeName = Constant.InfoNamesType(rawValue: row)?.name
        let nameList = Constant.InfoNameLists.nameOrder.map{ $0 }
        let infoName = nameList.filter { $0.name == typeName }
        return infoName.first.map { $0.rawValue } ?? Constant.Defaults.notAvailable
    }
    
    static func createCardView(_ view: UIView) {
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10.0
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 6.0
        view.layer.shadowOpacity = 0.7
    }

}
