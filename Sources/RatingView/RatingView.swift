// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct RatingView: View {
    
    @State var rating = 0
    
    var maxRating = 5
    
    var starImageName = "star"
    var starFillImageName = "star.fill"
    
    var customImages = ["1.circle", "2.circle", "3.circle", "4.circle", "5.circle"]
    var customFillImages = ["1.circle.fill", "2.circle.fill", "3.circle.fill", "4.circle.fill", "5.circle.fill"]

    var foregroundColor: Color = .blue
    var highlightColors: [Color] = [.yellow, .red, .purple, .green, .orange]
    
    var body: some View {
        VStack {
            // Image
            HStack {
                ForEach(0..<maxRating, id: \.self) { index in
                    let highlightColor = highlightColors[index]
                    
                    Button {
                        rating = rating == index + 1 ? 0 : index + 1
                    } label: {
                        Image(systemName: rating <= index ? customImages[index] : customFillImages[index])
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(rating <= index ? foregroundColor : highlightColor)
                            .shadow(color: highlightColor, radius: rating <= index ? 0 : 10)
                            .scaledToFit()
                    }
                }
            }
            .padding()
            
            // Star
            HStack {
                ForEach(0..<maxRating, id: \.self) { index in
                    Button {
                        rating = rating == index + 1 ? 0 : index + 1
                    } label: {
                        Image(systemName: rating <= index ? starImageName: starFillImageName)
                            .foregroundColor(rating <= index ? foregroundColor : .yellow)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    RatingView()
}
