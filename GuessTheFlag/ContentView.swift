//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anton Frolov on 08.02.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var finish = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var answers = 0
    @State private var ansNumber = 0
    
    @State private var countries = ["Эстония", "Франция", "Германия", "Ирландия", "Италия", "Нигерия", "Польша", "Россия", "Испания", "Великобритания", "США"].shuffled()
    


    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var alert = false
    var body: some View {
        
        ZStack{
           // Color.secondary
            LinearGradient(colors: [Color.secondary,Color.primary], startPoint: .top, endPoint: .bottom)
            
            .ignoresSafeArea()
            VStack (spacing: 30){
                VStack{
                    Spacer()
                    Text ("Выберите флаг страны")
                    Text (countries[correctAnswer]).font(.largeTitle.weight(.semibold))
                    Spacer()
                }
                    
                    ForEach  (0..<3) { number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        
                    }
                
                    Spacer()
                    Spacer()
                    VStack{
                        Text("Твой результат: \(score)").foregroundColor(.black)
                            
                            
                    }
                    
                
                    Spacer()
                
                
            }
            
           
            
        }
        
        
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Продолжить", action: askQuestion)
        } message: {
            if scoreTitle == "Верно!" {
                Text ("Твой результат увеличен на единицу (до \(score))")
            } else {
                Text ("Это флаг страны \(countries[ansNumber]). Твой результат уменьшен на единицу (до \(score))")
            }
            
        }
        .alert("Игра окончена!", isPresented: $finish){
            Button("Хорошо", action: restart)
        } message: {
            Text ("Твой результат \(score)")
            
        }
       
    
            
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Верно!"
            score+=1
        }
        else {
            scoreTitle = "Неверно!"
            score-=1
        }
        showingScore = true
        ansNumber = number
        answers+=1
        
        if answers == 10 {
            finish = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restart() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        finish = false
        score = 0
        answers = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
