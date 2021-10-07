//
//  DogFactsViewModel.swift
//  DogFacts
//
//  Created by Rokas Mikelionis on 2021-09-23.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class DogFactsViewModel: ObservableObject {
    @Published private(set) var dogFact: DogFact?

    var fetcher: DogFactFetcher
    
    init() {
        let container = Container()

        container.register(ApiRequest.self) { _ in
          return ApiRequest()
        }
        
        container.register(DogFactsStorageManager.self) { _ in
          return DogFactsStorageManager()
        }
        
        container.register(DogFactFetcher.self) { resolver in
            let network = resolver.resolve(ApiRequest.self)!
            let storage = resolver.resolve(DogFactsStorageManager.self)!
            return DogFactFetcher(network: network, storageManager: storage)
        }
        fetcher = container.resolve(DogFactFetcher.self)!
        apiState = .loading
        fetchDogFact()
    }
    
    func fetchDogFact() {
        fetcher.fetch { response in
            DispatchQueue.main.async {
                guard let response = response else { return }
                self.dogFact = response
                self.apiState = .success
            }
        }
    }
    
    var fact: String {
        dogFact?.fact ?? ""
    }
    
    var apiState: APIState {
        willSet {
            objectWillChange.send()
        }
    }
}
