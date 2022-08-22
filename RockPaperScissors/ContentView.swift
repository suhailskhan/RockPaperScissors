//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Suhail Khan on 8/20/22.
//

import SwiftUI

struct ContentView: View {
    var possibleMoves = ["🪨", "📄", "✂️"]
    
    @State private var currentChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var question = 0
    @State private var finished = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.98, green: 0.93, blue: 0.13), location: -0.1),
                .init(color: Color(red: 0, green: 0.57, blue: 0.69), location: 1),
            ], center: .topTrailing, startRadius: 100, endRadius: 650)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                
                VStack (spacing: 10) {
                    VStack(spacing: 15) {
                        VStack {
                            Text(possibleMoves[currentChoice])
                                .font(.system(size: 45))
                                .shadow(radius: 2.5)
                                .padding(.vertical, 10)
                            Text(shouldWin ? "Objective: Win" : "Objective: Lose")
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                        }
                    }
                    .frame(width: 200)
                    .padding(.vertical, 20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    VStack(spacing: 15) {
                        ForEach(0..<3) { number in
                            Button {
                                choiceTapped(number)
                            } label: {
                                Text(possibleMoves[number])
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .font(.system(size: 65))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.weight(.bold))
                    .foregroundColor(.black)
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 70)
        }
        .alert("Final Score: \(score)", isPresented: $finished) {
            Button("Restart", action: reset)
        } message: {
            if (score >= 7) {
                Text("Nice job!")
            }
            if (score < 7) {
                Text("Better luck next time!")
            }
        }
    }
    
    func choiceTapped(_ number: Int) {
        question += 1
        
        var won = false
        
        switch number {
        case 0:
            if (currentChoice == 1) {
                won = false
            } else if (currentChoice == 2) {
                won = true
            }
        case 1:
            if (currentChoice == 0) {
                won = true
            } else if (currentChoice == 2) {
                won = false
            }
        case 2:
            if (currentChoice == 0) {
                won = false
            } else if (currentChoice == 1) {
                won = true
            }
        default:
            return
        }
        
        if (number == currentChoice) {
            score += 0
        } else if shouldWin {
            if won {
                score += 1
            } else {
                score -= 1
            }
        } else if !shouldWin {
            if won {
                score -= 1
            } else {
                score += 1
            }
        }
        
        if (question == 10) {
            finished = true
            return
        }
        
        newMove()
    }
    
    func newMove() {
        currentChoice = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func reset() {
        question = 0
        score = 0
        finished = false
        newMove()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
