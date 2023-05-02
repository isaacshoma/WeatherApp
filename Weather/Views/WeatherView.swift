//
//  WeatherView.swift
//  Weather
//
//  Created by Isaac Shoma on 2023-04-01.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    @State private var backgroundColor: Color = Color(hue: 0.656, saturation: 0.787, brightness: 0.354)
    
    var body: some View {
                
        // Main view
        ZStack(alignment: .leading) {
            // Top section with the city name and date
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name).bold().font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Middle section with weather image, temperature, and background image
            VStack {
                HStack {
                    VStack(spacing: 20) {
                        Image(systemName: "sun.max").font(.system(size: 40))

                        Text(weather.weather[0].main)
                    }
                    .frame(width: 150, alignment: .leading)

                    Spacer()

                    Text(weather.main.feelsLike.roundDouble() + "°").font(.system(size: 100)).fontWeight(.bold).padding()
                }

                Spacer()
                    .frame(height: 80)

                AsyncImage(url: URL(string:"https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png"))
                {
                    image in image.resizable().aspectRatio(contentMode: .fit).frame(width: 350)
                }
            placeholder: {
                ProgressView()
            }
                Spacer()

            }
            .frame(maxWidth: .infinity)

        }
        .padding().frame(maxWidth: .infinity, alignment: .leading)

        // Bottom section with weather details
        VStack {
            Spacer()

            VStack(alignment: .leading, spacing: 20) {
                Text("Weather now").bold().padding(.bottom)

                HStack {
                    WeatherRow(logo: "thermometer.low", name: "Minimum temperature", value: (weather.main.tempMin.roundDouble() + "°"))

                    WeatherRow(logo: "thermometer.high", name: "Maximum temperature", value: (weather.main.tempMax.roundDouble() + "°"))
                }
                HStack {
                    WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + "m/s"))
                    
                    Spacer()

                    WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main.humidity.roundDouble() + "%"))
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading).padding().padding(.bottom, 20).foregroundColor(.white).background(backgroundColor).cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .background(backgroundColor.edgesIgnoringSafeArea(.all))
        .preferredColorScheme(.dark)
        .onAppear {
            updateBackgroundColor()
        }
    }
    
    // Update the background color based on the weather and time of day
    private func updateBackgroundColor() {
        let now = Date()
        let sunrise = weather.sys.sunrise.toDate()
        let sunset = weather.sys.sunset.toDate()
        
        // Determine if it's daytime or nighttime based on the current time and sunset/sunrise times
        let isDaytime = now.isBetween(sunrise, sunset)
        
        // Get the current weather condition code
        let weatherCode = weather.weather.first?.id ?? 0
        
        // Set the background color based on the weather and time of day
        if isDaytime {
            if weatherCode < 600 {
                // Rainy
                backgroundColor = Color.blue.opacity(0.3)            
            } else if weatherCode < 700 {
                // Snowy
                backgroundColor = Color.gray
            } else if weatherCode == 800 {
                // Clear
                backgroundColor = Color(hue: 0.656, saturation: 0.787, brightness: 0.354)
            } else {
                // Cloudy
                backgroundColor = Color.gray.opacity(0.4)
            }
        } else {
            if weatherCode < 600 {
                // Rainy
                backgroundColor = Color.blue.opacity(0.5)
            } else if weatherCode < 700 {
                // Snowy
                backgroundColor = Color.gray.opacity(0.5)
            } else if weatherCode == 800 {
                // Clear
                backgroundColor = Color(hue: 0.656, saturation: 0.787, brightness: 0.354)
            } else {
                // Cloudy
                backgroundColor = Color.gray.opacity(0.9)
            }
        }
    }
}
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
