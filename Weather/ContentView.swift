//
//  ContentView.swift
//  Weather
//
//  Created by Steven Zhang on 2024-06-03.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            // Use the BackgroundView without passing any parameters
            BackgroundView()
            
            VStack {
                
                LargeText(cityName: "Your Car Should Have:")
                
                if let averageTemperature = calculateAverageTemperature() {
                    // Display summer or winter tires based on temperature
                    if let temperatureValue = Double(averageTemperature) {
                        Image(temperatureValue > 7 ? "summer_tires" : "winter_tires")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180, height: 180)
                    }
                    
                    Text("Average Temperature Last Week: \(averageTemperature)°")
                        .font(.headline)
                        .foregroundColor(.white)
                } else {
                    Text("Failed to fetch weather data")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                
                Spacer() // Pushes text to the top
                
                Text("You should change to winter tires when the typical air temperature during your driving times falls to around 45°F (7°C) or lower.")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
                
            }
            .onAppear {
                if let location = locationManager.lastLocation {
                    weatherViewModel.fetchWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                }
            }
        }
    }
    
    func calculateAverageTemperature() -> String? {
        guard let weatherData = weatherViewModel.weatherData else {
            return nil
        }
        
        var totalTemperature = 0.0
        
        for day in weatherData.days {
            totalTemperature += day.temp
        }
        
        let averageTemperature = totalTemperature / Double(weatherData.days.count)
        let formattedTemperature = String(format: "%.1f", averageTemperature)
        
        return formattedTemperature
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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [colorScheme == .dark ? .black : .blue, colorScheme == .dark ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct LargeText: View {
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
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
