//
//  NetworkLayer.swift
//  MyNewsTest
//
//  Created by Victor Mashukevich on 4.02.22.
//

import Foundation
class  NetworkLayer{
    static let basicURL: String = "https://newsapi.org/v2/everything?q="
    static let apipara: String = "&apiKey=963888c6c3de46a78fde1540963bf6dd"
    let test = URL(string: "https://newsapi.org/v2/top-headlines?country=us&sortBy=publishedAt&apiKey=963888c6c3de46a78fde1540963bf6dd")!

    
    func TakeNews(completion: @escaping (Result<[Articles?],Error >) -> ()) {
     
        
        let request = URLRequest(url: test)
        URLSession(configuration: .default).dataTask(with: request) { data, response, error in
           if let  error = error {
                completion(.failure(error))
                return
            }
            if let data = data,
            let urlResponse = response as? HTTPURLResponse,
               urlResponse.statusCode == 200 {
//                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                print(json)
                do{
                    let Newsresponse = try JSONDecoder().decode(parseres.self, from: data)
                
                    completion(.success(Newsresponse.articles))
                }catch{
                    completion(.failure(error))
                  
                }
            } else {
                completion(.failure(NetworkError.invalidData))
            }
        }.resume()
      
    }
}


enum NetworkError: Error {
    case invalidData
}



