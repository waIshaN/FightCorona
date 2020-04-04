//
//  Constants.swift
//  FightCorona
//
//  Created by Wai Shan on 2/4/20.
//  Copyright © 2020 Wai Shan. All rights reserved.
//

import Foundation

struct Constant {
    
}

extension Constant {
    
    struct Defaults {
        static let emptyString = ""
        static let notAvailable = "Not available"
    }
    
    struct CellIdentifier {
        static let worldCell = "worldStatusCell"
        static let countryCell = "countryStatusCell"
    }
    
    struct StoryboardIdentifier {
        static let mainStroryboard = "Main"
        static let mainView = "MainView"
    }
    
    struct PageTitle {
        static let home = "Home"
    }
    
    struct ImageName {
        static let defaultImage = "default-image"
        static let loading = "loading.gif"
    }
    
}

// MARK: InfoNames
extension Constant {
    enum InfoNames: String {
        case affectedCountries = "Affected Countries",
            cases = "Cases",
            deaths = "Deaths",
            recovered = "Recovered",
            updated = "Updated",
            active = "Active",
            todayCases = "TodayCases",
            todayDeaths = "TodayDeaths",
            critical = "Critical",
            casesPerOneMillion = "Cases Per One Million",
            deathsPerOneMillion = "Deaths Per One Million"
        
        var name: String { return String(describing: self) }
    }

    enum InfoNamesType: Int {
        case affectedCountries = -1,
            cases = 0,
            deaths = 1,
            recovered = 2,
            updated = 3,
            active = 4,
            todayCases = 5,
            todayDeaths = 6,
            critical = 7,
            casesPerOneMillion = 8,
            deathsPerOneMillion = 9

        var name: String { return String(describing: self) }
    }

    struct InfoNameLists {
        static let nameOrder = [InfoNames.affectedCountries,
                                InfoNames.cases,
                                InfoNames.deaths,
                                InfoNames.recovered,
                                InfoNames.updated,
                                InfoNames.active,
                                InfoNames.todayCases,
                                InfoNames.todayDeaths,
                                InfoNames.critical,
                                InfoNames.casesPerOneMillion,
                                InfoNames.deathsPerOneMillion]

    }

}
