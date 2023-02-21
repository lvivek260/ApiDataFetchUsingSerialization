//
//  DataModel.swift
//  ApiDataFetchUsingSerialization
//
//  Created by Admin on 21/02/23.
//

import Foundation
struct DataModel{
    let carts:[Carts]
    let total:Int
    let skip:Int
    let limit:Int
}

struct Carts{
    let id:Int
    let products:[Products]
    let total:Int
    let discountedTotal:Int
    let userId:Int
    let totalProducts:Int
    let totalQuantity:Int
}

struct Products{
    let id:Int
    let title:String
    let price:Int
    let quantity:Int
    let total:Int
    let discountPercentage:Double
    let discountedPrice:Double
}
