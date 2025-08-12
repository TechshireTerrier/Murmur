//
//  EmotionAnalysisService.swift
//  Murmur
//
//  Created by Muchan Kim on 8/10/25.
//

import CoreML
import Foundation

struct EmotionResult: Identifiable {
    let id = UUID()
    let label: String
    let confidence: Double
}

final class EmotionAnalysisService {
    private var model: MLModel?
    
    init() {
        loadModel()
    }
    
    func analyzeEmotions(from text: String) -> [EmotionResult] {
        guard let model = model else {
            return []
        }
        
        do {
            let input = try MLDictionaryFeatureProvider(dictionary: ["text": text])
            let prediction = try model.prediction(from: input)
            let emotions = parseEmotionsFromPrediction(prediction)
            
            print("✅ Emotions analyzed: \(emotions.count) emotions found")
            return emotions
        } catch {
            print("❌ Error details: \(error.localizedDescription)")
            return []
        }
    }
    
    private func loadModel() {
        guard let modelURL = Bundle.main.url(forResource: "SentimentClassifier", withExtension: "mlmodelc") else {
            print("❌ Model file 'SentimentClassifier.mlmodelc' not found in bundle")
            return
        }
        
        do {
            self.model = try MLModel(contentsOf: modelURL)
        } catch {
            print("❌ Error loading model: \(error)")
        }
    }
    
    private func parseEmotionsFromPrediction(_ prediction: MLFeatureProvider) -> [EmotionResult] {
        var emotions: [EmotionResult] = []
        
        for featureName in prediction.featureNames {
            if let feature = prediction.featureValue(for: featureName) {
                if feature.type == .string {
                    let stringValue = feature.stringValue
                    emotions.append(EmotionResult(label: stringValue, confidence: 1.0))
                    
                    let relatedEmotions = getRelatedEmotions(for: stringValue)
                    for relatedEmotion in relatedEmotions {
                        emotions.append(EmotionResult(label: relatedEmotion, confidence: 1.0))
                    }
                }
            }
        }
        
        return emotions.prefix(4).map { $0 }
    }
    
    private func getRelatedEmotions(for emotion: String) -> [String] {
        let emotionMap: [String: [String]] = [
                "분노": ["격분", "분개", "화남"],
                "당황": ["혼란", "어색함", "불편함"],
                "고마움": ["감사", "배려", "따뜻함"],
                "기대감": ["설렘", "희망", "두근거림"],
                "신뢰": ["믿음", "안정", "의지"],
                "뿌듯함": ["자부심", "성취", "만족"],
                "불안": ["초조", "긴장", "걱정"],
                "짜증": ["불쾌", "귀찮음", "신경질"],
                "행복": ["기쁨", "환희", "즐거움"],
                "공포": ["두려움", "불안", "위협"],
                "슬픔": ["우울", "상실", "그리움"],
                "중립": ["평온", "무감정", "객관"]
        ]
        return emotionMap[emotion]!
    }
}
