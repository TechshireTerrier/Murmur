//
//  ButtonView.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import SwiftUI

struct ButtonView: View {
    var body: some View {
        VStack {
            Button {
                print("눌렸다!")
            } label: {
                Text("수정하기")
                    .modifier(LongButtonModifier(buttonColor: Color.keyMint))
            }
            
            Text("기쁨")
                .modifier(EmotionLabelModifier())
        }
    }
}

#Preview {
    ButtonView()
}
