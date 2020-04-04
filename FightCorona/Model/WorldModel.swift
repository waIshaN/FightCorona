//
//  WorldModel.swift
//  FightCorona
//
//  Created by Wai Shan on 2/4/20.
//  Copyright © 2020 Wai Shan. All rights reserved.
//

import Foundation

struct WorldModel: Decodable{
    let cases: Int?
    let deaths: Int?
    let recovered: Int?
    let updated: Int?
    let active: Int?
    let affectedCountries: Int?
}
