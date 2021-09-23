//
//  ContentView.swift
//  DogFacts
//
//  Created by Rokas Mikelionis on 2021-09-23.
//

import SwiftUI

struct DogFactsView: View {
    @ObservedObject var viewModel: DogFactsViewModel = DogFactsViewModel()
    
    var body: some View {
        switch viewModel.apiState {
        case .loading:
            ProgressView()
                .frame(maxHeight: .infinity)
        case .success:
            Text(viewModel.fact)
                .padding()
        case .failed:
            Text("Couldn't retrieve data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DogFactsView()
    }
}
