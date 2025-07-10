import SwiftUI
import Forever

struct TodayView: View {
    @Forever("attendanceLog") var attendanceLog: [DailyAttendance] = []
    
    let backgroundColor = Color(hex: 0xbae4f2)
    let mainTextColor = Color(hex: 0x115488)
    
    var body: some View {
        VStack{
            Text("CCA Attendance")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            NavigationStack {
                List {
                    ForEach(attendanceLog) { daily in
                        NavigationLink(value: daily) {
                            Text(daily.date)
                                .foregroundColor(mainTextColor)
                        }
                        .listRowBackground(backgroundColor)
                    }
                    .onDelete(perform: deleteDates)
                }
                .scrollContentBackground(.hidden)
                .background(backgroundColor.ignoresSafeArea())
                .navigationDestination(for: DailyAttendance.self) { daily in
                    AttendanceDetailView(dailyRecord: daily)
                }
            }
            .background(backgroundColor.ignoresSafeArea())
        }
    }
    
    func deleteDates(at offsets: IndexSet) {
        var newLog = attendanceLog
        newLog.remove(atOffsets: offsets)
        attendanceLog = newLog
    }
}

struct AttendanceDetailView: View {
    let dailyRecord: DailyAttendance
    
    let backgroundColor = Color(hex: 0xbae4f2)
    let mainTextColor = Color(hex: 0x115488)
    
    var body: some View {
        List {
            Section(header: Text("Records for \(dailyRecord.date)").foregroundColor(mainTextColor)) {
                ForEach(dailyRecord.records) { record in
                    HStack {
                        Text(record.name)
                            .foregroundColor(mainTextColor)
                        Spacer()
                        Text(record.status)
                            .foregroundColor(.gray)
                    }
                    .listRowBackground(backgroundColor)
                }
            }
        }
        .navigationTitle(dailyRecord.date)
        .scrollContentBackground(.hidden)
        .background(backgroundColor.ignoresSafeArea())
    }
}

#Preview {
    TodayView()
}
