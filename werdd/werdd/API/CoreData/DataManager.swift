//
//  DataManager.swift
//  werdd
//
//  Created by Virginia Bao on 11/27/22.
//

import UIKit
import CoreData

class CoreDataManager {
    static let managedObjectContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    /// create
    static func createFavoriteWord(word: String,
                                   partOfSpeech: String,
                                   definition: String,
                                   synonyms: [String]?,
                                   antonyms: [String]?,
                                   examples: [String]?) {
        let favoriteWord = FavoriteWords(context: managedObjectContext)
        favoriteWord.word = word
        favoriteWord.partOfSpeech = partOfSpeech
        favoriteWord.definition = definition
        favoriteWord.synonyms = synonyms
        favoriteWord.antonyms = antonyms
        favoriteWord.examples = examples
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed create with error: \(error)")
        }
    }
    
    /// read
    static func fetchFavoriteWords(completion: ([FavoriteWords]?) -> Void) {
        do {
            let favoriteWords = try managedObjectContext.fetch(FavoriteWords.fetchRequest())
            completion(favoriteWords)
        } catch {
            print("Failed fetch with error: \(error)")
            completion(nil)
        }
    }
    
    static func fetchFavoriteWord(_ word: String, completion: (FavoriteWords?) -> Void) {
        let fetchRequest = NSFetchRequest<FavoriteWords>(entityName: "FavoriteWords")
        fetchRequest.predicate = NSPredicate(format: "word == %@", word)
        
        do {
            let favoriteWord = try managedObjectContext.fetch(fetchRequest)
            completion(favoriteWord.first)
        } catch {
            print("Failed fetch with error: \(error)")
            completion(nil)
        }
    }
    
    /// update
    static func updateFavoriteWord(favoriteWord: FavoriteWords,
                                   word: String,
                                   partOfSpeech: String,
                                   definition: String,
                                   synonyms: [String]?,
                                   antonyms: [String]?,
                                   examples: [String]?) {
        favoriteWord.word = word
        favoriteWord.partOfSpeech = partOfSpeech
        favoriteWord.definition = definition
        favoriteWord.synonyms = synonyms
        favoriteWord.antonyms = antonyms
        favoriteWord.examples = examples
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed fetch with error: \(error)")
        }
    }
    
    /// delete
    static func deleteFavoriteWord(favoriteWord: FavoriteWords) {
        managedObjectContext.delete(favoriteWord)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed fetch with error: \(error)")
        }
    }
}
