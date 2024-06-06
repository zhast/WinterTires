import SwiftUI

struct WeatherData: Codable {
    let queryCost: Int
    let latitude: Double
    let longitude: Double
    let resolvedAddress: String
    let address: String
    let timezone: String
    let tzoffset: Double
    let days: [DailyWeather]
}

struct DailyWeather: Codable {
    let datetime: String
    let tempmax: Double
    let tempmin: Double
    let temp: Double
    let icon: String
    let source: String
}

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData?
    
    func fetchWeatherData(latitude: Double, longitude: Double) {
        guard let apiKey = ProcessInfo.processInfo.environment["API_KEY"] else {
            print("API key not found")
            return
        }        
        
        let urlString = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(latitude),\(longitude)/last7days?unitGroup=metric&elements=datetime,tempmax,tempmin,temp,icon&include=days&key=\(apiKey)&contentType=json"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    self.weatherData = weatherData
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
