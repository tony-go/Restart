//
//  HomeView.swift
//  Restart
//
//  Created by Tony Gorez on 17/05/2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    
    @State private var isAnimating: Bool = false
    
    private func goToOnboardingView() {
        isOnboardingViewActive = true
        playsound(sound: "success", type: "m4a")
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - Header
            Spacer()
            ZStack {
                CircleUI(ShapeColor: .gray, ShapeOpacity: 0.2)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(
                        Animation
                            .easeInOut(duration: 4)
                            .repeatForever()
                        , value: isAnimating
                    )
            }
            
            // MARK: - Body
            Text("The time that leads to mastery is dependent on the intentsity of our foucs.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            // MARK: - Footer
            Spacer()
            
            Button(action: {
                goToOnboardingView()
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3, execute: {
                isAnimating = true
            })
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
