import SwiftUI

struct JournalCardView: View {
    let entry: JournalEntry
    let onBookmark: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .top) {
                Text(entry.title)
                    .font(AppFont.titleCard)
                    .foregroundStyle(Color("journalPurple"))

                Spacer()

                Button(action: onBookmark) {
                    Image(systemName: entry.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.title2)
                        .foregroundStyle(Color("journalPurple"))
                }
                .buttonStyle(.plain)
            }

            Text(entry.date.formatted(date: .numeric, time: .omitted))
                .font(AppFont.captionS)
                .foregroundStyle(.secondary)

            Text(entry.text)
                .font(AppFont.captionM)
                .foregroundStyle(Color("primaryText"))
                .lineLimit(5)
                .padding(.top, 12)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("cardBackground"), in: RoundedRectangle(cornerRadius: 24))
    }
}
