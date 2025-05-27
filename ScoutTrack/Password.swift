import SwiftUI

struct Password: View {
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var isAuthenticated: Bool = false
    @State private var shakeOffset: CGFloat = 0
    @Binding var reportingCode: String

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Group {
                        if showPassword {
                            TextField("Password",
                                      text: $password,
                                      prompt: Text("Password").foregroundColor(Color(hex: 0x115488)))
                        } else {
                            SecureField("Password",
                                        text: $password,
                                        prompt: Text("Password").foregroundColor(Color(hex: 0x115488)))
                        }
                    }
                    .padding(10)
                    .background(Color(hex: 0xE6F6FC))
                    .cornerRadius(10)
                    .modifier(ShakeEffect(animatableData: shakeOffset)) // <-- updated!

                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(Color(hex: 0x115488))
                    }
                }
                .padding()

                Button {
                    if password == "cca" {
                        isAuthenticated = true
                    } else {
                        withAnimation(Animation.linear(duration: 0.4)) {
                            shakeOffset = 1
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            shakeOffset = 0 // reset after animation ends
                        }
                    }
                } label: {
                    Text("Login")
                        .foregroundColor(Color(hex: 0x115488))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: 0x6FAFD0))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .background(Color(hex: 0xBAE4F2))
            .ignoresSafeArea()
            .fullScreenCover(isPresented: $isAuthenticated) {
                TeacherMainView(reportingCode: $reportingCode)
            }
        }
    }
}

#Preview {
    Password(reportingCode: .constant("000"))
}

struct ShakeEffect: GeometryEffect {
    var animatableData: CGFloat
    let amplitude: CGFloat = 5
    let shakesPerUnit: CGFloat = 4

    func effectValue(size: CGSize) -> ProjectionTransform {
        let xOffset = sin(animatableData * .pi * shakesPerUnit * 2) * amplitude
        return ProjectionTransform(CGAffineTransform(translationX: xOffset, y: 0))
    }
}
