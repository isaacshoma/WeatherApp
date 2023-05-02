//
//  LoadingView.swift
//  Weather
//
//  Created by Isaac Shoma
// 615391

import SwiftUI

// Define a struct called LoadingView that conforms to the View protocol
struct LoadingView: View {
    // Declare a constant property called backgroundColor of type Color
    let backgroundColor: Color
    
    // Define the view's body
    var body: some View {
        // Create a ProgressView instance and set its style to a CircularProgressViewStyle with a white tint
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            // Set the view's frame to fill the available space in its container
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // Set the view's background color to the value of the backgroundColor property
            .background(backgroundColor)
    }
}

// Define a struct called LoadingView_Previews that conforms to the PreviewProvider protocol
struct LoadingView_Previews: PreviewProvider {
    // Define a computed property called previews of type some View
    static var previews: some View {
        // Instantiate a LoadingView with a blue background color and return it as the preview
        LoadingView(backgroundColor: Color.blue)
    }
}

