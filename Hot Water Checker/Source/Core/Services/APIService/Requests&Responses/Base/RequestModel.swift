import Foundation

enum RequestHTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class RequestModel: NSObject {
    
    // MARK: - Properties
    var path: String {
        return ""
    }
    var parameters: [String: Any?] {
        return [:]
    }
    var headers: [String: String] {
        return [:]
    }
    var method: RequestHTTPMethod {
        return body.isEmpty ? RequestHTTPMethod.get : RequestHTTPMethod.post
    }
    var body: [String: Any?] {
        return [:]
    }
}

// MARK: - Public Functions
extension RequestModel {
    
    func urlRequest() -> URLRequest {
        var endpoint: String = APIServiceManager.shared.baseURL.appending(path)
        
        parameters.forEach {
            if let value = $0.value as? String {
                endpoint.append("?\($0.key)=\(value)")
            }
        }
        
        let endpointURL = URL(string: endpoint)
        var request: URLRequest = URLRequest(url: endpointURL!)
        request.httpMethod = method.rawValue
        
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        if method == RequestHTTPMethod.post {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch let error {
                assertionFailure("Request body parse error: \(error.localizedDescription)")
            }
        }
        
        return request
    }
}
