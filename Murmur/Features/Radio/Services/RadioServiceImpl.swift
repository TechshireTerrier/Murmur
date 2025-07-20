import Foundation

final class RadioServiceImpl: RadioService {
    
    func generateScript(from story: UserStory) -> RadioScript {
        let dateTimeInfo = getCurrentDateTimeInfo()
        let emotionText = formatEmotions(story.emotionKeywords)
        let fullScript = buildRadioScript(
            dateTimeInfo: dateTimeInfo,
            story: story,
            emotionText: emotionText
        )
        
        return RadioScript(fullScript: fullScript)
    }
}

private extension RadioServiceImpl {
    
    // 날짜 문자열 처리
    func getCurrentDateTimeInfo() -> (date: String, dayOfWeek: String, time: String) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        let formattedDate = dateFormatter.string(from: currentDate)
        
        dateFormatter.dateFormat = "EEEE"
        let formattedDayOfWeek = dateFormatter.string(from: currentDate)
        
        dateFormatter.dateFormat = "a h시 mm분"
        let formattedTime = dateFormatter.string(from: currentDate)
        
        return (formattedDate, formattedDayOfWeek, formattedTime)
    }
    
    // 감정 문자열 처리
    func formatEmotions(_ emotionKeywords: [String]) -> String {
        guard !emotionKeywords.isEmpty else { 
            return "복잡한 감정으로" 
        }
        
        if emotionKeywords.count == 1 {
            return "\(emotionKeywords[0])로"
        } else {
            let firstEmotion = emotionKeywords[0]
            let secondEmotion = emotionKeywords[1]
            return "\(firstEmotion) 그리고 \(secondEmotion)로"
        }
    }
    
    // 라디오 스크립트 생성
    func buildRadioScript(
        dateTimeInfo: (date: String, dayOfWeek: String, time: String),
        story: UserStory,
        emotionText: String
    ) -> String {
        return """
        안녕하세요. Murmur 라디오 시작합니다.
        
        지금은 \(dateTimeInfo.date), \(dateTimeInfo.dayOfWeek), \(dateTimeInfo.time)입니다.
        
        오늘, 이런 사연이 도착했어요.
        
        "\(story.content)"
        
        오늘의 감정은 \(emotionText) 정리해볼 수 있을 것 같아요.
        
        그래서 준비한 곡은 \(story.recommendedSongAuthor)의 '\(story.recommendedSongTitle)'입니다.
        
        조용한 마음으로 감정을 따라가며 들어보세요.
        
        내일도 이 자리에서, 여러분의 이야기 기다릴게요.
        
        여기는 Murmur였습니다.
        """
    }
} 
