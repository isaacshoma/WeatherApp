//
//  WelcomeView.swift
//  WeatherApp
//  Created by Isaac Shoma
// 615391
import SwiftUI
import CoreLocationUI
struct WelcomeView: View {
    // Environment object to access location manager
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                // App title
                Text("Welcome to the Weather App")
                    .bold().font(.title)
                
                // Instructions for user
                Text("Please share your current location to get the weather in your area")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .padding()
            
            // Button to request user's location
            LocationButton(.shareCurrentLocation) {
                // Triggers location request
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        // Sets the view to take up entire screen
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
// Preview of the welcome view
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
