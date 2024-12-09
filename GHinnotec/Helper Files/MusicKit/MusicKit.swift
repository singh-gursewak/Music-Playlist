//  MusicKit.swift

import Foundation
import Foundation
import UIKit
import StoreKit

final class AppleMusicKit : NSObject {
    
    static let shared = AppleMusicKit()
    let developerToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiIsImtpZCI6IjhRMkY0VTlNOTMifQ.eyJpc3MiOiI2WDhUUDRCSkg2IiwiaWF0IjoxNjczNTE1NDczLjM3ODMxNTksImV4cCI6MTY3ODY5OTQ3My4zNzgzMTU5fQ.JLMTMGmpTWnoSJzrGw1WcVRJV4hQCpr4klj4paAIY_YyEsdIDg0KV9uhK-IbYDPP-jTnzcF6PNW_w2FRIIchgg"
    var userToken = ""
    var songs = [ResultData]()

    func fetchStorefrontID() -> String {
        let lock = DispatchSemaphore(value: 0)
        var storefrontID: String!
        
        let musicURL = URL(string: "https://api.music.apple.com/v1/me/storefront")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        musicRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
        
        URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
            guard error == nil else { return }
            
            if let json = try? JSON(data: data!) {
                let result = (json["data"]).array!
                let id = (result[0].dictionaryValue)["id"]!
                storefrontID = id.stringValue
                lock.signal()
            }
        }.resume()
        
        lock.wait()
        return storefrontID
    }
    
    func requestAuthorization(completion: @escaping((Bool) -> ())) {
        SKCloudServiceController.requestAuthorization { (authStatus) in
            if authStatus == .authorized {
                print("Authorized")
                completion(true)
            } else {
                print("Not Authorized")
                completion(false)
            }
        }
    }
    
    func searchAppleMusic(_ searchTerm: String!, completion: @escaping(([Song]) -> ())) {
        var songs = [Song]()
        
        let musicURL = URL(string: "https://api.music.apple.com/v1/catalog/\(fetchStorefrontID())/search?term=\(searchTerm.replacingOccurrences(of: " ", with: "+"))&types=songs&limit=25")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        musicRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
        
        URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
            guard error == nil else { return }
            if let json = try? JSON(data: data!) {
                print(json)
                let result = (json["results"]["songs"]["data"]).array!
                for song in result {
                    let attributes = song["attributes"]
//                    let previewURL = (attributes["previews"] as? [[String:Any]] ?? []).first?["url"] as? String ?? ""
                    let previewURL = attributes["previews"].array?.first?["url"].string ?? ""
                    let currentSong = Song(id: attributes["playParams"]["id"].string!, name: attributes["name"].string!, artistName: attributes["artistName"].string!, artworkURL: attributes["artwork"]["url"].string!, downloadURL: previewURL)
                    songs.append(currentSong)
                }
                completion(songs)
            } else {
                completion([])
            }
        }.resume()
    }
    
    func searchMusicWithoutCatalog(_ searchTerm: String, completion: @escaping((Result<AppleSongSearchResponse,APIError>) -> Void)) {
        
        guard let musicURL = URL(string: "https://itunes.apple.com/search?term=\(searchTerm.replacingOccurrences(of: " ", with: "+"))&media=music&limit=25") else {
            return
        }

        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
            guard error == nil else { return }
            DispatchQueue.main.async {
               

                if Reachability.isConnectedToNetwork(){
                    if error != nil {
                        completion(.failure(.errorReport(desc: Messages.serverError)))
                    }
                    if let response = response as? HTTPURLResponse {
                        let result = self.handleNetworkResponse(response,forData:data ?? Data())
                        switch result {
                        case .success:
                            guard let responseData = data else {
                                completion(.failure(.errorReport(desc: NetworkResponse.noData.rawValue)))
                                return
                            }

                            do {
                                let result = try JSONDecoder().decode(AppleSongSearchResponse.self, from: responseData)
                                if result.resultCount != 0 {
                                    completion(.success(result))
                                }
                                else if ((result.status?.contains("error")) != nil){
                                    completion(.failure(.errorReport(desc: result.message ?? "")))
                                }
                                else {
                                    completion(.failure(.errorReport(desc: result.message ?? "")))
                                }
                            }
                            catch {
                                print(error)

                                print(error.localizedDescription)
                                completion(.failure(.errorReport(desc: "Data Not Found")))
                            }
                        case .failure(let networkFailureError):
                            completion(.failure(.errorReport(desc: networkFailureError)))
                        }
                    }
                }
                else{
                    completion(.failure(.errorReport(desc: Messages.internetConnection)))
                }
            }
        }.resume()
    }
    
    
    func handleNetworkResponse(_ response : HTTPURLResponse, forData data : Data = Data())->
   APIResult<String> {
       switch response.statusCode{
       case 200...299 : return.success
       case 400       : return.success
       case 422       : return.success //VALIDATION ERROR
       case 401...500 : return.failure(NetworkResponse.authenticationError.rawValue)
       case 501...599 : return.failure(NetworkResponse.badRequest.rawValue)
       case 600       : return.failure(NetworkResponse.outdated.rawValue)
       default        : return.failure(NetworkResponse.failed.rawValue)
       }
   }
    
    func getUserToken(completion: @escaping ((Bool) -> ())){
        SKCloudServiceController().requestUserToken(forDeveloperToken: AppleMusicKit.shared.developerToken) { (receivedToken, error) in
            guard error == nil else {
                // User not purchased subscription on IAP
                print(error!.localizedDescription as Any)
                completion(false)
                return
            }
            
            if let token = receivedToken {
                AppleMusicKit.shared.userToken = token
                print("userToken : \(AppleMusicKit.shared.userToken)")
                
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
