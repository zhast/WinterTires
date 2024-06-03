//
//  ContentView.swift
//  Weather
//
//  Created by Steven Zhang on 2024-06-03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Set background to be blue gradient, ignoring save areas (dynamic island)
            LinearGradient(colors: [.blue, Color("lightBlue")],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 8) {
                // Add city name. Remember order of modifiers matter because they pass down their views in order
                Text("San Francisco, CA")
                    .font(.system(size: 32, 
                                  weight: .medium,
                                  design: .default))
                    .foregroundColor(.white)
                    .padding() // Adds a default padding for spacing (so it doesn't hug notch)
                VStack {
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit) // Keeps aspect ratio
                        .frame(width: 180, height: 180)
                    
                    Text("19°c")
                        .font(.system(size: 70, weight: .medium))
                        .foregroundColor(.white)
                    

                }
                .padding(.bottom, 40)
                
                HStack(spacing: 20) {
                    WeatherDayView(dayOfWeek: "MON", imageName: "cloud.sun.fill", temperature: 18)
                    WeatherDayView(dayOfWeek: "TUES", imageName: "sun.max.fill", temperature: 22)
                    WeatherDayView(dayOfWeek: "WEDS", imageName: "wind.snow", temperature: 16)
                    WeatherDayView(dayOfWeek: "THURS", imageName: "sunset.fill", temperature: 19)
                    WeatherDayView(dayOfWeek: "FRI", imageName: "snow", temperature: 11)


                }
                    
                Spacer() // Pushes text to the top
                
                Button {
                    
                    // What the button does
                    print("Tapped")
                } label: {
                    // What the button looks like
                    Text("Change Day Time")
                        .frame(width: 280, height: 50) // Typical dimensions for button
                        .background(Color.white)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .cornerRadius(10)
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
