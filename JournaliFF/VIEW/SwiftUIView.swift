import SwiftUI
import Playgrounds
//JournalCardView: بطاقة تنشاف ← VIEW
struct WelcomeView: View {
    @State private var isActive = false //@State معناها: إذا تغيّرت قيمته، SwiftUI يعيد رسم الشاشة تلقائياً. بدونه الشاشة ما تدري إنها لازم تتغير.
    var body: some View {
        
        ZStack{
            if isActive {
                JournalListView()
            } else {
                
            
            VStack{
                Image("pinkbook")
                    .resizable()
                    .scaledToFit()
                    .frame(width:136, height: 130)
                Text("Journali")
                    .font(AppFont.display)
                    .padding(.top, 21)

                Text("Your thoughts, your story")
                    .font(AppFont.bodyM)
            }
            .task { //.task يشتغل تلقائياً أول ما تظهر الشاشة، بدون ما المستخدم يضغط شي.
                try? await Task.sleep(for: .seconds(2))
                withAnimation {
                    isActive = true
                }
                
            }
                
            }
        }
        .task {          // ← هنا، ملصوق بالـ ZStack
                try? await Task.sleep(for: .seconds(2))
                withAnimation {
                    isActive = true
                }
            }
    }
}
#Preview {
    WelcomeView()
}
