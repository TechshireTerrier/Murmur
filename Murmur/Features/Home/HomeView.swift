//
//  ContentView.swift
//  Murmur
//
//  Created by 김현기 on 6/24/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Welcome to Murmur")
                .font(.PretendardLargeTitle)
                .foregroundStyle(Color.PointBeige)
            Text("Welcome to Murmur")
                .font(.PretendardBodyBold)
                .foregroundStyle(Color.Mint800)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
