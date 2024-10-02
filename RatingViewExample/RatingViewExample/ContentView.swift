//
//  ContentView.swift
//  RatingViewExample
//

import SwiftUI
import RatingView

struct ContentView: View {
    var body: some View {
        VStack {
            RatingView()
                .shadowColor([.indigo, .mint])
                .padding()
            
            RatingView()
                .shadowColor([.yellow, .cyan])
                .customImages(["1.circle", "2.circle", "3.circle", "4.circle", "5.circle"])
                .customFillImages(["1.circle.fill", "2.circle.fill", "3.circle.fill", "4.circle.fill", "5.circle.fill"])
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
