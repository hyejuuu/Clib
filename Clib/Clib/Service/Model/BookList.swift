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
    let totalResults: Int
    let startIndex: Int
    let itemsPerPage: Int
    let query: String
    let searchCategoryId: Int
    let searchCategoryName: String
    let item: [Book]
}

// MARK: - Item
struct Book: Codable {
    let title: String
    let link: String
    let author: String
    let pubDate: String
    let categoryName: String
    let description: String
    let isbn: String
    let isbn13: String
    let itemId: Int
    let priceStandard: Int
    let mallType: MallType
    let cover: String
    let publisher: String
    let salesPoint: Int
    let customerReviewRank: Int
    let fullDescription: String?
    let bestRank: Int?
    let seriesInfo: SeriesInfo?
    let story: String?
    let subInfo: SubInfo?
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

// MARK: - SubInfo
struct SubInfo: Codable {
    let paperBookList: [PaperBookList]?
    let toc: String?
    let story: String?
}

// MARK: - PaperBookList
struct PaperBookList: Codable {
    let itemId: Int
    let isbn: String
    let priceSales: Int
    let link: String
}
