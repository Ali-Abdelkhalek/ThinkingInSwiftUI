//
//  SimpleBookReader.swift
//  ThinkingInSwiftUI
//
//  Simple book navigation with menu button
//

import SwiftUI

struct SimpleBookReader: View {
    let book: BookContent
    @State private var currentSection: BookSection
    @State private var showMenu = false

    init(book: BookContent) {
        self.book = book
        self._currentSection = State(initialValue: book.allSections.first!)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Breadcrumb Bar
                BreadcrumbBar(
                    chapterNumber: currentChapter?.number ?? 0,
                    chapterTitle: currentChapter?.title ?? "",
                    chapterIcon: currentChapter?.icon ?? "book",
                    topicTitle: currentTopic?.title ?? "",
                    sectionNumber: currentSection.sectionNumber,
                    sectionTitle: currentSection.title
                )

                Divider()

                // Content
                currentSection.view
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                Divider()

                // Navigation Bar
                HStack(spacing: 0) {
                    // Previous
                    Button {
                        if let prev = previousSection {
                            currentSection = prev
                        }
                    } label: {
                        Label("Previous", systemImage: "chevron.left")
                    }
                    .disabled(previousSection == nil)
                    .frame(maxWidth: .infinity, alignment: .leading)

                    // Current section info (tappable to open menu)
                    Button {
                        showMenu = true
                    } label: {
                        HStack(spacing: 4) {
                            Text(currentSection.sectionNumber)
                                .font(.caption)
                                .fontWeight(.semibold)
                            Image(systemName: "chevron.down")
                                .font(.caption2)
                        }
                        .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    // Next
                    Button {
                        if let next = nextSection {
                            currentSection = next
                        }
                    } label: {
                        Label("Next", systemImage: "chevron.right")
                            .labelStyle(.trailingIcon)
                    }
                    .disabled(nextSection == nil)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
                .background(Color(.systemBackground))
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showMenu) {
                NavigationStack {
                    MenuView(
                        book: book,
                        currentSection: currentSection,
                        onSelectSection: { section in
                            currentSection = section
                            showMenu = false
                        }
                    )
                }
                .presentationDetents([.medium, .large])
            }
        }
    }

    var previousSection: BookSection? {
        book.section(at: currentSection.order - 1)
    }

    var nextSection: BookSection? {
        book.section(at: currentSection.order + 1)
    }

    var currentChapter: BookChapter? {
        book.chapters.first { chapter in
            chapter.topics.contains { topic in
                topic.sections.contains { $0.id == currentSection.id }
            }
        }
    }

    var currentTopic: BookTopic? {
        currentChapter?.topics.first { topic in
            topic.sections.contains { $0.id == currentSection.id }
        }
    }
}

// MARK: - Breadcrumb Bar

fileprivate struct BreadcrumbBar: View {
    let chapterNumber: Int
    let chapterTitle: String
    let chapterIcon: String
    let topicTitle: String
    let sectionNumber: String
    let sectionTitle: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: chapterIcon)
                .foregroundColor(.blue)
                .font(.caption)

            Text("Ch \(chapterNumber)")
                .font(.caption)
                .foregroundColor(.secondary)

            Image(systemName: "chevron.right")
                .font(.caption2)
                .foregroundColor(.secondary)

            Text(topicTitle)
                .font(.caption)
                .foregroundColor(.secondary)

            Image(systemName: "chevron.right")
                .font(.caption2)
                .foregroundColor(.secondary)

            Text(sectionNumber)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.blue)

            Text(sectionTitle)
                .font(.caption)
                .fontWeight(.medium)

            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 12)
        .padding(.bottom, 8)
        .background(Color(uiColor: .secondarySystemBackground))
    }
}

// MARK: - Menu View

fileprivate struct MenuView: View {
    let book: BookContent
    let currentSection: BookSection
    let onSelectSection: (BookSection) -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            ForEach(book.chapters) { chapter in
                Section {
                    ForEach(chapter.topics) { topic in
                        Section {
                            ForEach(topic.sections) { section in
                                Button {
                                    onSelectSection(section)
                                } label: {
                                    HStack {
                                        Text(section.sectionNumber)
                                            .font(.caption)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .frame(width: 55, height: 28)
                                            .background(section.id == currentSection.id ? Color.blue : Color.gray)
                                            .clipShape(Capsule())

                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(section.title)
                                                .foregroundColor(.primary)

                                            if let minutes = section.estimatedMinutes {
                                                Text("\(minutes) min")
                                                    .font(.caption2)
                                                    .foregroundColor(.secondary)
                                            }
                                        }

                                        Spacer()

                                        if section.id == currentSection.id {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                            }
                        } header: {
                            HStack {
                                Text(topic.topicNumber)
                                    .fontWeight(.semibold)
                                Text(topic.title)
                            }
                            .font(.subheadline)
                        }
                    }
                } header: {
                    HStack {
                        Image(systemName: chapter.icon)
                        Text("Chapter \(chapter.number): \(chapter.title)")
                    }
                    .font(.headline)
                }
            }
        }
        .navigationTitle("Table of Contents")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

// Helper for trailing icon label
fileprivate struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: TrailingIconLabelStyle { .init() }
}
