////
////  TodayAttendanceSelect.swift
////  ScoutTrack
////
////  Created by Javius Loh on 27/5/25.
////
//
//import SwiftUI
//
//struct NameStatus: Identifiable {
//    let id = UUID()
//    let name: String
//    var status: String
//}
//
//struct TodayAttendanceSelect: View {
//    @State private var nameStatuses: [NameStatus] = []
//    
//    let attendanceOptions = ["Present", "Absent", "Late", "Excused", "Not Marked"]
//
//    var body: some View {
//        NavigationView {
//            List {
//                Section(header: Text("Patrol Exa")){
//                    ForEach($nameStatuses) { $entry in
//                        HStack {
//                            Text(entry.name)
//                            Spacer()
//                            Picker("", selection: $entry.status) {
//                                ForEach(attendanceOptions, id: \.self) { option in
//                                    Text(option)
//                                }
//                            }
//                            .pickerStyle(MenuPickerStyle())
//                        }
//                        .padding(.vertical, 5)
//                    }
//                }
//                
//            }
//            .navigationTitle("Today's Attendance")
//            .onAppear {
//                loadNames()
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background {
//                Color(hex: 0xbae4f2)
//                    .ignoresSafeArea()
//            }
//        }
//    }
//    
//    /// This function simulates pulling names from Google Sheets.
//    /// Replace this in future with an actual API call.
//    func loadNames() {
//        let fetchedNames = ["Aiden Tan Qian Yu",
//                            "Asyraf Islam Ibrahim",
//                            "Chiu Yong Zhi, Caleb",
//                            "Emmanuel Martin",
//                            "Jayren Guo Jieren",
//                            "Leow En Jie Ezav",
//                            "Mu Jiuyu William",
//                            "Quek Wei Xian Gabriel",
//                            "Tim Mao Feng, Aidan",
//                            "Yio Ti Chi"]
//        nameStatuses = fetchedNames.map { NameStatus(name: $0, status: "Not Marked") }
//    }
//}
//
//
//#Preview {
//    TodayAttendanceSelect()
//}
