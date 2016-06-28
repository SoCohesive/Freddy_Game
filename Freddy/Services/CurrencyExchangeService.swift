//
//  CurrencyExchangeService.swift
//  Freddy
//
//  Created by Sonam Dhingra on 12/7/15.
//  Copyright © 2015 Sonam Dhingra. All rights reserved.
//

import UIKit
import Alamofire


/*
The response struct is used to return data from API services and data fetchers
*/

public struct Response : CustomStringConvertible {
    var data:AnyObject?
    var error:NSError?
    public var description: String {
        return  "Data: \(self.data), Error:  \(self.error)"
    }
}

class CurrencyExchangeService: NSObject {
    
    static let sharedService = CurrencyExchangeService()
    let baseURL = "https://currency-api.appspot.com/api/USD/"
    let callBackResponseFormat = "json"
   
    enum CurrencySymbols: String {
        case GBP, EUR, JPY, BRL
    }
    
    typealias CompletionClosure = (response: Response) ->()
    typealias ExchangeInfo = [CurrencySymbols: Double]
    typealias ExchangeInfoCompletionClosure =  (error: NSError?, exchangeData: ExchangeInfo?) ->()

    
    func fetchExchangeRates(completionClosure: ExchangeInfoCompletionClosure) {
        let exchangeSymbols = [CurrencySymbols.GBP, .EUR, .JPY, .BRL]
        var exchangeInfo = ExchangeInfo()
        var completionCount = 0
        
        exchangeSymbols.forEach { (symbol) in
            GET(constructedUrl(symbol.rawValue), params: nil, requestResponseClosure: { (response) in
                if response.error != nil {
                    completionClosure(error: response.error, exchangeData: nil)
                } else if let safeData = response.data as? [String: AnyObject],
                    let rate = safeData["rate"] as? NSNumber {
                    exchangeInfo[symbol] = Double(rate)
                    completionCount += 1
                    
                    // Pass data back when all exchange rates have been fetched
                    if completionCount == exchangeSymbols.count {
                        completionClosure(error:nil, exchangeData: exchangeInfo)
                    }
                }
            })
        }
    }
    
    func constructedUrl(symbol:String) -> String {
        return "\(baseURL)\(symbol).\(callBackResponseFormat)?amount=1.00"
    }
    

    //MARK: AlamoFire Wrapper function
    
    func GET(url:String, params:[String:AnyObject]?, requestResponseClosure: CompletionClosure?) {        
        Alamofire.request(.GET, "\(url)", parameters: params, encoding:.URL, headers: nil).responseJSON {(request, response, result) -> Void in
            var response = Response()
            response.data = result.value
            response.error = result.error as? NSError
            if (requestResponseClosure != nil) {
                requestResponseClosure!(response: response)
            }
        }
    }
}