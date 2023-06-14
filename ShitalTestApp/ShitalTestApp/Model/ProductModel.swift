//
//  ProductModel.swift
//  ShitalTestApp
//
//  Created by ShitalJadav on 08/06/23.
//

import UIKit
import Foundation

struct productResponse {
    var products: [ProductModel]

    enum CodingKeys: String, CodingKey {
            case products = "products"
        }
}
 
class ProductModel : NSObject,NSCoding {
    
    var title : String!
    var imageURL : String!
    var price :[pricemodel]!
    var brand : String!
    var ratingCount : String!
    
    required init?(coder: NSCoder) {
        title = coder.decodeObject(forKey: "title") as? String
        imageURL = coder.decodeObject(forKey: "imageURL") as? String
        price = coder.decodeObject(forKey: "price") as? [pricemodel]
        brand = coder.decodeObject(forKey: "brand") as? String
        ratingCount = coder.decodeObject(forKey: "ratingCount") as? String
    }
    
    func encode(with coder: NSCoder) {
        if title != nil{
            coder.encode(title, forKey: "title")
        }
        if imageURL != nil{
            coder.encode(imageURL, forKey: "imageURL")
        }
        if price != nil{
            coder.encode(price, forKey: "price")
        }
        if brand != nil{
            coder.encode(brand, forKey: "brand")
        }
        if ratingCount != nil{
            coder.encode(ratingCount, forKey: "ratingCount")
        }
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if title != nil{
            dictionary["title"] = title
        }
        if imageURL != nil{
            dictionary["imageURL"] = imageURL
        }
        if price != nil{
            var dictionaryElements = [[String:Any]]()
            for priceElement in price {
                dictionaryElements.append(priceElement.toDictionary())
            }
            dictionary["FamilyDetails"] = dictionaryElements
        }
        if brand != nil{
            dictionary["brand"] = brand
        }
        if ratingCount != nil{
            dictionary["ratingCount"] = ratingCount
        }
        return dictionary
    }
    
    init(fromDictionary dictionary: [String:Any]){
        title = dictionary["title"] as? String
        imageURL = dictionary["imageURL"] as? String
        price = [pricemodel]()
        if let pricearr = dictionary["price"] as? [[String:Any]]{
            for dic in pricearr{
                let value = pricemodel(fromDictionary: dic)
                price.append(value)
            }
        }
        brand = dictionary["brand"] as? String
        ratingCount = dictionary["ratingCount"] as? String
    }
    
}

class pricemodel: NSObject,NSCoding {
    
    var value:Double!

    required init?(coder: NSCoder) {
        value = coder.decodeObject(forKey: "value") as? Double
    }
    func encode(with coder: NSCoder) {
        if value != nil{
            coder.encode(value, forKey: "value")
        }
    }
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if value != nil{
            dictionary["value"] = value
        }
        return dictionary
    }
    init(fromDictionary dictionary: [String:Any]){
        value = dictionary["value"] as? Double
    }
    
}

enum NetworkError : Error {
    case notFound
    case timeOut
}
