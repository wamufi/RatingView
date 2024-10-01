//
//  ContentView.swift
//  RatingViewExample
//

import SwiftUI
import RatingView

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            RatingView()
                .highlightColor([.yellow, .cyan])
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
