//
//  ContentView.swift
//  GuessFlag_app
//
//  Created by Константин Кириллов on 04.01.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Arg", "Bang", "Brazil",
                                    "Canada", "Germany", "Greece",
                                    "Russia", "Sweden", "Uk", "Usa"].shuffled()
    
    @State private var currentCountry = Int.random(in: 0...2)
    @State private var totalScore = 0
    @State private var isPresenred = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.white, .black]),
                        startPoint: UnitPoint(x: 0, y: 1),
                        endPoint: UnitPoint(x: 1, y: 0)
                    )
                )
                .ignoresSafeArea()
            VStack {
                Text("Выбери флаг:")
                    .font(.title)
                Text("\(countries[currentCountry])")
                    .font(.largeTitle)
                    .bold()
                VStack(spacing: 20) {
                    ForEach(0..<3) { item in
                        Button(action: {
                            if currentCountry == item {
                                self.totalScore += 1
                            } else {
                                self.totalScore -= 1
                            }
                            self.isPresenred = true
                            self.countries = countries.shuffled()
                            self.currentCountry = Int.random(in: 0...2)
                        }) {
                            Image(countries[item])
                                .resizable()
                                .frame(width: 300, height: 150)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 2))
                                .shadow(radius: 4)
                        }
                        .alert(isPresented: $isPresenred) {
                            Alert(title: Text("Total score"), message: Text("Total score is \(totalScore)"), dismissButton: .default(Text("Ok")))
                        }
                    }
                    Text("Total score: \(totalScore)")
                        .font(.largeTitle)
                        .bold()
                }
                Spacer()
            }.foregroundColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
