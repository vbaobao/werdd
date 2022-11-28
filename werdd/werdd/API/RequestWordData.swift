//
//  Data.swift
//  werdd
//
//  Created by Virginia Bao on 10/15/22.
//

import Foundation

struct RequestWordData: Codable {
    let word: String
    let results: [RequestWordDetails]
}

struct RequestWordDetails: Codable {
    let partOfSpeech: String
    let definition: String
    let synonyms: [String]?
    let antonyms: [String]?
    let examples: [String]?
}

struct WordData {
    let word: String
    let definition: String
    let partOfSpeech: String
    let synonyms: [String]?
    let antonyms: [String]?
    let examples: [String]?
    var isSelected = false
}
