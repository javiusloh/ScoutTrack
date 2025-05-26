//
//  SummaryView.swift
//  ScoutTrack
//
//  Created by Javius Loh on 26/5/25.
//

import SwiftUI

struct SummaryView: View {
    var body: some View {
        VStack{
            Text("Attendance Summary")
                .padding()
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(Color(hex: 0x115488))
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(hex: 0xbae4f2)
                .ignoresSafeArea()
        }    }
}

#Preview {
    SummaryView()
}
