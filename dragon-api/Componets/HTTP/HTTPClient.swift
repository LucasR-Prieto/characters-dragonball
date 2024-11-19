//
//  HTTPClient.swift
//  dragon-api
//
//  Created by Lucas Prieto on 2024-11-15.
//

import Alamofire
class HTTPClient {
    
    static let shared = HTTPClient() // Singleton para acceso global
    private let baseURL = "https://dragonball-api.com/api"
    
    private init() {} 
    
    // Método genérico para GET
    func getRequest<T: Decodable>(
        endpoint: String,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let url = "\(baseURL)\(endpoint)"
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
            .validate() // Verifica status codes 200-299
            .responseJSON { response in
                // Imprime el JSON crudo para inspección
                switch response.result {
                case .success(let json):
                    print("✅ JSON recibido: \(json)")
                case .failure(let error):
                    print("❌ Error al obtener JSON: \(error.localizedDescription)")
                }
            }
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    // Método genérico para POST
    func postRequest<T: Decodable>(
        endpoint: String,
        parameters: [String: Any],
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let url = "\(baseURL)\(endpoint)"
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { response in
                // Imprime el JSON crudo para inspección
                switch response.result {
                case .success(let json):
                    print("✅ JSON recibido: \(json)")
                case .failure(let error):
                    print("❌ Error al obtener JSON: \(error.localizedDescription)")
                }
            }
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
