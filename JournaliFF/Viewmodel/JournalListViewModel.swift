import SwiftUI
import Combine
enum SortOption {
    case date
    case bookmark
}

class JournalListViewModel: ObservableObject {
    @Published var entries: [JournalEntry] = []
    @Published var searchText = ""
    @Published var sortOption: SortOption = .date

    // القائمة اللي تنعرض: بعد البحث والترتيب
    var displayedEntries: [JournalEntry] {
        var result = entries

        if !searchText.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.text.localizedCaseInsensitiveContains(searchText)
            }
        }

        result.sort { a, b in
            if sortOption == .bookmark && a.isBookmarked != b.isBookmarked {
                return a.isBookmarked
            }
            return a.date > b.date
        }
        return result
    }

    func add(title: String, text: String) {
        entries.append(JournalEntry(title: title, text: text, date: Date()))
    }

    func toggleBookmark(_ entry: JournalEntry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index].isBookmarked.toggle()
        }
    }

    func delete(_ entry: JournalEntry) {
        entries.removeAll { $0.id == entry.id }
    }
    
}
