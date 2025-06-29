//
//  TestViewModel.swift
//  Murmur
//
//  Created by Muchan Kim on 6/29/25.
//

import Foundation

final class RadioTestViewModel: ObservableObject {
    @Published private(set) var currentStory: UserStory
    @Published private(set) var generatedScript: RadioScript
    
    private let radioService: RadioService
    
    init(radioService: RadioService = RadioServiceImpl()) {
        self.radioService = radioService
        self.currentStory = MockData.sampleStory
        self.generatedScript = radioService.generateScript(from: MockData.sampleStory)
    }
}
