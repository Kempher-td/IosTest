//
//  Article.swift
//  MyNewsTest
//
//  Created by Victor Mashukevich on 4.02.22.
//

import Foundation
struct Articles: Codable  {
    var source: Source
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
struct Source: Codable {
    var id: String?
    var name: String?
}
