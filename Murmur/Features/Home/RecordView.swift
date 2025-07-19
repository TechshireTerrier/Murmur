////
////  RecordView.swift
////  Murmur
////
////  Created by Ethan on 7/2/25.
////
//
//import SwiftUI
//
//struct RecordView: View {
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea() // 배경색
//            VStack() {
//                // 상단 바
//                HStack {
//                    Button(action: {
//                        // 뒤로가기 동작
//                    }) {
//                        Image("Chevron_Left")
//                            .resizable()
//                            .frame(width: 17, height: 22)
//                            .foregroundColor(Color.text01)
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 8)
//
//                // 타이틀
//                Text("오늘의 사연을\n신청해보세요")
//                    .font(.PretendardTitle1Bold)
//                    .foregroundColor(Color.text01)
//                    .kerning(0.38)
//                    .padding(.top, 28)
//                    .padding(.horizontal, 32)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                Spacer()
//                // 중앙 녹음 아이콘 + 안내문
//                VStack() {
//                ZStack {
//                    Circle()
//                        .fill(Color.keyMint) // 민트색
//                        .frame(width: 200, height: 200)
//                    Image("Recording") // 녹음 아이콘
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 158, height: 158)
//                }
//                Text("사연을 듣는 중이에요")
//                    .font(.PretendardTitle2Bold)
//                    .foregroundColor(Color.text01)
//            }
//                Spacer()
//                // 하단 버튼
//                Button(action: {
//                    // 녹음 완료 동작
//                }) {
//                    Text("녹음 완료")
//                        .font(.PretendardBodySemiBold)
//                        .foregroundColor(.black)
//                        .frame(maxWidth: .infinity)
//                        .padding(16)
//                        .background(Color.keyMint)
//                        .cornerRadius(15)
//                        .padding(.horizontal, 16)
//                }
//                .padding(.bottom, 32)
//            }
//        }
//    }
//}
//    
//
//#Preview {
//    RecordView()
//        .preferredColorScheme(.dark)
//
//}
