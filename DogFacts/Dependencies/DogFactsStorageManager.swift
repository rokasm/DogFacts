//
//  DogFactsStorageManager.swift
//  DogFacts
//
//  Created by Rokas Mikelionis on 2021-10-07.
//

import Foundation

protocol StorageManager {
    func storeInUserDefaults(fact: DogFact?)
}

struct DogFactsStorageManager: StorageManager {
    func storeInUserDefaults(fact: DogFact?) {
        var dogFactsStorage = UserDefaults.standard.stringArray(forKey: "dogfacts") ?? []

        if let forStorage = fact {
            dogFactsStorage.append(forStorage.fact)
            UserDefaults.standard.set(dogFactsStorage, forKey: "dogfacts")
        }
    }
}
