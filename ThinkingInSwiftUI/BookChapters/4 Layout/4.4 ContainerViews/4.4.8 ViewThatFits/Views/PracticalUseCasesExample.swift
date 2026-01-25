//
//  PracticalUseCasesExample.swift
//  ThinkingInSwiftUI
//
//  ViewThatFits - Practical Use Cases
//

import SwiftUI

struct PracticalUseCasesExample: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Text("Practical Use Cases")
                    .font(.title)
                    .bold()

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("1. Toolbar Buttons")
                            .font(.headline)

                        ViewThatFits {
                            HStack {
                                Button("Export to PDF") { }
                                Button("Share") { }
                                Button("Print") { }
                            }
                            .buttonStyle(.bordered)

                            HStack {
                                Button("Export") { }
                                Button("Share") { }
                                Button("Print") { }
                            }
                            .buttonStyle(.bordered)

                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Image(systemName: "square.and.arrow.up.on.square")
                                Image(systemName: "printer")
                            }
                        }
                        .border(Color.gray)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("2. Navigation Title")
                            .font(.headline)

                        ViewThatFits {
                            Text("User Profile Settings and Preferences")
                                .font(.largeTitle)
                                .bold()

                            Text("Profile Settings")
                                .font(.title)
                                .bold()

                            Text("Settings")
                                .font(.title2)
                                .bold()
                        }
                        .border(Color.gray)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("3. Form Layout")
                            .font(.headline)

                        ViewThatFits {
                            HStack {
                                Text("Email Address:")
                                    .frame(width: 120, alignment: .trailing)
                                TextField("email@example.com", text: .constant(""))
                                    .textFieldStyle(.roundedBorder)
                            }

                            VStack(alignment: .leading) {
                                Text("Email Address:")
                                TextField("email@example.com", text: .constant(""))
                                    .textFieldStyle(.roundedBorder)
                            }
                        }
                        .border(Color.gray)
                    }
                })

                GroupBox(label: EmptyView(), content: {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Key Takeaways")
                            .font(.headline)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("✓ Use for responsive layouts without GeometryReader")
                                .font(.caption)
                            Text("✓ Order from most spacious to most compact")
                                .font(.caption)
                            Text("✓ Last option is the fallback - make it compact")
                                .font(.caption)
                            Text("✓ Great for text truncation, icon-only fallbacks, layout changes")
                                .font(.caption)
                            Text("✗ Don't use for complex logic - keep it simple")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                })
            }
            .padding()
        }
    }
}

#Preview {
    PracticalUseCasesExample()
}
