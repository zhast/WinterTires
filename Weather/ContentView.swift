//
//  ContentView.swift
//  Weather
//
//  Created by Steven Zhang on 2024-06-03.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    @StateObject private var weatherViewModel = WeatherViewModel()

    var body: some View {
        ZStack {
            // Set background to be blue gradient, ignoring save areas (dynamic island)
            BackgroundView(isNight: $isNight) // Use binding bool ($) for variables that can change within a function
            
            VStack(spacing: 8) {
                // Add city name. Remember order of modifiers matter because they pass down their views in order
                CityView(cityName: "San Francisco, CA") // Adds a default padding for spacing (so it doesn't hug notch)
                
//                CurrWeatherView(imageName: "cloud.sun.fill", temperature: 19)
                
            


                VStack {
                    if let weatherData = weatherViewModel.weatherData {
                        ForEach(weatherData.days, id: \.datetime) { day in
                            WeatherDayView(dayOfWeek: getDayOfWeek(from: day.datetime),
                                           imageName: "cloud.sun.fill",
                                           temperature: String(format: "%.1f", day.temp))
                        }
                    }
                }
                .onAppear {
                    weatherViewModel.fetchWeatherData()
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
    var temperature: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(dayOfWeek)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(.white)
                
                Text("\(temperature)°")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
        }
        .padding(.horizontal)
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

func getDayOfWeek(from dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date)
    }
    return ""
}
