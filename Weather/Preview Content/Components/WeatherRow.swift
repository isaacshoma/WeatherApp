//
//  WeatherRow.swift
//  WeatherApp
//
//  Created by Isaac Shoma on 2023-04-01.
// 615391
import SwiftUI

// A custom view for displaying weather data in a row
struct WeatherRow: View {
    // String representing the name of the SF Symbol to use as the icon
    var logo: String
    // Name of the weather data value to display
    var name: String
    // The value of the weather data to display
    var value: String
    
    var body: some View {
        // Horizontal stack containing the icon and weather data
        HStack(spacing: 20) {
            // Use SF Symbol as icon
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                // Add background color to icon
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                // Make the icon circular
                .cornerRadius(50)
            VStack(alignment: .leading, spacing: 8) {
                // Display the name of the weather data
                Text(name)
                    .font(.caption)
                
                // Display the value of the weather data
                Text(value)
                    .bold()
                    .font(.title)
            }
        }
    }
}
// PreviewProvider for the WeatherRow view
struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "8°")
        // Preview the WeatherRow with some dummy data
    }
}
