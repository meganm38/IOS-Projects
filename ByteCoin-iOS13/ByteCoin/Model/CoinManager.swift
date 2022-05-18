//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    
    func didUpdateRate(_ coinManager: CoinManager, rate: String)
    
    func didFailWithError(_ coinManager: CoinManager, error: Error)
}


struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "AE9518BD-BFF7-4A68-BE08-B1B4ACECD4EE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, url, error in
                if error != nil {
                    delegate?.didFailWithError(self, error: error!)
                    return
                }
                
                
                if let data = data, let rate = parseJSon(from: data) {
                    delegate?.didUpdateRate(self, rate: rate)
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSon(from jsonData: Data) -> String? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: jsonData)

            return decodedData.rateString
        } catch {
            print(error)
            return nil
        }
    }
}
