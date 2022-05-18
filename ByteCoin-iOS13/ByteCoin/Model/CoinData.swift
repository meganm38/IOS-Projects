//
//  CoinData.swift
//  ByteCoin
//
//  Created by Megan Ma on 2022-05-17.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    let rate: Double
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
