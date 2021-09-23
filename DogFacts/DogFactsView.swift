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
        ZStack {
            Rectangle().fill(
                LinearGradient(gradient: Gradient(
                                colors: [Color("Background1"), Color("Background2")]),
                               startPoint: .topTrailing,
                               endPoint: .bottomLeading))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                switch viewModel.apiState {
                case .loading:
                    ProgressView()
                        .frame(maxHeight: .infinity)
                case .success:
                    Text(viewModel.fact)
                        .font(.system(size: 27, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .shadow(color: Color.black.opacity(0.25), radius: 0.1, x: -1 , y: 1)
                        .padding(15)
                        .multilineTextAlignment(.center)
                case .failed:
                    Text("Couldn't retrieve data")
                }
                Spacer()
                Button(action: {
                        viewModel.fetchDogFact()
                }) {
                    Text("Another one!")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(Color.white.opacity(0.25))
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DogFactsView()
    }
}
