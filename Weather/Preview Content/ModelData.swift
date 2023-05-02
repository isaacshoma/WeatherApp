//
//  ModelData.swift
//  Weather
//
//  Created by Isaac Shoma on 2023-04-01.
//
import Foundation
import Foundation

// This is a function that loads a JSON file and decodes it into a generic Decodable type
func load<T: Decodable>(_ filename: String) -> T {
    // Create a Data object to store the contents of the file
    let data: Data

    // Attempt to get the URL of the file in the main bundle
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            // If the file cannot be found, raise a fatal error
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        // Try to load the file into the Data object
        data = try Data(contentsOf: file)
    } catch {
        // If the file cannot be loaded, raise a fatal error
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        // Try to decode the JSON data into the specified type
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        // If the JSON data cannot be decoded, raise a fatal error
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

// This is a dummy weather object for previewing purposes
var previewWeather: ResponseBody = load("weatherdata.json")

