//
//  SubtitleServiceImpl.swift
//  Murmur
//
//  Created by Moo on 7/12/25.
//

import Foundation

final class SubtitleServiceImpl: SubtitleService {
    func generateSegments(from script: RadioScript) -> [SubtitleSegment] {
        let cleanedScript = removeQuotes(script.fullScript)
        
        let sentences = splitIntoSentences(cleanedScript)
        let refinedSegments = sentences.flatMap { splitLongSentence($0) }
        
        let balancedSegments = mergeShortSegments(refinedSegments)
        
        return createSegmentsWithPosition(balancedSegments, originalScript: cleanedScript)
    }
    
    private func removeQuotes(_ text: String) -> String {
        return text
            .replacingOccurrences(of: "\"", with: "")
            .replacingOccurrences(of: "'", with: "")
    }
    
    private func splitIntoSentences(_ text: String) -> [String] {
        return text.components(separatedBy: CharacterSet(charactersIn: ".!?"))
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
    
    private func splitLongSentence(_ sentence: String, maxLength: Int = 25) -> [String] {
        guard sentence.count > maxLength else { return [sentence] }
        
        let parts = sentence.components(separatedBy: ", ")
        if parts.count > 1 {
            return parts.map { $0.trimmingCharacters(in: .whitespaces) }
        }
        
        return [sentence]
    }
    
    private func mergeShortSegments(_ segments: [String], minLength: Int = 8, maxLength: Int = 35) -> [String] {
        guard !segments.isEmpty else { return [] }
        
        var result: [String] = []
        var currentSegment = segments[0]
        
        for i in 1..<segments.count {
            let nextSegment = segments[i]
            
            if currentSegment.count < minLength && (currentSegment + " " + nextSegment).count <= maxLength {
                currentSegment = currentSegment + " " + nextSegment
            } else {
                result.append(currentSegment)
                currentSegment = nextSegment
            }
        }
        
        result.append(currentSegment)
        
        return result
    }
    
    private func createSegmentsWithPosition(_ texts: [String], originalScript: String) -> [SubtitleSegment] {
        var segments: [SubtitleSegment] = []
        var searchIndex = 0
        
        for text in texts {
            if let range = originalScript.range(of: text, range: originalScript.index(originalScript.startIndex, offsetBy: searchIndex)..<originalScript.endIndex) {
                let nsRange = NSRange(range, in: originalScript)
                segments.append(SubtitleSegment(text: text, originalRange: nsRange))
                searchIndex = nsRange.location + nsRange.length
            } else {
                let dummyRange = NSRange(location: searchIndex, length: text.count)
                segments.append(SubtitleSegment(text: text, originalRange: dummyRange))
                searchIndex = min(searchIndex + text.count + 5, originalScript.count)
            }
        }
        
        return segments
    }
}
