//
//  Endpoint.swift
//  DogFacts
//
//  Created by Rokas Mikelionis on 2021-10-07.
//
import Foundation

protocol Endpoint {
    var path: String { get }
}

struct DogFactsApi: Endpoint {
    var path: String {
        "https://dog-facts-api.herokuapp.com/api/v1/resources/dogs?number=1"
    }
}
