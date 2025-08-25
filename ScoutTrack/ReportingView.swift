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

struct ExaResponse: Codable {
    let exa: [ExaMember]
}

struct ExaMember: Codable {
    let name: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name = "exa"
        case id
    }
}

struct NanoResponse: Codable {
    let nano: [NanoMember]
}

struct NanoMember: Codable {
    let name: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name = "nano"
        case id
    }
}

struct TeraResponse: Codable {
    let tera: [TeraMember]
}

struct TeraMember: Codable {
    let name: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name = "tera"
        case id
    }
}

struct ZettaResponse: Codable {
    let zetta: [ZettaMember]
}
struct ZettaMember: Codable {
    let name: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name = "zetta"
        case id
    }
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
                fetchExaMembers()
                fetchNanoMembers()
                fetchTeraMembers()
                fetchZettaMembers()
                setupInitialNames() // fallback for others
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
            exa = ["Updating..."]
                .map { AttendanceRecord(name: $0, patrol: "Exa", status: "Present") }
        }
        if nano.isEmpty {
            nano = ["Updating..."]
                .map { AttendanceRecord(name: $0, patrol: "Nano", status: "Present") }
        }

        if tera.isEmpty {
            tera = ["Updating..."]
                .map { AttendanceRecord(name: $0, patrol: "Tera", status: "Present") }
        }

        if zetta.isEmpty {
            zetta = ["Updating..."]
                .map { AttendanceRecord(name: $0, patrol: "Zetta", status: "Present") }
        }
    }

    func fetchExaMembers() {
        guard let url = URL(string: "https://api.sheety.co/c6a76e579b1880d17b088366d51aa03b/sstFearlessFalconScoutAttendance/exa") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let response = try JSONDecoder().decode(ExaResponse.self, from: data)
                DispatchQueue.main.async {
                    self.exa = response.exa.map {
                        AttendanceRecord(name: $0.name, patrol: "Exa", status: "Present")
                    }
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
    func fetchNanoMembers() {
        guard let url = URL(string: "https://api.sheety.co/c6a76e579b1880d17b088366d51aa03b/sstFearlessFalconScoutAttendance/nano") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let response = try JSONDecoder().decode(NanoResponse.self, from: data)
                DispatchQueue.main.async {
                    self.nano = response.nano.map {
                        AttendanceRecord(name: $0.name, patrol: "Nano", status: "Present")
                    }
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
    func fetchTeraMembers() {
        guard let url = URL(string: "https://api.sheety.co/c6a76e579b1880d17b088366d51aa03b/sstFearlessFalconScoutAttendance/tera") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let response = try JSONDecoder().decode(TeraResponse.self, from: data)
                DispatchQueue.main.async {
                    self.tera = response.tera.map {
                        AttendanceRecord(name: $0.name, patrol: "Tera", status: "Present")
                    }
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
    func fetchZettaMembers() {
        guard let url = URL(string: "https://api.sheety.co/c6a76e579b1880d17b088366d51aa03b/sstFearlessFalconScoutAttendance/zetta") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let response = try JSONDecoder().decode(ZettaResponse.self, from: data)
                DispatchQueue.main.async {
                    self.zetta = response.zetta.map {
                        AttendanceRecord(name: $0.name, patrol: "Zetta", status: "Present")
                    }
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
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
