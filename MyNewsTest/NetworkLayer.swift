//
//  NetworkLayer.swift
//  MyNewsTest
//
//  Created by Victor Mashukevich on 4.02.22.
//

import Foundation
class  NetworkLayer{
    let response = URL(string: "https://newsapi.org/v2/top-headlines?country=ru&sortBy=publishedAt&apiKey=963888c6c3de46a78fde1540963bf6dd")!

    
    func TakeNews(completion: @escaping (Result<[Articles?],Error >) -> ()) {
     
        
        let request = URLRequest(url: response)
        URLSession(configuration: .default).dataTask(with: request) { data, response, error in
           if let  error = error {
                completion(.failure(error))
                return
            }
            if let data = data  {
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



