import SwiftUI

struct JournalListView: View {
    @StateObject private var viewModel = JournalListViewModel()
    @State private var showEditor = false
    @State private var showDeleteAlert = false
    @State private var entryToDelete: JournalEntry?

    var body: some View {

            VStack(spacing: 0) {
                headerView

                if viewModel.entries.isEmpty {
                    Spacer()
                    EmptyStateView()
                    Spacer()
                } else {
                    entriesList
                }

                searchBar
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

    // العنوان + كبسولة الأزرار
    private var headerView: some View {
        HStack {
            Text("Journal")
                .font(AppFont.headingL)
                .foregroundStyle(.white)

            Spacer()

            HStack(spacing: 20) {
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
            .font(.title3)
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 8)
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

    // شريط البحث
    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)

            TextField("", text: $viewModel.searchText,
                      prompt: Text("Search").foregroundStyle(.gray))
                .foregroundStyle(.white)

            Image(systemName: "mic.fill")
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.white.opacity(0.1), in: Capsule())
        .padding(.horizontal, 24)
        .padding(.bottom, 12)
    }
}

#Preview {
    JournalListView()
}
