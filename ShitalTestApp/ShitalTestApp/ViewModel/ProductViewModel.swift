//
//  ProductViewModel.swift
//  ShitalTestApp
//
//  Created by ShitalJadav on 08/06/23.
//


import UIKit
import Foundation

class ProductViewModel: NSObject {
    var arrProductDetails:[ProductModel] = [ProductModel]()
    
    func fetchProductAPICall(completion: @escaping( _ ifResult: Bool) -> Void) {
        let url = "https://run.mocky.io/v3/2f06b453-8375-43cf-861a-06e95a951328"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        let header = [
            "Content-Type" : "application/json"
        ]
        
        request.allHTTPHeaderFields = header
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print(response)
            }
            guard data != nil else {
                print("data is nil")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]
                        let posts = json?["products"] as? [[String: Any]] ?? []
                        print(posts)
                
                for dict in posts{
                    let obj = try ProductModel(fromDictionary: dict)
                    self.arrProductDetails.append(obj)
                }
                completion(true)
            }catch{
                print(error)
                completion(false)
            }
            
        }.resume()
    }
    
}
