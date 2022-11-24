//
//  Data.swift
//  werdd
//
//  Created by Virginia Bao on 10/15/22.
//

import Foundation

struct RequestWordData: Codable {
    let word: String
    let results: [WordData]
}

struct WordData: Codable {
    let partOfSpeech: String?
    let definition: String?
    let synonyms: [String]?
    let antonyms: [String]?
    let examples: [String]?
}
