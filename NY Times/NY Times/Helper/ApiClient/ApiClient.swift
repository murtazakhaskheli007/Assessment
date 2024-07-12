//
//  ApiClient.swift
//  NY Times
//
//  Created by Ghulam Murtaza on 11/07/2024.
//

import Foundation

protocol APIManagerInterface {
    func request<T: Codable>(
        modelType: T.Type,
        type: ParameterManager,
        completion: @escaping ResultHandler<T>
    )
    func downloadImageFrom(url: URL, completion: @escaping(Data)-> Void)
}

final class APIManager:APIManagerInterface {

    private let networkHandler: NetworkHandlerInterface
    private let responseHandler: ResponseHandlerInterface

    init(networkHandler: NetworkHandlerInterface = NetworkHandler(),
         responseHandler: ResponseHandlerInterface = ResponseHandler()) {
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }

    func request<T: Codable>(
        modelType: T.Type,
        type: ParameterManager,
        completion: @escaping ResultHandler<T>
    )  where T : Codable {
        guard let url = URL(string: type.url)  else {
            completion(.failure(.invalidURL)) // I forgot to mention this in the video
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue

        if let parameters = type.body {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }

        request.allHTTPHeaderFields = type.headers

        // Network Request - URL TO DATA
        networkHandler.requestDataAPI(url: request) { result in
            switch result {
            case .success(let data):
                // Json parsing - Decoder - DATA TO MODEL
                self.responseHandler.parseResonseDecode(
                    data: data,
                    modelType: modelType) { response in
                        switch response {
                        case .success(let mainResponse):
                            completion(.success(mainResponse)) // Final
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    static var commonHeaders: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    
    func downloadImageFrom(url: URL, completion: @escaping(Data)-> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            completion(data)
        }.resume()
    }
}


protocol NetworkHandlerInterface {
    func requestDataAPI(
        url: URLRequest,
        completionHandler: @escaping (Result<Data, DataError>) -> Void
    )
}

class NetworkHandler:NetworkHandlerInterface {

    func requestDataAPI(
        url: URLRequest,
        completionHandler: @escaping (Result<Data, DataError>) -> Void
    ) {
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completionHandler(.failure(.invalidResponse))
                return
            }

            guard let data, error == nil else {
                completionHandler(.failure(.invalidData))
                return
            }
            completionHandler(.success(data))
        }
        session.resume()
    }
}

protocol ResponseHandlerInterface {
    func parseResonseDecode<T: Decodable>(
        data: Data,
        modelType: T.Type,
        completionHandler: ResultHandler<T>
    )
}

class ResponseHandler:ResponseHandlerInterface {
    
    func parseResonseDecode<T: Decodable>(
        data: Data,
        modelType: T.Type,
        completionHandler: ResultHandler<T>
    ) {
        do {
            let userResponse = try JSONDecoder().decode(modelType, from: data)
            completionHandler(.success(userResponse))
        }catch {
            completionHandler(.failure(.decoding(error)))
        }
    }
}
