//
//  ViewController.swift
//  Json_Parsing_Decodeable_Proc_Model_Objects
//
//  Created by Daricus Duncan on 10/2/17.
//  Copyright © 2017 DrDunkan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct currencyModel {
        let base: String?
        let date: String?
        let rates: Dictionary<String, Double>?
        
        init(json: [String: Any]){
            
            base = json["base"] as? String ?? ""
            date = json["date"] as? String ?? ""
            rates = json["rates"] as?  [String : Double] ?? ["" : -1.0]
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = "https://api.fixer.io/latest"
        
        guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
//            let dataAsString = String(data: data, encoding: .utf8)
//            
//            print(dataAsString)
            
            do{
                guard let json = try JSONSerialization.jsonObject(with: data , options: .mutableContainers) as? [String: Any] else { return }
                
                //print(json)
                
                let currency = currencyModel(json: json)
                
                print(currency.base as Any)
                print(currency.rates?["USD"] as Any)
                
                
            } catch let jsonErr {
                print("Error serializing json: ", jsonErr)
                
            }
            
        }.resume()
        

        
        
      
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

