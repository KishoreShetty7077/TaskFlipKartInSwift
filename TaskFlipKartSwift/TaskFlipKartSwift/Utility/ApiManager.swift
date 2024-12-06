//
//  ApiManager.swift
//  TaskFlipKartSwift
//
//  Created by Kishore B on 12/6/24.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()

    func fetchData<T: Decodable>(from urlString: String, modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Network Error", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
