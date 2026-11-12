import SwiftUI
import Playgrounds

struct WelcomeView: View {
    var body: some View {
        
        ZStack{
            LinearGradient(
                            colors: [Color("black"), Color("Grad")],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                .ignoresSafeArea()
            
            VStack{
                Image("pinkbook")
                    .resizable()
                    .scaledToFit()
                    .frame(width:136, height: 130)
                Text("Journali")
                    .foregroundStyle(.white)
                    .font(AppFont.display)
                    .padding(.top, 21)

                Text("Your thoughts, your story")
                    .font(AppFont.bodyM)
                    .foregroundStyle(.white)

                
            }
        }
    }
}
    #Preview {
        WelcomeView()
    }

