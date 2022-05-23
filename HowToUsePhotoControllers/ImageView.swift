import SwiftUI

struct ImageView: View {
    @Binding var showSheet: Bool     // シートの開閉状態を管理
    var image: UIImage               // 選択された写真
    @State var showImage: UIImage?   // 表示する写真
    
    var body: some View {
        VStack {
            Spacer()
            if let unwrapShowImage = showImage {
                Image(uiImage: unwrapShowImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            
            Button(action: {
                showSheet = false
            }) {
                Text("最初に戻る")
                    .padding()
                    .frame(width: 200, height: 60)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 3))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                    .font(.title)
            }
            .padding()
            
            Spacer()
        }
        // シートが表示されるときに実行される
        .onAppear {
            showImage = image
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(
            showSheet: Binding.constant(true),
            image: UIImage(named: "preview_use")!)
    }
}
