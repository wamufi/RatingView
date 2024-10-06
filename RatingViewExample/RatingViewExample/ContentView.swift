//
//  ContentView.swift
//  RatingViewExample
//

import SwiftUI
import RatingView

struct ContentView: View {
    
    @State var rating = 0
    
    var body: some View {
        VStack {
            RatingView(maxRating: 7, rating: $rating)
                .padding()
            
            RatingView(rating: $rating)
                .shadowColor([.yellow, .cyan])
                .fillColor([.red, .black])
                .customImages(["1.circle", "2.circle", "3.circle", "4.circle", "5.circle"])
                .customFillImages(["1.circle.fill", "2.circle.fill", "3.circle.fill", "4.circle.fill", "5.circle.fill"])
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
