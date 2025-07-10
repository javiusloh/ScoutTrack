//
//  TeacherMainView.swift
//  ScoutTrack
//
//  Created by Javius Loh on 26/5/25.
//
import SwiftUI

struct TeacherMainView: View {
    @State var showSheetLogin = false
    @Binding var reportingCode: String
    @State private var codeGeneratedAt: Date? = nil
    @State private var timer: Timer?
    let backgroundColor = UIColor(red: 0xba/255, green: 0xe4/255, blue: 0xf2/255, alpha: 1)

    var body: some View {
        NavigationStack {
                TodayView()
            .tint(Color(hex: 0x115488))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text(reportingCode)
                        
                        // Generate Code Button
                        Button {
                            generateCode()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .foregroundColor(Color(hex: 0x115488))
                        }

                        // Home Button
                        Button {
                            showSheetLogin = true
                        } label: {
                            Image(systemName: "house.fill")
                                .foregroundColor(Color(hex: 0x115488))
                        }
                        .fullScreenCover(isPresented: $showSheetLogin) {
                            LoginView()
                        }
                    }
                }
            }
            .background(Color(hex: 0xbae4f2).ignoresSafeArea())
            .onAppear {
                if reportingCode.isEmpty {
                    generateCode()
                }
                startCodeExpirationTimer()
            }
        }
    }

    func generateCode() {
        let code = String(format: "%04d", Int.random(in: 0...9999)) // 4-digit code
        reportingCode = code
        codeGeneratedAt = Date()
        startCodeExpirationTimer()
    }

    func startCodeExpirationTimer() {
        timer?.invalidate() // Invalidate any existing timer

        guard let codeTime = codeGeneratedAt else { return }

        let interval = 1800.0 // 30 minutes in seconds
        let expirationTime = codeTime.addingTimeInterval(interval)
        let timeLeft = expirationTime.timeIntervalSinceNow

        if timeLeft <= 0 {
            reportingCode = "Expired"
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: timeLeft, repeats: false) { _ in
                reportingCode = "Expired"
            }
        }
    }
}

#Preview {
    TeacherMainView(reportingCode: .constant("000"))
}
