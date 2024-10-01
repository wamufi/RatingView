// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct RatingView: View {
    
    @State var rating = 0
    var maxRating = 5
    
    var spacing: CGFloat = 4
    
    var starImageName = "star"
    var starFillImageName = "star.fill"
    
    var customImages = ["1.circle", "2.circle", "3.circle", "4.circle", "5.circle"]
    var customFillImages = ["1.circle.fill", "2.circle.fill", "3.circle.fill", "4.circle.fill", "5.circle.fill"]
    
    var foregroundColor: Color = .blue
    var highlightColors: [Color] = [.clear]
    
    var width: CGFloat? = 42
    var height: CGFloat? = nil
    
    public init() {
        
    }
    
    public var body: some View {
        VStack {
            // Image
            HStack(spacing: spacing) {
                let shadowColors: [Color] = if highlightColors.count < maxRating && highlightColors.count > 1 {
                    generateGradientColors(from: highlightColors, count: maxRating)
                } else {
                    highlightColors
                }
                
                ForEach(0..<maxRating, id: \.self) { index in
                    let highlightColor = shadowColors.count == maxRating ? shadowColors[index] : shadowColors[0]
                    
                    Button {
                        rating = rating == index + 1 ? 0 : index + 1
                    } label: {
                        Image(systemName: rating <= index ? customImages[index] : customFillImages[index])
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(rating <= index ? foregroundColor : highlightColor)
                            .shadow(color: highlightColor, radius: rating <= index ? 0 : 10)
                            .scaledToFit()
                            .frame(width: width, height: height ?? width)
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
    
    func generateGradientColors(from colors: [Color], count: Int) -> [Color] {
        guard colors.count >= 2 else { return [] }
        var gradientColors: [Color] = []
        
        for i in 0..<count {
            let fraction = CGFloat(i) / CGFloat(count - 1)
            let colorIndex = min(Int(fraction * CGFloat(colors.count - 1)), colors.count - 2)
            let localFraction = (fraction * CGFloat(colors.count - 1)) - CGFloat(colorIndex)
            
            gradientColors.append(colors[colorIndex].interpolate(to: colors[colorIndex + 1], fraction: localFraction))
        }
        
        return gradientColors
    }
}

public extension RatingView {
    func spacing(_ spacing: CGFloat) -> RatingView {
        var copy = self
        copy.spacing = spacing
        return copy
    }
    
    func highlightColor(_ color: Color) -> RatingView {
        var copy = self
        copy.highlightColors = [color]
        return copy
    }
    
    func highlightColor(_ colors: [Color]) -> RatingView {
        var copy = self
        copy.highlightColors = colors
        return copy
    }
}

extension Color {
    func interpolate(to color2: Color, fraction: CGFloat) -> Color {
        let color1Components = UIColor(self).cgColor.components ?? [0, 0, 0, 0]
        let color2Components = UIColor(color2).cgColor.components ?? [0, 0, 0, 0]
        
        let r = color1Components[0] + (color2Components[0] - color1Components[0]) * fraction
        let g = color1Components[1] + (color2Components[1] - color1Components[1]) * fraction
        let b = color1Components[2] + (color2Components[2] - color1Components[2]) * fraction
        let a = color1Components[3] + (color2Components[3] - color1Components[3]) * fraction
        
        return Color(red: Double(r), green: Double(g), blue: Double(b), opacity: Double(a))
    }
}

#Preview {
    RatingView()
}
