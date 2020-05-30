//
//  List.swift
//  Clib
//
//  Created by 이혜주 on 2020/05/24.
//  Copyright © 2020 leehyeju. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct BookList: Codable {
    let version: String
    let logo: String
    let title: String
    let link: String
    let pubDate: String
    let totalResults, startIndex, itemsPerPage: Int
    let query: String
    let searchCategoryId: Int
    let searchCategoryName: String
    let item: [Book]
}

// MARK: - Item
struct Book: Codable {
    let title: String
    let link: String
    let author, pubDate, description, isbn: String
    let itemId, priceStandard: Int
    let mallType: MallType
    let cover: String
    let publisher: String
    let salesPoint: Int
    let customerReviewRank: Int
    let bestRank: Int?
    let seriesInfo: SeriesInfo?
}

enum MallType: String, Codable {
    case book = "BOOK"
}

// MARK: - SeriesInfo
struct SeriesInfo: Codable {
    let seriesId: Int
    let seriesLink: String
    let seriesName: String
}
