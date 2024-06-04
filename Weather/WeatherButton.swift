//
//  WeatherButton.swift
//  Weather
//
//  Created by Steven Zhang on 2024-06-03.
//
import SwiftUI


// If a view is going to be used throughout the app, put it in its own file
struct ButtonView: View {
    
    var title: String
    var textColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50) // Typical dimensions for button
            .background(backgroundColor)
            .foregroundColor(textColor)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(10)
    }
}
