//
//  SubtitleServiceImpl.swift
//  Murmur
//
//  Created by Moo on 7/12/25.
//

import Foundation

// MARK: - Supporting Types (간소화)

final class SubtitleServiceImpl: SubtitleService {
    func generateSegments(from script: RadioScript) -> [SubtitleSegment] {
        return generateLineBasedSegments(from: script)
    }
    
    // MARK: - 라인 기반 정확한 분할 시스템
    private func generateLineBasedSegments(from script: RadioScript) -> [SubtitleSegment] {
        let fullScript = script.fullScript
        var segments: [SubtitleSegment] = []
        
        // 스크립트를 빈 줄 기준으로 분할 (실제 구조 반영)
        let lines = fullScript.components(separatedBy: "\n\n")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        var currentIndex = 0
        
        for line in lines {
            if line.contains("\"") {
                // 스토리 부분: 따옴표 제거하고 동적 분할
                let storyContent = line.replacingOccurrences(of: "\"", with: "")
                let storySegments = splitStoryContent(storyContent, baseIndex: currentIndex)
                segments.append(contentsOf: storySegments)
            } else if shouldSplitMusicLine(line) {
                // 음악 정보 라인 분할: "그래서 준비한 곡은 Artist의 'Title'입니다."
                let musicSegments = splitMusicLine(line, baseIndex: currentIndex)
                segments.append(contentsOf: musicSegments)
            } else {
                // 일반 라인: 그대로 세그먼트 생성
                let range = NSRange(location: currentIndex, length: line.count)
                segments.append(SubtitleSegment(text: line, originalRange: range))
            }
            
            currentIndex += line.count + 2 // "\n\n" 고려
        }
        
        return segments
    }
    
    // MARK: - 음악 라인 분할 헬퍼 메서드들
    private func shouldSplitMusicLine(_ line: String) -> Bool {
        return line.contains("그래서 준비한 곡은") && line.contains("입니다.")
    }
    
    private func splitMusicLine(_ line: String, baseIndex: Int) -> [SubtitleSegment] {
        // "그래서 준비한 곡은 Artist의 'Title'입니다." → 2개로 분할
        let parts = line.components(separatedBy: "그래서 준비한 곡은 ")
        
        if parts.count == 2 {
            let firstPart = "그래서 준비한 곡은"
            let secondPart = parts[1] // "Artist의 'Title'입니다."
            
            let segment1 = SubtitleSegment(
                text: firstPart, 
                originalRange: NSRange(location: baseIndex, length: firstPart.count)
            )
            
            let segment2 = SubtitleSegment(
                text: secondPart,
                originalRange: NSRange(location: baseIndex + firstPart.count + 1, length: secondPart.count)
            )
            
            return [segment1, segment2]
        }
        
        // 분할 실패시 원본 반환
        return [SubtitleSegment(text: line, originalRange: NSRange(location: baseIndex, length: line.count))]
    }
    
    // 스토리 내용 분할 (기존 알고리즘 활용)
    private func splitStoryContent(_ content: String, baseIndex: Int) -> [SubtitleSegment] {
        let sentences = splitIntoSentences(content)
        let refinedSegments = sentences.flatMap { splitLongSentence($0) }
        let balancedSegments = mergeShortSegments(refinedSegments)
        
        return createSegmentsWithPosition(balancedSegments, originalScript: content, baseIndex: baseIndex)
    }
    
    // MARK: - 기존 분할 알고리즘 (스토리 부분에만 사용)
    private func splitIntoSentences(_ text: String) -> [String] {
        return text.components(separatedBy: CharacterSet(charactersIn: ".!?"))
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
    
    private func splitLongSentence(_ sentence: String, maxLength: Int = 35) -> [String] {
        guard sentence.count > maxLength else { return [sentence] }
        
        // 1순위: 중간 지점 공백 분할
        if let result = splitByMiddleSpace(sentence), result.count == 2 {
            return result
        }
        
        // 2순위: 기존 쉼표 분할
        let parts = sentence.components(separatedBy: ", ")
        if parts.count > 1 {
            return parts.map { $0.trimmingCharacters(in: .whitespaces) }
        }
        
        // 3순위: 원본 반환
        return [sentence]
    }
    
    // 중간 지점에서 가장 가까운 공백 기준 분할
    private func splitByMiddleSpace(_ sentence: String) -> [String]? {
        let middle = sentence.count / 2
        let spaces = sentence.enumerated().compactMap { index, char in
            char == " " ? index : nil
        }
        
        guard !spaces.isEmpty else { return nil }
        
        // 중간 지점에서 가장 가까운 공백 찾기
        let closestSpace = spaces.min { abs($0 - middle) < abs($1 - middle) } ?? middle
        
        let startIndex = sentence.startIndex
        let splitIndex = sentence.index(startIndex, offsetBy: closestSpace)
        let afterSpaceIndex = sentence.index(after: splitIndex)
        
        let part1 = String(sentence[startIndex..<splitIndex]).trimmingCharacters(in: .whitespaces)
        let part2 = String(sentence[afterSpaceIndex...]).trimmingCharacters(in: .whitespaces)
        
        // 분할된 각 부분이 너무 짧지 않은지 확인
        guard part1.count >= 8 && part2.count >= 8 else { return nil }
        
        return [part1, part2]
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
    
    private func createSegmentsWithPosition(_ texts: [String], originalScript: String, baseIndex: Int = 0) -> [SubtitleSegment] {
        var segments: [SubtitleSegment] = []
        var searchIndex = 0
        
        for text in texts {
            if let range = originalScript.range(of: text, range: originalScript.index(originalScript.startIndex, offsetBy: searchIndex)..<originalScript.endIndex) {
                let nsRange = NSRange(location: baseIndex + range.lowerBound.utf16Offset(in: originalScript),
                                    length: text.count)
                segments.append(SubtitleSegment(text: text, originalRange: nsRange))
                searchIndex = range.upperBound.utf16Offset(in: originalScript)
            } else {
                let dummyRange = NSRange(location: baseIndex + searchIndex, length: text.count)
                segments.append(SubtitleSegment(text: text, originalRange: dummyRange))
                searchIndex = min(searchIndex + text.count + 5, originalScript.count)
            }
        }
        
        return segments
    }
}
