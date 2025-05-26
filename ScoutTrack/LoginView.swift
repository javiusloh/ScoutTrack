//
//  LoginView.swift
//  ScoutTrack
//
//  Created by Javius Loh on 26/5/25.
//

import SwiftUI

struct LoginView: View {
    @State var showSheetTeacher = false
    @State var showSheetReporting = false

    var body: some View {
        VStack{
            Image("FearlessFalconLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
                .padding()
            Text("Welcome to")
                .fontWeight(.bold)
                .font(.system(size: 56))
                .foregroundColor(Color(hex: 0x115488))

            Text("ScoutTrack")
                .fontWeight(.bold)
                .font(.system(size: 56))
                .foregroundColor(Color(hex: 0x115488))
            VStack{
                Button{
                    showSheetTeacher = true
                }label:{
                    ZStack{
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .foregroundColor(Color(hex: 0x6FAFD0))
                        Text("Scout Leader")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(Color(hex: 0x115488))
                    }
                }
                .sheet(isPresented: $showSheetTeacher) {
                    Password()
                        .presentationDetents([.height(200), .medium, .large])
                        .presentationDragIndicator(.automatic)
                }
                Button{
                    showSheetReporting = true
                }label:{
                    ZStack{
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .foregroundColor(Color(hex: 0x6FAFD0))
                        Text("Reporting IC")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(Color(hex: 0x115488))
                    }
                }
                .fullScreenCover(isPresented: $showSheetReporting) {
                    ReportingView()
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(hex: 0xbae4f2)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    LoginView()
}
