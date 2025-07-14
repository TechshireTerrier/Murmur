//
//  SwipeBack.swift
//  Murmur
//
//  Created by 김현기 on 7/5/25.
//

import SwiftUI

extension View {
    func enableSwipeBack() -> some View {
        modifier(EnableSwipeBackGesture())
    }
}

struct EnableSwipeBackGesture: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                SwipeBackEnabler()
                    .frame(width: 0, height: 0)
            )
    }
}

struct SwipeBackEnabler: UIViewControllerRepresentable {
    func makeUIViewController(context _: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            controller.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            controller.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        }
        return controller
    }

    func updateUIViewController(_: UIViewController, context _: Context) {}
}
