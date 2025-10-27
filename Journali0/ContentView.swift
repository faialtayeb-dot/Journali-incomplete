//
//  ContentView.swift
//  Journali0
//
//  Created by Fai Altayeb on 20/10/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showMain = false
    @State private var animateIn = false
   

    var body: some View {
        Group {
            if showMain {
                MainView()
                    .transition(.opacity)
            } else {
                splashView
                    .transition(.opacity)
            }
        }
        .background(Color(.systemBackground))
        .ignoresSafeArea()
        .onAppear {
           
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                animateIn = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut(duration: 0.35)) {
                    showMain = true
                }
            }
        }
    }

    private var splashView: some View {
        VStack(spacing: 25) {
            Image(.logo)
                .resizable()
                .frame(width: 77, height: 101)
                .scaleEffect(animateIn ? 1.0 : 0.9)
                .opacity(animateIn ? 1.0 : 0.0)

            VStack(spacing: 12) {
                Text("Journali")
                    .fontWeight(.black)
                    .font(.system(size: 42))
                    .scaleEffect(animateIn ? 1.0 : 0.95)
                    .opacity(animateIn ? 1.0 : 0.0)

                Text("Your thoughts, your story")
                    .fontWeight(.light)
                    .font(.system(size: 18))
                    .kerning(1.0)
                    .opacity(animateIn ? 1.0 : 0.0)
            }
        }
    }
}

#Preview {
    ContentView()
}
