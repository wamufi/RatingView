// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct RatingView: View {
    
    private var maxRating = 0
    private var ratingBinding: Binding<Int>
    private var rating: Int {
        get { ratingBinding.wrappedValue }
//        set { ratingBinding.wrappedValue = newValue }
    }
    
    var spacing: CGFloat = 4
    
    var starImageName = "star"
    var starFillImageName = "star.fill"
    
    var customImages: [String] = []
    var customFillImages: [String] = []
    var isCustomSystemImage = true

    var foregroundColors: [Color] = [.blue]
    var fillColors: [Color] = [.yellow]
    var shadowColors: [Color] = [.clear]
    
    var width: CGFloat? = 42
    var height: CGFloat? = nil
    
    public init(maxRating: Int = 5, rating: Binding<Int>) {
        self.maxRating = maxRating
        self.ratingBinding = rating
    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            let foregroundColors: [Color] = if foregroundColors.count < maxRating && foregroundColors.count > 1 {
                generateGradientColors(from: foregroundColors, count: maxRating)
            } else {
                foregroundColors
            }
            
            let fillColors: [Color] = if fillColors.count < maxRating && fillColors.count > 1 {
                generateGradientColors(from: fillColors, count: maxRating)
            } else {
                fillColors
            }
            
            let shadowColors: [Color] = if shadowColors.count < maxRating && shadowColors.count > 1 {
                generateGradientColors(from: shadowColors, count: maxRating)
            } else {
                shadowColors
            }
            
            ForEach(0..<maxRating, id: \.self) { index in
                let foregroundColor = foregroundColors.count == maxRating ? foregroundColors[index] : foregroundColors[0]
                let fillColor = fillColors.count == maxRating ? fillColors[index] : fillColors[0]
                let shadowColor = shadowColors.count == maxRating ? shadowColors[index] : shadowColors[0]
                let imageName = customImages.isEmpty ? "star" : customImages[index]
                let fillImageName = customFillImages.isEmpty ? "star.fill" : customFillImages[index]

                Button {
                    ratingBinding.wrappedValue = rating == index + 1 ? 0 : index + 1
                } label: {
                    let image = isCustomSystemImage ? Image(systemName: rating <= index ? imageName : fillImageName) : Image(rating <= index ? imageName : fillImageName)
                    image
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(rating <= index ? foregroundColor : fillColor)
                        .shadow(color: shadowColor, radius: rating <= index ? 0 : 10)
                        .scaledToFit()
                        .frame(width: width, height: height ?? width)
                }
            }
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
    
    func foregroundColor(_ color: Color) -> RatingView {
        var copy = self
        copy.foregroundColors = [color]
        return copy
    }
    
    func foregroundColor(_ colors: [Color]) -> RatingView {
        var copy = self
        copy.foregroundColors = colors
        return copy
    }
    
    func shadowColor(_ color: Color) -> RatingView {
        var copy = self
        copy.shadowColors = [color]
        return copy
    }
    
    func shadowColor(_ colors: [Color]) -> RatingView {
        var copy = self
        copy.shadowColors = colors
        return copy
    }
    
    func fillColor(_ color: Color) -> RatingView {
        var copy = self
        copy.fillColors = [color]
        return copy
    }
    
    func fillColor(_ colors: [Color]) -> RatingView {
        var copy = self
        copy.fillColors = colors
        return copy
    }
    
    func customImages(_ images: [String], fillImages: [String], isSystemName: Bool = false) -> RatingView {
        guard images.count == maxRating && fillImages.count == maxRating else {
            var copy = self
            
            var newImages: [String] = []
            var newFillImages: [String] = []
            for i in 0..<maxRating {
                newImages.append(images[i % images.count])
                newFillImages.append(fillImages[i % fillImages.count])
            }
            
            copy.customImages = newImages
            copy.customFillImages = newFillImages
            copy.isCustomSystemImage = isSystemName
            
            return copy
        }
        
        var copy = self
        copy.customImages = images
        copy.isCustomSystemImage = isSystemName
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
    RatingView(rating: .constant(3))
}
