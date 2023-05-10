//
//  ContentView.swift
//  Animations
//
//  Created by Mariam Babutsidze on 10.05.23.
//

import SwiftUI

struct ScaledRectangle: Shape {

    var animatableData: Double

    func path(in rect: CGRect) -> Path {
        let radius = rect.width * animatableData

        let x = rect.midX - radius / 2
        let y = rect.midY - radius / 2

        let rect = CGRect(x: x, y: y, width: radius, height: radius)

        return Rectangle().path(in: rect)
    }
}

struct ClipShapeModifier<T: Shape>: ViewModifier {
    let shape: T

    func body(content: Content) -> some View {
        content.clipShape(shape)
    }
}

extension AnyTransition {
    static var iris: AnyTransition {
        .modifier(
            active: ClipShapeModifier(shape: ScaledRectangle(animatableData: 0)),
            identity: ClipShapeModifier(shape: ScaledRectangle(animatableData: 1))
        )
    }
}


struct ContentView: View {
    @State private var isShowingRed = false

    var body: some View {
        ZStack {
            Button {
                withAnimation(.easeOut.repeatForever(autoreverses: false)) {
                    isShowingRed.toggle()
                }
            } label: {
                Text("WELCOME")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .overlay(
                        Capsule(style: .circular)
                            .stroke(LinearGradient(colors: [.cyan, .blue, .purple, .red, .pink], startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 5))
                            .background(.white)
                    )
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)

            if isShowingRed {
                Button {

                } label: {
                    Text("WELCOME")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(colors: [.cyan, .blue, .purple, .red, .pink], startPoint: .leading, endPoint: .trailing)
                        )
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .transition(.iris)
                .zIndex(1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
