//
//  DogFactsViewModel.swift
//  DogFacts
//
//  Created by Rokas Mikelionis on 2021-09-23.
//

import Foundation
import Combine

class DogFactsViewModel: ObservableObject {
    @Published private(set) var dogFact: DogFact?
    var fetcher = DogFactFetcher(network: ApiRequest(), storageManager: DogFactsStorageManager())
    
    init() {
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
