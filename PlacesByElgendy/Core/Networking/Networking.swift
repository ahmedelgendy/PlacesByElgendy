//
//  Networking.swift
//  PlacesByElgendy
//
//  Created by Elgendy on 3.01.2020.
//  Copyright © 2020 Ahmed Elgendy. All rights reserved.
//

import Foundation

public protocol NetworkingProtocol {
    func execute<T: Decodable>(_ requestProvider: RequestProviding, completion: @escaping (Result<T, Error>) -> Void)
}

public struct Networking: NetworkingProtocol {
    public func execute<T: Decodable>(_ requestProvider: RequestProviding, completion: @escaping (Result<T, Error>) -> Void) {
        
        let urlRequest = requestProvider.urlRequest
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    preconditionFailure("No Errors, but no data also!")
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                print("Before decoding: \n", String(data: data, encoding: .utf8))
                let decodedObject = try decoder.decode(T.self, from: data)
//                print("After decoding: \n", decodedObject)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

