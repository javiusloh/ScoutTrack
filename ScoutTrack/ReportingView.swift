//
//  ReportingView.swift
//  ScoutTrack
//
//  Created by Javius Loh on 26/5/25.
//

import SwiftUI

struct NameStatusExa: Identifiable {
    let id = UUID()
    let name: String
    var status: String
}
struct NameStatusNano: Identifiable {
    let id = UUID()
    let name: String
    var status: String
}
struct NameStatusTera: Identifiable {
    let id = UUID()
    let name: String
    var status: String
}
struct NameStatusZetta: Identifiable {
    let id = UUID()
    let name: String
    var status: String
}
struct ReportingView: View {
    @Binding var reportingCode: String
    @State var showSheetLoginReport = false
    @State private var nameStatusesExa: [NameStatusExa] = []
    @State private var nameStatusesNano: [NameStatusNano] = []
    @State private var nameStatusesTera: [NameStatusTera] = []
    @State private var nameStatusesZetta: [NameStatusZetta] = []
    
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
                        ForEach($nameStatusesExa) { $entry in
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
                            .listRowBackground(Color(hex: 0xbae4f2))
                        }
                    }
                    Divider()
                        .listRowBackground(Color(hex: 0xbae4f2))
                    Section(header: Text("Patrol Nano").foregroundColor(mainTextColor)) {
                        ForEach($nameStatusesNano) { $entry in
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
                            .listRowBackground(Color(hex: 0xbae4f2))
                        }
                    }
                    Divider()
                        .listRowBackground(Color(hex: 0xbae4f2))
                    Section(header: Text("Patrol Tera").foregroundColor(mainTextColor)) {
                        ForEach($nameStatusesTera) { $entry in
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
                            .listRowBackground(Color(hex: 0xbae4f2))
                        }
                    }
                    Divider()
                        .listRowBackground(Color(hex: 0xbae4f2))
                    Section(header: Text("Patrol Zetta").foregroundColor(mainTextColor)) {
                        ForEach($nameStatusesZetta) { $entry in
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
                            .listRowBackground(Color(hex: 0xbae4f2))
                        }
                    }
                    Divider()
                        .listRowBackground(Color(hex: 0xbae4f2))
                }
                .scrollContentBackground(.hidden)
                .background(Color(hex: 0xbae4f2))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: 0xbae4f2).ignoresSafeArea()) // Only one background
            .navigationTitle("Today's Attendance")
            .onAppear {
                loadNamesExa()
                loadNamesNano()
                loadNamesTera()
                loadNamesZetta()
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

    func loadNamesExa() {
        let fetchedNamesExa = [
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
        nameStatusesExa = fetchedNamesExa.map { NameStatusExa(name: $0, status: "Present") }
    }
    
    func loadNamesNano() {
        let fetchedNamesNano = [
            "Gracelyn Gosal",
            "Gregory Tay Kai Yuan",
            "Jarius Wong Kai Zhe",
            "Kaiser Low",
            "Kiren Keshaun Pillai",
            "Marcus Effendi Xu",
            "Morgan Doan Luu",
            "Moy Ze Jun, Zelig",
            "Ng Jing Kai Matteo",
            "Tan Hai Ruii",
            "Tung Hong Jiang"
        ]
        nameStatusesNano = fetchedNamesNano.map { NameStatusNano(name: $0, status: "Present") }
    }
    func loadNamesTera() {
        let fetchedNamesTera = [
            "Andre Ryan Sung",
            "Austin Nilan Benedict",
            "Chee Yi Xiong",
            "Ho Zhan Beng, Nigel",
            "Javius Loh Jingwei",
            "Kaydan Renyi Mathenz",
            "Neo Yongyi",
            "Ong Cheng Feng",
            "Seow Ching Yang Keon",
            "Yeo Zi Qi"
        ]
        nameStatusesTera = fetchedNamesTera.map { NameStatusTera(name: $0, status: "Present") }
    }
    func loadNamesZetta() {
        let fetchedNamesZetta = [
            "Ayden Seah",
            "Chew Sing Hun",
            "Chin Yit Gin",
            "Dylan Christopher Lee Shing",
            "Hariram Ravikumar",
            "Isaac Woon Xin Wei",
            "Keagan Scott Ng Ooi Tong",
            "Lee Yu Le",
            "Manoharan Aharan",
            "Ted Tan"
        ]
        nameStatusesZetta = fetchedNamesZetta.map { NameStatusZetta(name: $0, status: "Present") }
    }
}

#Preview {
    ReportingView(reportingCode: .constant("000"))
}
