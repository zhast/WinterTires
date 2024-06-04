//
//  ContentView.swift
//  Weather
//
//  Created by Steven Zhang on 2024-06-03.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            // Set background to be blue gradient, ignoring save areas (dynamic island)
            BackgroundView(isNight: $isNight) // Use binding bool ($) for variables that can change within a function
            
            VStack(spacing: 8) {
                // Add city name. Remember order of modifiers matter because they pass down their views in order
                CityView(cityName: "San Francisco, CA") // Adds a default padding for spacing (so it doesn't hug notch)
                
                CurrWeatherView(imageName: "cloud.sun.fill", temperature: 19)
                
                HStack(spacing: 20) {
                    WeatherDayView(dayOfWeek: "MON", imageName: "cloud.sun.fill", temperature: 18)
                    WeatherDayView(dayOfWeek: "TUES", imageName: "sun.max.fill", temperature: 22)
                    WeatherDayView(dayOfWeek: "WEDS", imageName: "wind.snow", temperature: 16)
                    WeatherDayView(dayOfWeek: "THURS", imageName: "sunset.fill", temperature: 19)
                    WeatherDayView(dayOfWeek: "FRI", imageName: "snow", temperature: 11)


                }
                    
                Spacer() // Pushes text to the top
                
                Button {
                    
                    // Toggles between true and false for isNight when pressed
                    isNight.toggle()
                } label: {
                    // What the button looks like
                    ButtonView(title: "Night Mode", textColor: .blue, backgroundColor: .white)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

// Right click "Extract subview" turns views into function when the nesting gets too crazy
struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16,
                              weight: .medium,
                              design: .default))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .renderingMode(.original) // Keeps its colours
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    
    // Parameters
    @Binding var isNight: Bool
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
}

struct CityView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32,
                          weight: .medium,
                          design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct CurrWeatherView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit) // Keeps aspect ratio
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°c")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
            
            
        }
        .padding(.bottom, 40)
    }
}
