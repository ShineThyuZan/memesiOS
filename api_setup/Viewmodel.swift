import Foundation
import SwiftUI


struct Course: Hashable, Codable{
    let name : String
    let image : String
}

class Viewmodel : ObservableObject {
    @Published var memeData: [Meme] = []
    
    func fetch(){
//    https://catfact.ninja/breeds
//        let urlStirng = "https:://iosacademy.io/api/v1/courses/index.php"
        let urlStirng = "https://api.imgflip.com/get_memes"
        guard let url = URL(string: urlStirng) else {
            return
        }
        
        print("url ::: \(url.absoluteString)")
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){ [weak
            self] data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            // convert to json
            do{
                let response = try JSONDecoder().decode(MemeModel.self, from: data)
                print("response.data ::: \(response.success)")
                if(response.success){
                    DispatchQueue.main.async {
                        self?.memeData = response.data.memes
                    }
                }
                
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}
