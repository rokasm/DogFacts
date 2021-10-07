//
//  ApiRequest.swift
//  DogFacts
//
//  Created by Rokas Mikelionis on 2021-10-07.
//

import Foundation

protocol Network {
    typealias CompletionHandler = (Data?, Swift.Error?) -> Void
    
    func request(from: Endpoint, completion: @escaping CompletionHandler) 
}

struct ApiRequest: Network {
    func request(from: Endpoint, completion: @escaping CompletionHandler) {
        guard let url = URL(string: from.path) else { return }
        let request = createRequest(from: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createRequest(from url: URL) -> URLRequest {
        URLRequest(url: url)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask {
        URLSession.shared.dataTask(with: request) { data, httpResponse, error in
            completion(data, error)
        }
    }
}
