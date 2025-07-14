//
//  CustomBackButton.swift
//  Murmur
//
//  Created by 김현기 on 7/5/25.
//

import SwiftUI

struct CustomBackButton: ToolbarContent {
    let action: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .navigation) {
            Button(action: action) {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color.text01)
                    .font(.system(size: 17))
            }
        }
    }
}
