//
//  HeadlinesModel.swift
//  News
//
//  Created by Omar Mohamed on 29/12/2023.
//

import Foundation

// MARK: - Headlines
struct Headlines: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let title, description: String?
}
