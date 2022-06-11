//
//  Networking.swift
//  ContactManager
//
//  Created by Oleksandr Revebtsov on 2022-06-11.
//

import Foundation

import UIKit

enum DataError: Error {
    case invalidResponse
    case invalidData
    case decodingError
    case serverError
}

class JSONParser {
    typealias ResultParse<T> = (Result<T, Error>) -> Void
    
    func downloadData<T: Decodable>(of type: T.Type, from url: URL, completion: @escaping ResultParse<T>) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            if 200...299 ~= response.statusCode {
              if let data = data {
                do {
                    let decodedData: T = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(DataError.decodingError))
                }
              } else {
                completion(.failure(DataError.invalidData))
              }
             
            } else {
                completion(.failure(DataError.serverError))
            }
        }.resume()
    }
    
}
