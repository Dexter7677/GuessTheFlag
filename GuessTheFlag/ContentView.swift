//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Deepak Singh on 13/07/20.
//  Copyright © 2020 dexter. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var flags = ["madagascar","mexico","sierra","uk","yemen"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
    @State private var alertTitle = ""
    @State private var score = 0
    @State private var showingScore = false
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue,.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20){
                
                VStack{
                    Text("Select the flag")
                        .foregroundColor(.white)
                    Text("\(self.flags[correctAnswer])")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3){number in
                    Button(action:{
                        self.flagTapped(number)
                    }){
                        Image(self.flags[number])
                            .renderingMode(.original)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
                            .shadow(color:.black , radius: 5.0)
                    }
                }
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(alertTitle), message:Text( "Your score is \(self.score)"), dismissButton: .default(Text("Continue"))
                {
                    continueGame()
                }
            )
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
         alertTitle = "Correct Answer"
            self.score += 1
        }else{
            alertTitle = "Wrong! That’s the flag of \(self.flags[number])"
            self.score -= 1
        }
        
        self.showingScore = true
        
    }
    
    func continueGame(){
        flags.shuffle()
        self.correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 8")
    }
}
