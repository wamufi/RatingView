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
            RatingView(maxRating: 4, rating: $rating)
                .padding()
            
            RatingView(rating: $rating)
                .shadowColor([.yellow, .cyan])
                .fillColor([.red, .black])
                .customImages(["1.circle", "2.circle", "3.circle", "4.circle", "5.circle"], fillImages: ["1.circle.fill", "2.circle.fill", "3.circle.fill", "4.circle.fill", "5.circle.fill"], isSystemName: true)
                .padding()
            
            RatingView(rating: $rating)
                .shadowColor([.pink, .red])
                .fillColor([.pink, .red])
                .customImages(["favorite_favorite_symbol"], fillImages: ["favorite_favorite_fill1_symbol"])
                .padding()
            
            RatingView(maxRating: 6, rating: $rating)
                .customImages(["counter_1_counter_1_symbol", "counter_2_counter_2_symbol"], fillImages: ["counter_1_counter_1_fill1_symbol", "counter_2_counter_2_fill1_symbol"])
                .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
