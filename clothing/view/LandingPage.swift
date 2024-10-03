import SwiftUI

struct ImageBackgroundView: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .overlay(Color.black.opacity(0.5)) // Dark overlay for better text visibility
    }
}

struct LandingPageView: View {
    @State private var isHovering = false // State to track hover status

    var body: some View {
        NavigationStack {
            ZStack {
                // Image Background
                ImageBackgroundView(imageName: "background3") // Replace
               
                VStack {
                    Spacer()

                    // Centered title text with better positioning and animation
                    Text("Unhemmed")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .opacity(isHovering ? 0.8 : 1.0) // Slight fade effect on hover

                    
                    Text("Where style breaks the seams")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.top, -50)
                        .scaleEffect(isHovering ? 1.05 : 1.0) // Slight scale effect on hover
                        .animation(.easeInOut, value: isHovering)

                    Spacer()

                    // Improved resizable button with hover effect
                    NavigationLink(destination: ContentView()) {
                        Text("Shop Now")
                            .font(.headline)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 95)
                            .background(isHovering ? Color.white.opacity(0.1) : Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(30)
                            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                            .scaleEffect(isHovering ? 1.05 : 1.0)
                            .animation(.easeInOut, value: isHovering)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 55)
                    .accessibilityLabel("Shop Now")
                    .accessibilityHint("Tap to shop for the latest styles")
                    .onHover { hovering in
                        isHovering = hovering // Update hover state
                    }

                }
                .padding(.horizontal, 20)
                .onAppear {
                    withAnimation {
                        // Add initial animations if necessary
                    }
                }
            }
        }
    }
}

// Preview
#Preview {
    LandingPageView()
}
