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
    let synonym: String?
    let antonym: String?
    let example: String
    
    var details:[WordDetailType: String?] {
        return [
            .definition: definition,
            .synonym: synonym,
            .antonym: antonym,
            .example: example
        ]
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.word == rhs.word && lhs.partOfSpeech == rhs.partOfSpeech && lhs.definition == rhs.definition && lhs.synonym == rhs.synonym && lhs.antonym == rhs.antonym && lhs.example == rhs.example
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
        definition: NSLocalizedString("Used to refer to various rhythmic or repeated motions, activities, or patterns of sound, or to a falling inflection of the voice", comment: "Definition of cadence"),
        synonym: "rhythm",
        antonym: "stillness",
        example: "For those who are just dabbling in this layered approach to decor for the first time, determining the right cadence might be a trial-and-error exercise."
    ),
    WordData(
        word: "transmogrify",
        partOfSpeech: .verb,
        definition: NSLocalizedString("to change something significantly and often with humorous or jarring effect", comment: "Definition of transmogrify"),
        synonym: "transfigure",
        antonym: nil,
        example: "Cady seduces like a snake, charming his victims into their demise, but can as quickly transmogrify into a deranged beast striking fear into the Bowden family during a torrential storm."
    ),
    WordData(
        word: "mnemonic",
        partOfSpeech: .adjective,
        definition: NSLocalizedString("assisting or intended to assist memory", comment: "Definition of mnemonic"),
        synonym: nil,
        antonym: nil,
        example: "The teaser uses music as both a source of emotional connection and as a mnemonic device."
    ),
    WordData(
        word: "augur",
        partOfSpeech: .verb,
        definition: NSLocalizedString("portend a good or bad outcome", comment: "Definition of augur"),
        synonym: "bode",
        antonym: nil,
        example: "The extended interview augurs well for your acceptance into that law school."
    ),
    WordData(
        word: "avuncular",
        partOfSpeech: .adjective,
        definition: NSLocalizedString("kind or friendly like an uncle", comment: "Definition of avuncular"),
        synonym: nil,
        antonym: nil,
        example: "Now 70 years old, with an avuncular twinkle, Shadinov is one of the dwindling number of Moynaq residents who lived through this transformation."
    ),
    WordData(
        word: "proffer",
        partOfSpeech: .verb,
        definition: NSLocalizedString("hold out (something) to someone for acceptance", comment: "Definition of proffer"),
        synonym: "extend",
        antonym: "take",
        example: "He proffered advice on how best to proceed."
    ),
    WordData(
        word: "opalesce",
        partOfSpeech: .verb,
        definition: NSLocalizedString("to exhibit a play of colors like that of the iridescent gem opal", comment: "Definition of opalesce"),
        synonym: nil,
        antonym: "dullness",
        example: "The room was filled with light and opalescence. Her skin was said to have an exquisite opalescence."
    ),
    WordData(
        word: "osculate",
        partOfSpeech: .verb,
        definition: NSLocalizedString("to kiss", comment: "Definition of osculate"),
        synonym: nil,
        antonym: nil,
        example: "When I was a little girl, my father would osculate me on my forehead before tucking me in for the night."
    ),
]
