//
//  Product.swift
//  Cproject
//
//  Created by jercy on 12/3/23.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let imageUrl: String
    let title: String
    let discount: String
    let originalPrice: Int
    let discountPrice: Int
}
