import Foundation

struct JournalEntry: Identifiable {
    let id = UUID()
    var title: String
    var text: String
    var date: Date
    var isBookmarked: Bool = false

    static let samples = [
        JournalEntry(title: "My Birthday", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.", date: Date(), isBookmarked: true),
        JournalEntry(title: "Today's Journal", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.", date: Date()),
        JournalEntry(title: "Great Day", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.", date: Date())
    ]
}
