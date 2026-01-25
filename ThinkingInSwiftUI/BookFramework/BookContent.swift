//
//  BookContent.swift
//  ThinkingInSwiftUI
//
//  Book content structure and organization
//

import SwiftUI

// MARK: - Book Structure

struct BookContent {
    let chapters: [BookChapter]

    /// Get total number of sections across all chapters
    var totalSections: Int {
        chapters.reduce(0) { $0 + $1.sections.count }
    }

    /// Get flat list of all sections in reading order
    var allSections: [BookSection] {
        chapters.flatMap { $0.sections }
    }

    /// Get section by global order
    func section(at order: Int) -> BookSection? {
        allSections.first { $0.order == order }
    }
}

// MARK: - Chapter

struct BookChapter: Identifiable {
    let id = UUID()
    let number: Int
    let title: String
    let icon: String
    let sections: [BookSection]

    /// Chapter progress (0.0 to 1.0)
    func progress(completed: Set<UUID>) -> Double {
        guard !sections.isEmpty else { return 0 }
        let completedCount = sections.filter { completed.contains($0.id) }.count
        return Double(completedCount) / Double(sections.count)
    }
}

// MARK: - Section

struct BookSection: Identifiable {
    let id: UUID
    let order: Int              // Global order: 1, 2, 3...
    let chapterNumber: Int
    let title: String
    let view: AnyView
    let estimatedMinutes: Int?

    /// Helper to create section with type-safe view
    init<Content: View>(
        order: Int,
        chapterNumber: Int,
        title: String,
        estimatedMinutes: Int? = nil,
        @ViewBuilder view: () -> Content
    ) {
        self.id = UUID()
        self.order = order
        self.chapterNumber = chapterNumber
        self.title = title
        self.estimatedMinutes = estimatedMinutes
        self.view = AnyView(view())
    }
}

// MARK: - Equatable & Hashable Conformance

extension BookSection: Equatable {
    static func == (lhs: BookSection, rhs: BookSection) -> Bool {
        lhs.id == rhs.id
    }
}

extension BookSection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
