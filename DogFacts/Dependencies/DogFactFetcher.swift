//
//  FetchDogFact.swift
//  DogFacts
//
//  Created by Rokas Mikelionis on 2021-10-07.
//

import Foundation

protocol Fetcher {
    func fetch(response: @escaping (DogFact?) -> Void)
}

struct DogFactFetcher: Fetcher {
    let network: Network
    let storageManager: StorageManager
    init(network: Network, storageManager: StorageManager) {
        self.network = network
        self.storageManager = storageManager
    }
    
    func fetch(response: @escaping (DogFact?) -> Void) {
        DispatchQueue.global(qos: .default).async {
            network.request(from: DogFactsApi()) { data, error in
                if let error = error {
                    print("Error received requesting Dog Facts")
                }
                guard let dataSource = data, let dogFact = try? JSONDecoder().decode([DogFact].self, from: dataSource) else { return }
                response(dogFact[0])
                storageManager.storeInUserDefaults(fact: dogFact[0])
            }
        }
    }
}
