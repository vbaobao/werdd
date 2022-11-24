//
//  FetchWordData.swift
//  werdd
//
//  Created by Virginia Bao on 11/22/22.
//

import Foundation

class WordDataFetcher {
    func fetchWord(_ word: String,
                   completion: @escaping (RequestWordData) -> Void) -> Void {
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
                
                DispatchQueue.main.async {
                    completion(word)
                }
            } catch {
                print("Failed to convert \(error)")
            }
        }.resume()
    }
    
    func fetchRandomWord(completion: @escaping (RequestWordData) -> Void) -> Void {
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
                    completion(word)
                }
            } catch {
                print("Failed to convert \(error)")
            }
        }.resume()
    }
}
