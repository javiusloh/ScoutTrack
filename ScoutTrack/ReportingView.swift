import SwiftUI
import Forever


struct AttendanceRecord: Identifiable, Codable, Hashable {
    let id = UUID()
    let name: String
    let patrol: String
    var status: String
}

struct DailyAttendance: Identifiable, Codable, Hashable {
    let id = UUID()
    let date: String
    var records: [AttendanceRecord]
}

struct ReportingView: View {
    @Binding var reportingCode: String
    @State private var showSheetLoginReport = false
    @Forever("attendanceLog") var attendanceLog: [DailyAttendance] = []

    @State private var exa: [AttendanceRecord] = []
    @State private var nano: [AttendanceRecord] = []
    @State private var tera: [AttendanceRecord] = []
    @State private var zetta: [AttendanceRecord] = []

    @Environment(\.dismiss) var dismiss
    @State private var showSavedAlert = false

    let attendanceOptions = ["Present", "NVR", "VR (Private)", "VR (Official)", "MC"]
    let mainTextColor = Color(hex: 0x115488)
    let backgroundColor = UIColor(red: 0xba/255, green: 0xe4/255, blue: 0xf2/255, alpha: 1)

    init(reportingCode: Binding<String>) {
        self._reportingCode = reportingCode

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
                    attendanceSection("Exa", records: $exa)
                    attendanceSection("Nano", records: $nano)
                    attendanceSection("Tera", records: $tera)
                    attendanceSection("Zetta", records: $zetta)
                }
                .scrollContentBackground(.hidden)
                .background(Color(hex: 0xbae4f2))

                Button("Save Attendance") {
                    saveTodayAttendance()
                    showSavedAlert = true
                }
                .padding()
                .foregroundColor(Color(hex: 0x115488))
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(Color(hex: 0x6FAFD0))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                .alert("Attendance saved!", isPresented: $showSavedAlert) {
                    Button("OK") {
                        reportingCode = "Expired"
                        dismiss()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: 0xbae4f2).ignoresSafeArea())
            .navigationTitle("Today's Attendance")
            .onAppear {
                setupInitialNames()
            }
        }
    }

    func attendanceSection(_ patrol: String, records: Binding<[AttendanceRecord]>) -> some View {
        Section(header: Text("Patrol \(patrol)").foregroundColor(mainTextColor)) {
            ForEach(records) { $record in
                HStack {
                    Text(record.name).foregroundColor(mainTextColor)
                    Spacer()
                    Picker("", selection: $record.status) {
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
    }

    func setupInitialNames() {
        if exa.isEmpty {
            exa = ["Aiden Tan Qian Yu", "Asyraf Islam Ibrahim", "Chiu Yong Zhi, Caleb", "Emmanuel Martin",
                   "Jayren Guo Jieren", "Leow En Jie Ezav", "Mu Jiuyu William",
                   "Quek Wei Xian Gabriel", "Tim Mao Feng, Aidan", "Yio Ti Chi"]
                .map { AttendanceRecord(name: $0, patrol: "Exa", status: "Present") }
        }

        if nano.isEmpty {
            nano = ["Gracelyn Gosal", "Gregory Tay Kai Yuan", "Jarius Wong Kai Zhe", "Kaiser Low",
                    "Kiren Keshaun Pillai", "Marcus Effendi Xu", "Morgan Doan Luu",
                    "Moy Ze Jun, Zelig", "Ng Jing Kai Matteo", "Tan Hai Ruii", "Tung Hong Jiang"]
                .map { AttendanceRecord(name: $0, patrol: "Nano", status: "Present") }
        }

        if tera.isEmpty {
            tera = ["Andre Ryan Sung", "Austin Nilan Benedict", "Chee Yi Xiong", "Ho Zhan Beng, Nigel",
                    "Javius Loh Jingwei", "Kaydan Renyi Mathenz", "Neo Yongyi",
                    "Ong Cheng Feng", "Seow Ching Yang Keon", "Yeo Zi Qi"]
                .map { AttendanceRecord(name: $0, patrol: "Tera", status: "Present") }
        }

        if zetta.isEmpty {
            zetta = ["Ayden Seah", "Chew Sing Hun", "Chin Yit Gin", "Dylan Christopher Lee Shing",
                     "Hariram Ravikumar", "Isaac Woon Xin Wei", "Keagan Scott Ng Ooi Tong",
                     "Lee Yu Le", "Manoharan Aharan", "Ted Tan"]
                .map { AttendanceRecord(name: $0, patrol: "Zetta", status: "Present") }
        }
    }

    func saveTodayAttendance() {
        let todayDate = formattedToday()

        var combinedRecords: [AttendanceRecord] = []
        combinedRecords.append(contentsOf: exa)
        combinedRecords.append(contentsOf: nano)
        combinedRecords.append(contentsOf: tera)
        combinedRecords.append(contentsOf: zetta)

        let newDaily = DailyAttendance(date: todayDate, records: combinedRecords)
        attendanceLog.append(newDaily)
    }

    func formattedToday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: Date())
    }
}

#Preview {
    ReportingView(reportingCode: .constant("000"))
}
