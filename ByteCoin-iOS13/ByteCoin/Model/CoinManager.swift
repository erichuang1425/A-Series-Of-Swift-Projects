//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager:CoinManager, coinModel:CoinModel)
    func didFailwithError(error:Error)
}
struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "17968EC1-2EB3-460C-B719-EB14728AC5D9"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate:CoinManagerDelegate?
    func getCoinPrice(for currency:String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString:String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data,response,error) in
                if error != nil{
                    self.delegate?.didFailwithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let currency = self.parseJSON(safeData){
                        self.delegate?.didUpdateCurrency(self, coinModel: currency)
                    }
                
                }
                
            }
            task.resume()
        }
    }
    func parseJSON(_ data:Data)->CoinModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            let currencyLabel = decodedData.asset_id_quote
            let coin = CoinModel(currencyLabel: currencyLabel, last: lastPrice)
         
            return coin
        }catch{
            self.delegate?.didFailwithError(error: error)
            return nil
        }
    }
}
