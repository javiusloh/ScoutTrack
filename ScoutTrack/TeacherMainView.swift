//
//  TeacherMainView.swift
//  ScoutTrack
//
//  Created by Javius Loh on 26/5/25.
//
import SwiftUI

struct TeacherMainView: View {
    @State var showSheetLogin = false
    
    var body: some View {
        NavigationStack {
            TabView {
                TodayView()
                    .background(Color.clear) // Ensure transparency
                    .tabItem {
                        Image(systemName: "calendar.badge.checkmark")
                        Text("Today")
                    }
                
                SummaryView()
                    .background(Color.clear) // Ensure transparency
                    .tabItem {
                        Image(systemName: "chart.bar.xaxis")
                        Text("Summary")
                    }
            }
            .tint(Color(hex: 0x115488))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheetLogin = true
                    } label: {
                        Image(systemName: "house.fill")
                            .padding()
                            .foregroundColor(Color(hex: 0x115488))
                    }
                    .fullScreenCover(isPresented: $showSheetLogin) {
                        LoginView()
                    }
                }
            }
        }
    }
}



#Preview {
    TeacherMainView()
}
