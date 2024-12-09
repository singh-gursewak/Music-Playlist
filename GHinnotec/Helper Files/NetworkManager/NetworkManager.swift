//
//  NetworkManager.swift



import UIKit

protocol APIModel : Codable {
    var status: String? { get }
    var statusCode:Int? { get }
    var message: String? { get }
}
enum NetworkResponse :String {
    case success
    case authenticationError = "You need to authenticate first."
    case badRequest          = "Bad Request"
    case outdated            = "The url you requested is outdated."
    case failed              = "Network request failed."
    case noData              = "Response returned with no data to decode."
    case unableToDecode      = "we couldn't decode the response"
}
enum APIResult<String>{
    case success
    case failure(String)
}
enum APIError :Error{
    case errorReport(desc:String)
}
