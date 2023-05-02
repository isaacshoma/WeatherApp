//
//  ContentView.swift
//  Weather
//
//  Created by Isaac Shoma on 2023-04-01.
//

import SwiftUI

struct ContentView: View {
    
    // Creates an instance of the LocationManager class as a state object.
    // The state object allows the location manager to persist between view updates.
    @StateObject var locationManager = LocationManager()
    
    // Creates an instance of the WeatherManager class, which is responsible for fetching weather data from an API.
    var weatherManager = WeatherManger()
    
    // Creates a state variable named weather of type ResponseBody,
    // which represents the weather data fetched from the API.
    // The optional type indicates that the variable can be nil.
    @State var weather: ResponseBody?
    
    // Creates a state variable named backgroundColor that is initialized with a specific color.
    // This color will be used as the background color of the app.
    @State var backgroundColor = Color(hue: 0.656, saturation: 0.787, brightness: 0.354)

    var body: some View {
        // Defines the body of the ContentView struct, which is the main view hierarchy of the app.
        VStack {
            if let location = locationManager.location {
                // Checks if the location manager has a valid location object.
                // The if-let statement safely unwraps the optional value and assigns it to a constant named location.
                if let weather = weather {
                    // Checks if the weather data has been fetched.
                    WeatherView(weather: weather)
                }
                else {
                    // If the weather data is nil, this else statement will execute.
                    LoadingView(backgroundColor: backgroundColor)
                        .task {
                            // Executes an asynchronous task to fetch the weather data from the API.
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude,
                                                                                     longitude: location.longitude)

                            } catch {
                                print("Error getting weather: \(error)")
                            }
                    }
                }
            } else {
                if locationManager.isLoading {
                    // If the location manager is still loading
                    LoadingView(backgroundColor: backgroundColor)
                } else {
                    // If the location manager has finished loading, show the welcome view.
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        // Sets the background color of the app.
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        
        // Sets the preferred color scheme of the app to dark.
        .preferredColorScheme(.dark)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//import SwiftUI
//
//struct ContentView: View {
//
//    @StateObject var locationManager = LocationManager()
//    var weatherManager = WeatherManger()
//    @State var weather: ResponseBody?
//    @State var backgroundColor = Color(hue: 0.656, saturation: 0.787, brightness: 0.354)
//
//    var body: some View {
//        VStack {
//            if let location = locationManager.location {
//                if let weather = weather {
//                    WeatherView(weather: weather)
//                }
//                else {
//                    LoadingView(backgroundColor: backgroundColor)
//                        .task {
//                            do {
//                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude,
//                                                                                     longitude: location.longitude)
//
//                            } catch {
//                                print("Error getting weather: \(error)")
//
//                        }
//                    }
//            }
//
//            } else {
//                if locationManager.isLoading {
//                    LoadingView(backgroundColor: backgroundColor)
//
//                } else {
//                    WelcomeView()
//                        .environmentObject(locationManager)
//
//                }
//            }
//
//        }
//        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
//        .preferredColorScheme(.dark)
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
