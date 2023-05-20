//
//  CircleUI.swift
//  Restart
//
//  Created by Tony Gorez on 18/05/2023.
//

import SwiftUI

struct CircleUI: View {
    @State var ShapeColor: Color
    @State var ShapeOpacity: Double
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        } //: ZStack
        .blur(radius: isAnimating ? 0 : 5)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
        })
        
    }
}

struct CircleUI_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            CircleUI(ShapeColor: .white, ShapeOpacity: 0.2)
        }
    }
}
