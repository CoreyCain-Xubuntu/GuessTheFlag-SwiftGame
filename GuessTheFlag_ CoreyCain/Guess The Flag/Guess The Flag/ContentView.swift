import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var tries = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US", "Monaco", "Egypt", "Brazil"].shuffled()
    @State private var score = 0
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.7), location: 0.3),
                .init(color: Color(red: 0.8, green: 0.15, blue: 0.2), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
           
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Spacer()
                
                VStack(spacing: 15) {
                    
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                            .foregroundColor(.black)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                                .scaledToFit()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Current Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Text("Tries Left: \(8 - tries)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if tries < 8 {
                Button("Continue", action: askQuestion)
            } else {
                Button("Try Again? Your final score was \(score)", action: resetGame)
            }
        }
    }

    //  This was my attempt at turning the .alert into a ternary that swift hated. Might have to rearrange the reference to askQuestion and resetGame.
    // tries < 8 ? .alert(scoreTitle, isPresented: $showingScore)() : Button("Try Again? Your final score was \(score)", action: resetGame)()
    
    // I turned the code commented out below into ternary operators instead of if-else statements.
    
    // I did get help for the following ternary.
    //score += number == correctAnswer ? 1 : 0
    //I figured it wasnt part of the assignment so no penalty for assistance.
    
   
    //   func flagTapped(_ number: Int) {

    //   tries += 1
    //                    scoreTitle = "Correct! You know your flags!"
    //
    //            } else {
    //
    //                    scoreTitle = "Wrong. That's the flag of \(countries[number])."
    
    //        if number == correctAnswer {
    //            score += 1
    //        } else {
    //        }
   
    //                if tries > 8 {
    //                    resetGame()
    //    }

    func flagTapped(_ number: Int) {
        
        tries += 1
        
        scoreTitle = number == correctAnswer ? "Correct! You know your flags!" : "Wrong. That's the flag of \(countries[number])."
       
        score += number == correctAnswer ? 1 : 0
        
        showingScore = true
        
        tries > 8 ? resetGame() : ()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
    func resetGame() {
        askQuestion()
        tries = 0
        score = 0
        
    }
        
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
