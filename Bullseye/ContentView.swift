//
//  ContentView.swift
//  Bullseye
//
//  Created by Elliot BOUVIER on 5/9/20.
//  Copyright © 2020 Elliot BOUVIER. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var score = 0
    @State var round = 1
    @State var randomNumber = Int.random(in: 1...100)
    var buttonColor = Color(red: 0.0 / 255.0, green: 51.0/255.0, blue: 102.0/255.0)
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content.foregroundColor(Color.white)
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
                .modifier(ShadowStyle())
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content.foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
                .modifier(ShadowStyle())
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content.foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content.foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content.shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                Text("\(randomNumber)").modifier(ValueStyle())
            }
            Spacer()
            // Slider row
            HStack{
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            Spacer()
            // Button row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit Me !"/*@END_MENU_TOKEN@*/)
            }
            .alert(isPresented: $alertIsVisible) {() ->
                Alert in
                return Alert(title: Text(alertTitle()),
                             message: Text(
                                "The slider value is \(sliderValueRounded()).\n" +
                                "You scored \(pointsForCurrentRound(roundedValue: sliderValueRounded())) points this round."),
                             dismissButton: .default(Text("Awesome")) {
                                self.score += self.pointsForCurrentRound(roundedValue: self.sliderValueRounded())
                                self.round += 1
                                self.generateRandomNumber()
                    })
            }.background(Image("Button")).modifier(ButtonLargeTextStyle())
            Spacer()
            // Score row
            HStack {
                Button(action: {
                    self.startOver()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonSmallTextStyle())
                        
                    }
                }.background(Image("Button"))
                
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                    
                }.background(Image("Button"))
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"))
        .accentColor(buttonColor)
        .navigationBarTitle("Bullseye")
    }
    
    private func getDifference(roundedValue: Int) -> Int {
        return abs(randomNumber - roundedValue)
    }
    
    func sliderValueRounded() -> Int{
        return Int(sliderValue.rounded())
    }
    
    func pointsForCurrentRound(roundedValue: Int) -> Int {
        return 100 - getDifference(roundedValue: roundedValue)
    }
    
    func startOver() {
        round = 1
        score = 0
        generateRandomNumber()
    }
    
    func alertTitle() -> String {
        let difference = getDifference(roundedValue: sliderValueRounded())
        if difference == 0 {
            return "Perfect !"
        } else if difference < 5 {
            return "You almost had it!"
        } else if difference <= 10 {
            return "Not bad."
        } else {
            return "Not even close."
        }
    }
    
    func generateRandomNumber() {
        self.randomNumber = Int.random(in: 1...100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
