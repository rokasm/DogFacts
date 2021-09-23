//
//  DogFactsViewModel.swift
//  DogFacts
//
//  Created by Rokas Mikelionis on 2021-09-23.
//

import Foundation
import Combine

class DogFactsViewModel: ObservableObject {
    @Published private(set) var dogFacts: DogFacts?
    private let apiString: String = "https://dog-facts-api.herokuapp.com/api/v1/resources/dogs?number=1"
    private let apiURL: URL
    var dogFactsStorage: [String] = []

    init() {
        apiURL = URL(string: apiString)!
        apiState = .loading
        fetchDogFact()
        dogFactsStorage = UserDefaults.standard.stringArray(forKey: "dogfacts") ?? []
    }
    
    func fetchDogFact() {
        DispatchQueue.global(qos: .default).async {
            if let dogFact = try? Data(contentsOf: self.apiURL) {
                DispatchQueue.main.async {
                    if let jsonData = try? JSONDecoder().decode([[String:String]].self, from: dogFact) {
                        if let fact = jsonData[0]["fact"] {
                            self.dogFacts = DogFacts(fact: fact)
                            self.apiState = .success
                            self.dogFactsStorage.append(fact)
                            UserDefaults.standard.set(self.dogFactsStorage, forKey: "dogfacts")
                        } else {
                            self.apiState = .failed
                        }
                    } else {
                        self.apiState = .failed
                    }
                }
            }
        }
    }
    
    var fact: String {
        dogFacts?.fact ?? ""
    }
    
    var apiState: APIState {
        willSet {
            objectWillChange.send()
        }
    }
}
