//
//  NetworkProvider.swift
//  pre_onboarding
//
//  Created by 홍성준 on 2023/02/17.
//

import Foundation

final class NetworkProvider<Target: TargetType> {
    
    typealias Target = TargetType
    
    func request<Response: Decodable>(_ target: Target) async throws -> Response {
        do {
            var urlRequest = try self.encodeTarget(target)
            urlRequest.httpMethod = target.method.rawValue
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            try self.validateResponse(response: response)
            let result: Response = try self.decodeData(data: data)
            return result
        } catch {
            throw error
        }
    }
    
    private func encodeTarget(_ target: Target) throws -> URLRequest {
        let absoluteStringURL = target.baseURL + target.path
        
        switch target.task {
        case .requestPlain:
            guard let url = URL(string: absoluteStringURL) else { throw NetworkError.invalidRequest.error }
            return URLRequest(url: url)
        }
    }
    
    private func validateResponse(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.responseError.error
        }
    }
    
    private func decodeData<Response: Decodable>(data: Data) throws -> Response {
        return try JSONDecoder().decode(Response.self, from: data)
    }
    
}
