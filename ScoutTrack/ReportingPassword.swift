//  ReportingPassword.swift
//  ScoutTrack
//
//  Created by Javius Loh on 27/5/25.
//

import SwiftUI

struct ReportingPassword: View {
    @State private var digits: [String] = ["", "", "", ""]
    @FocusState private var focusedIndex: Int?
    @State private var isAuthenticatedReporting = false
    @Binding var reportingCode: String
    @State private var shakeOffset: CGFloat = 0

    var body: some View {
        NavigationStack {
            VStack {
                // 4 Digit Input Fields
                HStack(spacing: 16) {
                    ForEach(0..<4, id: \.self) { index in
                        TextField("", text: $digits[index])
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 50, height: 50)
                            .background(Color.white)
                            .foregroundColor(.black)
                            .font(.title2)
                            .cornerRadius(8)
                            .focused($focusedIndex, equals: index)
                            .onChange(of: digits[index]) { newValue in
                                handleInput(newValue, at: index)
                            }

                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color(hex: 0x115488))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 32)
                .modifier(ShakeEffectReporting(animatableData: shakeOffset))
                .onAppear {
                    focusedIndex = 0
                }

                // Login Button
                Button("Login") {
                    let inputCode = digits.joined()
                    if inputCode == reportingCode {
                        isAuthenticatedReporting = true
                    } else {
                        withAnimation(.linear(duration: 0.4)) {
                            shakeOffset = 1
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            shakeOffset = 0
                        }
                    }
                }
                .foregroundColor(Color(hex: 0x115488))
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: 0x6FAFD0))
                .cornerRadius(12)
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .background(Color(hex: 0xBAE4F2))
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .fullScreenCover(isPresented: $isAuthenticatedReporting) {
                ReportingView(reportingCode: $reportingCode)
            }
        }
    }

    func handleInput(_ newValue: String, at index: Int) {
        if newValue.count > 1 {
            digits[index] = String(newValue.last!) // only allow 1 digit
        }

        if newValue.isEmpty {
            // Backspace logic
            if index > 0 {
                focusedIndex = index - 1
            }
        } else {
            // Move forward
            if index < 3 {
                focusedIndex = index + 1
            } else {
                focusedIndex = nil
            }
        }
    }
}

struct ShakeEffectReporting: GeometryEffect {
    var animatableData: CGFloat
    let amplitude: CGFloat = 5
    let shakesPerUnit: CGFloat = 4

    func effectValue(size: CGSize) -> ProjectionTransform {
        let xOffset = sin(animatableData * .pi * shakesPerUnit * 2) * amplitude
        return ProjectionTransform(CGAffineTransform(translationX: xOffset, y: 0))
    }
}

#Preview {
    ReportingPassword(reportingCode: .constant("0000"))
}

