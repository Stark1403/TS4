//
//  Connection.swift
//  TestTS4
//
//  Created by cesar.torres on 14/06/23.
//

import Foundation

public class Connection {
    
    func connectionRequest<T: Decodable>(url: String, method: HTTPMethod, closure: @escaping ((Result<T?>) -> Void)) {
        guard  let request = createRequest(url: url, method: method) else {
            closure(.failure("Generic.errorGetInformation".localized))
            return
        }
        startRequest(request: request) { (data, error) in
            DispatchQueue.main.async {
                if let error = error {
                    closure(.failure(error))
                    return
                }
                guard let data = data else {
                    closure(.failure("Generic.errorGetInformation".localized))
                    return
                }
                do {
                    let jsonDecoder = JSONDecoder()
                    let response = try jsonDecoder.decode(T.self, from: data)
                    closure(.success(response))
                } catch {
                    closure(.failure("Generic.errorGetInformation".localized))
                }
            }
        }
    }

    private func startRequest(request: URLRequest, closure: @escaping (Data?,String?) -> Void) {
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if(error != nil){
                closure(nil,"Generic.notEthernet".localized)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else{
                return
            }
            switch(httpResponse.statusCode){
            case 200:
                closure(data,nil)
                self.printEvent(event: "Servicio exitoso")
                break
            case 404:
                closure(nil,"Generic.errorService".localized)
                self.printEvent(event: "Servicio no Encontrado")
                break
            case 500:
                closure(nil,"Generic.errorGetInformation".localized)
                self.printEvent(event: "Error en el Servicio")
                break
            default:
                closure(nil,"el servicio regreso un codigo \(httpResponse.statusCode)")
                self.printEvent(event: "el servicio regreso un codigo \(httpResponse.statusCode)")
                break
            }
        }
        session.resume()
    }
    
    private func printEvent(event: Any) {
        print(event)
    }
    
    private func createRequest(url:  String, method: HTTPMethod) -> URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
}

public enum HTTPMethod: String {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case trace = "TRACE"
}

enum Result<T> {
    case success(T)
    case failure(String)
}
