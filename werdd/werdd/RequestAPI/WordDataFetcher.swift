//
//  FetchWordData.swift
//  werdd
//
//  Created by Virginia Bao on 11/22/22.
//

import Foundation

class WordDataFetcher {
    func fetchWord(_ word: String,
                   completion: @escaping ([WordData]) -> Void) -> Void {
        guard let wordUrl = URL(string: "\(APIConstants.fetch_word_url)\(word)") else {
            print("Invalid URL")
            return
        }
                
        let headers = [
            APIConstants.header_key: APIConstants.key,
            APIConstants.header_host: APIConstants.host,
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]

        var request = URLRequest(url: wordUrl)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let word = try JSONDecoder().decode(RequestWordData.self, from: data)
                var wordList = [WordData]()
                for result in word.results {
                    wordList.append(WordData(word: word.word,
                                            definition: result.definition,
                                            partOfSpeech: result.partOfSpeech,
                                            synonyms: result.synonyms,
                                            antonyms: result.antonyms,
                                            examples: result.examples))
                }
                
                DispatchQueue.main.async {
                    completion(wordList)
                }
            } catch {
                print("Failed to convert \(error)")
            }
        }.resume()
    }
    
    func fetchRandomWord(completion: @escaping (WordData) -> Void) -> Void {
        guard let wordUrl = URL(string: "\(APIConstants.fetch_random_url)") else {
            print("Invalid URL")
            return
        }
                
        let headers = [
            APIConstants.header_key: APIConstants.key,
            APIConstants.header_host: APIConstants.host,
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]

        var request = URLRequest(url: wordUrl)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let word = try JSONDecoder().decode(RequestWordData.self, from: data)
                DispatchQueue.main.async {
                    let randomIndex = Int.random(in: 0..<word.results.count)
                    let targetWord = word.results[randomIndex]
                    let wordData = WordData(word: word.word,
                                            definition: targetWord.definition,
                                            partOfSpeech: targetWord.partOfSpeech,
                                            synonyms: targetWord.synonyms,
                                            antonyms: targetWord.antonyms,
                                            examples: targetWord.examples)
                    completion(wordData)
                }
            } catch {
                print("Failed to convert \(error)")
            }
        }.resume()
    }
}
