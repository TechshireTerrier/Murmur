//
//  NavigationManager.swift
//  Murmur
//
//  Created by 김현기 on 7/5/25.
//

import SwiftUI

final class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()

    // 특정 뷰로 이동
    func push(to destination: DestinationType) {
        path.append(destination)
    }

    // 이전 화면으로 이동
    func pop() {
        path.removeLast()
    }

    // 뷰경로 초기화 이후 첫 화면으로 이동
    func popToRoot() {
        path.removeLast(path.count)
    }
}
