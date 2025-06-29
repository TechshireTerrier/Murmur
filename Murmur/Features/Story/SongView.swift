//
//  SongView.swift
//  Murmur
//
//  Created by gabi on 6/28/25.
//

import SwiftUI

struct SongView: View {
    var body: some View {
        ScrollView {
            SongStoryView()
            DailyEmotionView()
            StoryMusicView()
        }
    }
}

#Preview {
    SongView()
}
