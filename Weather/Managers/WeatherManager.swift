//
//  WeatherManager.swift
//  Weather
//
//  Created by Isaac Shoma on 2023-04-01.
// 615391
import Foundation
import CoreLocation

class WeatherManger {
    // A function that gets current weather data asynchronously using OpenWeather API
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        // Creating a URL using given latitude and longitude to get weather data
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\("270c010c2af4f08753ee3140ecb4b3d5")&units=metric")
                
        else {
            fatalError("Missing URL")
        }
        
        // Creating a URL request using the above URL
        let urlRequest = URLRequest(url: url)
        // Getting the data and response object using the above URL request
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        // Checking if the HTTP status code is 200, else throwing an error
        guard (response as? HTTPURLResponse)?.statusCode == 200
                
        else {
            fatalError("Error fetching weather data")
        }
        
        // Decoding the received JSON data into a ResponseBody object
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

// Model of the response body we get from calling the OpenWeather API
// Properties of the response body
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    var sys: SysResponse
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
    struct SysResponse: Decodable {
        var sunset: Double
        var sunrise: Double
    }
}
// Extension of MainResponse structure to provide computed properties for better readability of data
extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
