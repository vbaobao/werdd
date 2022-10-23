//
//  Data.swift
//  werdd
//
//  Created by Virginia Bao on 10/15/22.
//

import Foundation

struct WordData: Equatable {
    let word: String
    let partOfSpeech: PartOfSpeech
    let definition: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.word == rhs.word && lhs.partOfSpeech == rhs.partOfSpeech && lhs.definition == rhs.definition
    }
}

enum PartOfSpeech: String {
    case noun = "noun"
    case verb = "verb"
    case adjective = "adjective"
    
    var localizedString: String {
        NSLocalizedString(self.rawValue, comment: "Part of speech of the word \(self.rawValue)")
    }
}

let data = [
    WordData(
        word: "cadence",
        partOfSpeech: .noun,
        definition: NSLocalizedString("Used to refer to various rhythmic or repeated motions, activities, or patterns of sound, or to a falling inflection of the voice", comment: "Definition of cadence")),
    WordData(
        word: "transmogrify",
        partOfSpeech: .verb,
        definition: NSLocalizedString("to change something significantly and often with humorous or jarring effect", comment: "Definition of transmogrify")
    ),
    WordData(
        word: "mnemonic",
        partOfSpeech: .adjective,
        definition: NSLocalizedString("assisting or intended to assist memory", comment: "Definition of mnemonic")
    ),
    WordData(
        word: "augur",
        partOfSpeech: .verb,
        definition: NSLocalizedString("portend a good or bad outcome", comment: "Definition of augur")
    ),
    WordData(
        word: "avuncular",
        partOfSpeech: .adjective,
        definition: NSLocalizedString("kind or friendly like an uncle", comment: "Definition of avuncular")
    ),
    WordData(
        word: "proffer",
        partOfSpeech: .verb,
        definition: NSLocalizedString("hold out (something) to someone for acceptance", comment: "Definition of proffer")
    ),
    WordData(
        word: "opalesce",
        partOfSpeech: .verb,
        definition: NSLocalizedString("to exhibit a play of colors like that of the iridescent gem opal", comment: "Definition of opalesce")
    ),
    WordData(
        word: "osculate",
        partOfSpeech: .verb,
        definition: NSLocalizedString("to kiss", comment: "Definition of osculate")
    ),
]
