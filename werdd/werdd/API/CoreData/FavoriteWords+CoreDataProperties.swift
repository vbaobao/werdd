//
//  FavoriteWords+CoreDataProperties.swift
//  werdd
//
//  Created by Virginia Bao on 11/27/22.
//
//

import Foundation
import CoreData


extension FavoriteWords {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteWords> {
        return NSFetchRequest<FavoriteWords>(entityName: "FavoriteWords")
    }

    @NSManaged public var word: String?
    @NSManaged public var definition: String?
    @NSManaged public var partOfSpeech: String?
    @NSManaged public var synonyms: [String]?
    @NSManaged public var antonyms: [String]?
    @NSManaged public var examples: [String]?
    @NSManaged public var isSelected: Bool

}

extension FavoriteWords : Identifiable {

}
