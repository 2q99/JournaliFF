import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image("purplebook")
                .resizable()
                .scaledToFit()
                .frame(width: 190)

            Text("Begin Your Journal")
                .font(AppFont.titleCard)
                .foregroundStyle(Color("Purple"))

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(AppFont.bodySupporting)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60)
        }
    }
}
