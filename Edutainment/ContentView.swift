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
    @State private var numberOfQuestionsToAsk = 3
    @State private var numberOfQuestionsAsked = 0
    @State private var score = 0
    
    @State private var startGame = false
    @State private var nextQuestion = false
    @State private var isGameOver = false
    
    @State private var answer = ""
    
    var outcome: Int {
        numberToMultiply * multiplier
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
                    Stepper("\(numberOfQuestionsToAsk)", value: $numberOfQuestionsToAsk, in: 2...20)
                } header: {
                    Text("Choose the amount of questions:")
                }
                
                Button("Start") {
                    numberOfQuestionsAsked = numberOfQuestionsToAsk
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
                .keyboardType(.decimalPad)
            Button("Answer", action: answerCheck)
        } message: {
            Text("\(numberToMultiply) x \(multiplier)?")
        }
        
        .alert("Question", isPresented: $nextQuestion) {
            TextField("Enter the value", text: $answer)
                .keyboardType(.decimalPad)
            Button("Answer", action: answerCheck)
        } message: {
            Text("\(numberToMultiply) x \(multiplier)?")
        }
        
        .alert("Game over!", isPresented: $isGameOver) {
            Button("OK", action: resetGame)
        } message: {
            Text("You scored \(score) out of \(numberOfQuestionsToAsk)!")
        }
    }
    
    func answerCheck() {
        
        if answer == String(outcome) {
            score += 1
            numberOfQuestionsAsked -= 1
        } else {
            score -= 1
            numberOfQuestionsAsked -= 1
        }
        
        if numberOfQuestionsAsked > 0 {
            multiplier = Int.random(in: 2...10)
            answer = ""
            
            if startGame {
                nextQuestion.toggle()
            } else if !startGame {
                startGame.toggle()
            }
        } else {
            isGameOver.toggle()
        }
        
    }
    
    func resetGame() {
        score = 0
        answer = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
