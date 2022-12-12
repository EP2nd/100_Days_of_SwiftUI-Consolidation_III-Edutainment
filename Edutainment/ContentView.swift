//
//  ContentView.swift
//  Edutainment
//
//  Created by Edwin Przeźwiecki Jr. on 12/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberToMultiply = 2
    @State private var multiplier = Int.random(in: 2...10)
    @State private var numberOfQuestions = 3
    
    @State private var score = 0
    
    @State private var startGame = false
    
    @State private var answer = ""
    
    var outcome: Int {
        
        let outcome = numberToMultiply * multiplier
        
        return outcome
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Stepper("\(numberToMultiply)", value: $numberToMultiply, in: 2...10)
                } header: {
                    Text("Choose the number to multiply:")
                }
                
                Section {
                    Stepper("\(numberOfQuestions)", value: $numberOfQuestions, in: 2...20)
                } header: {
                    Text("Choose the amount of questions:")
                }
                
                Button("Start") {
                    startGame.toggle()
                }
            }
            .navigationTitle("Edutainment")
            .toolbar {
                Text("Score: \(score)")
            }
        }
        .alert("Question", isPresented: $startGame) {
            TextField("Enter the value", text: $answer)
            Button("Answer", action: answerCheck)
        } message: {
            Text("\(numberToMultiply) x \(multiplier)?")
        }
    }
    
    func answerCheck() {
        if answer == String(outcome) {
            score += 1
        } else {
            score -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
