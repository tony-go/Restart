//
//  OnboardingView.swift
//  Restart
//
//  Created by Tony Gorez on 17/05/2023.
//

import SwiftUI

private let buttonSize: Double = 80

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - buttonSize
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1
    @State private var title: String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    private func goToHome() {
        isOnboardingViewActive = false
        playsound(sound: "chimeup", type: "mp3")
        hapticFeedback.notificationOccurred(.success)
    }

    private func resetButton() {
        buttonOffset = 0
    }
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)

            VStack(spacing: 20) {
                // MARK: - HEADER
                Spacer()
                VStack(spacing: 0) {
                    Text(title)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        // NOTE: using this id property
                        // to force transition because by default
                        .id(title)

                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """).font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                } //: Header
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                

                // MARK: - BODY
                ZStack {
                    CircleUI(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1, y: 0)
                        .blur(radius: abs(imageOffset.width / 10))
                        .animation(.easeOut(duration: 0.5), value: imageOffset)

                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            title = "Give."
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        title = "Share."
                                    }
                                }
                        )
                        .animation(.easeOut(duration: 0.5), value: imageOffset)
                } //: Body
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(1), value: isAnimating)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                )
                Spacer()

                // MARK: - BODY
                ZStack {
                    // 1. Background
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)

                    // 2. CTA
                    Text("Get started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)

                    // 3. Capsule
                    HStack {
                        Capsule().fill(Color("ColorRed"))
                            .frame(width: buttonOffset + buttonSize)
                        Spacer()
                    }

                    // 4.Circle
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: buttonSize, height: buttonSize, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0
                                        && buttonOffset <= buttonWidth - buttonSize {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded{ _ in
                                    if buttonOffset > (buttonWidth / 2) {
                                        buttonOffset = buttonWidth - buttonSize
                                        goToHome()
                                    } else {
                                        resetButton()
                                    }
                                }
                        ) //: Gesture

                        Spacer()
                    } //: HStack
                } //: Body
                .frame(width: buttonWidth, height: buttonSize, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            } //: VStack
        } //: ZStack
        .onAppear{
            isAnimating = true
        }
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
