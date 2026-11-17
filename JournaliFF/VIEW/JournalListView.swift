import SwiftUI

struct JournalListView: View {
    @StateObject private var viewModel = JournalListViewModel()
    @State private var showEditor = false
    @State private var showDeleteAlert = false
    @State private var entryToDelete: JournalEntry?

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if viewModel.entries.isEmpty {
                    Spacer()
                    EmptyStateView()
                    Spacer()
                } else {
                    entriesList
                }

                searchBar
            }
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Menu {
                        Button("Sort by Bookmark") { viewModel.sortOption = .bookmark }
                        Button("Sort by Entry Date") { viewModel.sortOption = .date }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }

                    Button {
                        showEditor = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showEditor) {
                Text("صفحة الكتابة: الخطوة الجاية")
            }
            .alert("Delete Journal?", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    if let entry = entryToDelete {
                        viewModel.delete(entry)
                    }
                }
            } message: {
                Text("Are you sure you want to delete this journal?")
            }
        }
    }

    // قائمة اليوميات
    private var entriesList: some View {
        List {
            ForEach(viewModel.displayedEntries) { entry in
                JournalCardView(entry: entry) {
                    viewModel.toggleBookmark(entry)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button {
                        entryToDelete = entry
                        showDeleteAlert = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }

    // شريط البحث بتأثير الزجاج
    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)

            TextField("", text: $viewModel.searchText,
                      prompt: Text("Search").foregroundStyle(.gray))

            Image(systemName: "mic.fill")
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .glassEffect(.regular, in: .capsule)
        .padding(.horizontal, 24)
        .padding(.bottom, 12)
    }
}

#Preview {
    JournalListView()
        .preferredColorScheme(.dark)
}
