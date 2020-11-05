import Foundation

final class APIServiceManager {
    //MARK: - Properties
    public static let shared: APIServiceManager = APIServiceManager()
    public let baseURL: String = "https://api.gu.spb.ru/UniversalMobileService"
}



//MARK: - Public
extension APIServiceManager {
    
    func sendRequest<T: Codable>(request: RequestModel,
                                 completion: @escaping(Swift.Result<T, ResponseErrorModel>) -> Void) {
        
        URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
            
            guard let data = data else {
                completion(Result.failure(ResponseErrorModel(.parsingError)))
                return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                completion(Result.failure(ResponseErrorModel(.parsingError)))
                return
            }
            
            completion(Result.success(decodedResponse))
            
        }.resume()
    }
}
