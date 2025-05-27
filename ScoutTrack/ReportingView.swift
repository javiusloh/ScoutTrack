//
//  ReportingView.swift
//  ScoutTrack
//
//  Created by Javius Loh on 26/5/25.
//

import SwiftUI
struct NameStatus: Identifiable {
    let id = UUID()
    let name: String
    var status: String
}
struct ReportingView: View {
    @Binding var reportingCode: String
    @State var showSheetLoginReport = false
    @State private var nameStatuses: [NameStatus] = []
    
    let attendanceOptions = ["Present", "NVR", "VR (Private)", "VR (Official)", "MC"]
    let mainTextColor = Color(hex: 0x115488)
    let backgroundColor = UIColor(red: 0xba/255, green: 0xe4/255, blue: 0xf2/255, alpha: 1)

    init(reportingCode: Binding<String>) {
        self._reportingCode = reportingCode

        // Custom Navigation Bar Appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor(Color(hex: 0x115488))]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(header: Text("Patrol Exa").foregroundColor(mainTextColor)) {
                        ForEach($nameStatuses) { $entry in
                            HStack {
                                Text(entry.name)
                                    .foregroundColor(mainTextColor)
                                Spacer()
                                Picker("", selection: $entry.status) {
                                    ForEach(attendanceOptions, id: \.self) { option in
                                        Text(option)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                            }
                            .padding(.vertical, 5)
                            .listRowBackground(Color(hex: 0xbae4f2)) // 👈 Set row background
                        }
                    }
                }
                .scrollContentBackground(.hidden) // 👈 Hide default List background
                .background(Color(hex: 0xbae4f2)) // 👈 Set custom background
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: 0xbae4f2).ignoresSafeArea()) // Only one background
            .navigationTitle("Today's Attendance")
            .onAppear {
                loadNames()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheetLoginReport = true
                    } label: {
                        Image(systemName: "house.fill")
                            .foregroundColor(mainTextColor)
                    }
                    .fullScreenCover(isPresented: $showSheetLoginReport) {
                        LoginView()
                    }
                }
            }
        }
    }

    func loadNames() {
        let fetchedNames = [
            "Aiden Tan Qian Yu",
            "Asyraf Islam Ibrahim",
            "Chiu Yong Zhi, Caleb",
            "Emmanuel Martin",
            "Jayren Guo Jieren",
            "Leow En Jie Ezav",
            "Mu Jiuyu William",
            "Quek Wei Xian Gabriel",
            "Tim Mao Feng, Aidan",
            "Yio Ti Chi"
        ]
        nameStatuses = fetchedNames.map { NameStatus(name: $0, status: "Not Marked") }
    }
}

#Preview {
    ReportingView(reportingCode: .constant("000"))
}
