//
//  LoggedIn.swift
//  MrArthur
//
//  Created by Nirav Patel on 23/09/22.
//


import SwiftUI
import Intercom

struct LoggedInView: View {
    
    @Binding var email: String
    @Binding var loggedIn: Bool
    
    var body: some View {
        VStack(spacing:15) {
            StylizedButton("Message", action: openMessenger)
        }
    }
    
    func openMessenger() {
        Intercom.presentMessenger()
    }

    
}
struct StylizedButton: View {
    
    let title: String
    let action: () -> Void
    
    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: 350, minHeight: 44)
                .foregroundColor(.white)
                .background(Color.primaryRed)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }.buttonStyle(PlainButtonStyle())
    }
    
}

struct IntercomButton_Previews: PreviewProvider {
    static var previews: some View {
        StylizedButton("Button", action: {})
    }
}

struct LoggedOutView: View {

    @Binding var email: String
    @Binding var loggedIn: Bool

    var body: some View {
        VStack(spacing: 25) {
            StylizedTextField(title: "Email", text: $email, onCommit: loginToIntercom)
                .frame(maxWidth: 350)
            StylizedButton("Login", action: loginToIntercom)
                .disabled(email.isEmpty)
        }
    }

    func loginToIntercom() {
        let attributes = ICMUserAttributes()
        attributes.email = email
        Intercom.loginUser(with: attributes) { result in
            switch result {
            case .success:
                let defaults = UserDefaults.standard
                defaults.set(email, forKey: "email")
                loggedIn = true
            case .failure(let error): print("Error logging in: \(error.localizedDescription)")
            }
        }
    }
}
extension Text {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

fileprivate struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textCase(.uppercase)
            .font(.caption)
            .frame(alignment: .leading)
    }
}
struct StylizedTextField: View {
    
    let title: String
    @Binding var text: String
    let onCommit: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing:0) {
            Text(title)
                .titleStyle()
            TextField(LocalizedStringKey(title), text: $text, onCommit: onCommit)
                .keyboardType(.emailAddress)
                .frame(maxWidth: 300, minHeight: 44)
            Rectangle()
                .frame(height: 1.0, alignment: .bottom)
                .foregroundColor(Color.gray)
        }
    }
    
}
