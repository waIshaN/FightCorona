//
//  CountryModel.swift
//  FightCorona
//
//  Created by Wai Shan on 2/4/20.
//  Copyright © 2020 Wai Shan. All rights reserved.
//

import Foundation

struct CountryModel: Decodable {
    let country: String?
    let countryInfo: CountryInfo
    let cases: Int?
    let todayCases: Int?
    let deaths: Int?
    let todayDeaths: Int?
    let recovered: Int?
    let active: Int?
    let critical: Int?
    let casesPerOneMillion: Double?
    let deathsPerOneMillion: Double?
    let updated: Int?
}

struct CountryInfo: Decodable {
        let _id: Int?
        let iso2: String?
        let iso3: String?
        let lat: Double?
        let long: Double?
        let flag: String?
}
