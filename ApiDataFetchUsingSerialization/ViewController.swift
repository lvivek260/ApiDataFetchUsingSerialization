//
//  ViewController.swift
//  ApiDataFetchUsingSerialization
//
//  Created by Admin on 21/02/23.
//

import UIKit

class ViewController: UIViewController {

    var allJsonData:DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiDataFetch()
    }
    
    private func apiDataFetch(){
        let url = URL(string: "https://dummyjson.com/carts")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request){
            data,response,error in
            if error == nil {
                let jsonObject = try! JSONSerialization.jsonObject(with: data!) as! [String:Any]
                let carts = jsonObject["carts"] as! [[String:Any]]
                let total = jsonObject["total"] as! Int
                let skip = jsonObject["skip"] as! Int
                let limit = jsonObject["limit"] as! Int
                
                var cartsAllData:[Carts] = [Carts]()
                 for i in carts{
                    let id = i["id"] as! Int
                    let products = i["products"] as! [[String:Any]]
                    let total = i["total"] as! Int
                    let discountedTotal = i["discountedTotal"] as! Int
                    let userId = i["userId"] as! Int
                    let totalProducts = i["totalProducts"] as! Int
                    let totalQuantity = i["totalQuantity"] as! Int
                     
                     var productAllData:[Products] = []
                     for j in products{
                         let id = j["id"] as! Int
                         let title = j["title"] as! String
                         let price = j["price"] as! Int
                         let quantity = j["quantity"] as! Int
                         let total = j["total"] as! Int
                         let discountPercentage = j["discountPercentage"] as! Double
                         let discountedPrice = j["discountedPrice"] as! Double
                         
                         let productObject = Products(id: id, title: title, price: price, quantity: quantity, total: total, discountPercentage: discountPercentage, discountedPrice: discountedPrice)
                          productAllData.append(productObject)
                     }
                     let cartsObject = Carts(id: id, products: productAllData, total: total, discountedTotal: discountedTotal, userId: userId, totalProducts: totalProducts, totalQuantity: totalQuantity)
                     cartsAllData.append(cartsObject)
                }
                let dataModelObject = DataModel(carts: cartsAllData, total: total, skip: skip, limit: limit)
                self.allJsonData = dataModelObject
                self.AcessData()
            }
            else{
                print("Please Check Internet")
            }
        }
        dataTask.resume()
    }
    
    private func AcessData(){
        print((allJsonData?.carts[0].products[0].title)!)
    }
}

