import SwiftUI

struct ContentView: View {
    @State var image: UIImage? = nil      // 選択された写真
    @State var showSheet = false          // 各種シートの開閉状態を管理
    @State var showActionSheet = false    // アクションシートの開閉状態を管理
    @State var isCamera = false           // UIImagePickerControllerの使用
    @State var isLibrary = false          // PHPickerControllerの使用
    
    var body: some View {

        ZStack {
            VStack {
                Spacer()
                Button(action: {
                    image = nil             // imageを初期化
                    showActionSheet = true  // アクショシートを開く
                }) {
                    Text("写真を選択")
                        .padding()
                        .frame(width: 200, height: 60)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 3))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.black)
                        .font(.title)
                }
                .padding()
            }
            
            // シート
            .sheet(isPresented: $showSheet) {
                if let unwrapCaptureImage = image {
                    ImageView(showSheet: $showSheet, image: unwrapCaptureImage)
                } else {
                    if isCamera && !isLibrary {
                        UIImagePickerView(showSheet: $showSheet, image: $image)
                    } else if !isCamera && isLibrary {
                        PHPickerView(showSheet: $showSheet, image: $image)
                    }
                }
            }
            
            // アクションシート
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("確認"),
                            message: Text("選択してください"),
                            buttons: [
                    .default(Text("UIImagePickerController"), action: {
                        // カメラが利用可能かチェック
                        if UIImagePickerController.isSourceTypeAvailable(.camera){
                            isCamera = true
                            isLibrary = false
                            showSheet = true
                        }
                    }),
                    .default(Text("PHPickerController"), action: {
                        isCamera = false
                        isLibrary = true
                        showSheet = true
                    }),
                    .cancel(),
                ])
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
