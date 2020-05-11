//
//  AboutView.swift
//  Bullseye
//
//  Created by Elliot BOUVIER on 5/11/20.
//  Copyright © 2020 Elliot BOUVIER. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let backgroundColor = Color(red: 255.0 / 255.0, green: 214.0/255, blue: 179.0/255.0)
    struct HeadingStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .padding(.vertical, 20)
        }
    }
    struct TextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom, 20)
        }
    }
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯").modifier(HeadingStyle())
                VStack {
                    Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider").modifier(TextStyle())
                    Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.").modifier(TextStyle())
                    Text("Enjoy!")
                }.modifier(TextStyle())
            }
        .background(backgroundColor)
            .navigationBarTitle("About Bullseye")
        }
        .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
