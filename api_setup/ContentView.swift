import SwiftUI

struct URLImage : View {
    let urlString : String
    @State var data: Data?
     
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data){
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130 , height: 70)
                .background(Color.gray)
            
        }else{
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130 , height: 70)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                }
        }
    }
    private func fetchData(){
        guard let url = URL(string: urlString) else  {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _
            in
            self.data = data
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = Viewmodel()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(viewModel.memeData, id : \.id ){ course in
                    HStack {
                        URLImage(urlString: course.url )
                        Text(course.name)
                            .bold()
                    }
                    .padding(3)
                }
            }
            .navigationTitle("memes List")
            .onAppear{
                viewModel.fetch()
            }
        }
    }
}
    
    struct ContentView_Preview : PreviewProvider{
        static var previews: some View{
            ContentView()
        }
    }
