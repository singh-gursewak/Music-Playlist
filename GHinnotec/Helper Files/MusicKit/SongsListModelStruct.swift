//
//  SongsListModelStruct.swift

import Foundation
struct Song {
    var id: String
    var name: String
    var artistName: String
    var artworkURL: String
    var downloadURL: String

    init(id: String, name: String, artistName: String, artworkURL: String, downloadURL: String) {
        self.id = id
        self.name = name
        self.artworkURL = artworkURL
        self.artistName = artistName
        self.downloadURL = downloadURL
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct AppleSongSearchResponse: APIModel {
    var status      : String?
    var statusCode  : Int?
    var message     : String?
    let resultCount : Int?
    let results     : [ResultData]?
}

// MARK: - Result
public class ResultData:NSObject ,NSCoding ,Codable{
  
    
    let wrapperType: String?
    let kind: String?
    let artistID, collectionID, trackID: Int?
    let artistName, collectionName, trackName, collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice, trackPrice: Double?
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
    let collectionArtistName: String?
    var isPlaying : Bool?
    
    public init(wrapperType: String?,kind:String? ,artistID:Int?,collectionID:Int?,trackID:Int?,artistName:String?,collectionName:String?,trackName:String?,collectionCensoredName:String?,trackCensoredName:String?,artistViewURL:String?,collectionViewURL:String?,trackViewURL:String?,previewURL:String?,artworkUrl30:String?,artworkUrl60:String?,artworkUrl100:String?,collectionPrice:Double?,trackPrice:Double?,releaseDate:String?,collectionExplicitness:String?,trackExplicitness:String?,discCount:Int?,discNumber:Int?,trackCount:Int?,trackNumber:Int?,trackTimeMillis:Int?,country:String?,currency:String?,primaryGenreName:String?,isStreamable:Bool?,collectionArtistName:String?,isPlaying:Bool?) {
        
        self.wrapperType = wrapperType
        self.kind = kind
        self.artistID = artistID
        self.collectionID = collectionID
        self.trackID = trackID
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackName = trackName
        self.collectionCensoredName = collectionCensoredName
        self.trackCensoredName = trackCensoredName
        self.artistViewURL = artistViewURL
        self.collectionViewURL = collectionViewURL
        self.trackViewURL = trackViewURL
        self.previewURL = previewURL
        self.artworkUrl30 = artworkUrl30
        self.artworkUrl60 = artworkUrl60
        self.artworkUrl100 = artworkUrl60
        self.collectionPrice = collectionPrice
        self.trackPrice = trackPrice
        self.releaseDate = releaseDate
        self.collectionExplicitness = collectionExplicitness
        self.trackExplicitness = trackExplicitness
        self.discCount = discCount
        self.discNumber = discNumber
        self.trackNumber = trackNumber
        self.trackCount = trackCount
        self.trackTimeMillis = trackTimeMillis
        self.country = country
        self.currency = currency
        self.primaryGenreName = primaryGenreName
        self.isStreamable = isStreamable
        self.collectionArtistName = collectionArtistName
        self.isPlaying = isPlaying
        
    }


    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable, collectionArtistName
        case isPlaying
    }
    
    
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(primaryGenreName, forKey: "primaryGenreName")
        aCoder.encode(isStreamable, forKey: "isStreamable")
        aCoder.encode(collectionArtistName, forKey: "collectionArtistName")
        aCoder.encode(isPlaying, forKey: "isPlaying")
       
        aCoder.encode(trackPrice, forKey: "trackPrice")
        aCoder.encode(releaseDate, forKey: "releaseDate")
        aCoder.encode(collectionExplicitness, forKey: "collectionExplicitness")
        aCoder.encode(trackExplicitness, forKey: "trackExplicitness")
        aCoder.encode(discCount, forKey: "discCount")
        aCoder.encode(discNumber, forKey: "discNumber")
        aCoder.encode(trackCount, forKey: "trackCount")
        aCoder.encode(trackNumber, forKey: "trackNumber")
        aCoder.encode(trackTimeMillis, forKey: "trackTimeMillis")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(currency, forKey: "currency")
        
        aCoder.encode(wrapperType, forKey: "wrapperType")
        aCoder.encode(kind, forKey: "kind")
        aCoder.encode(artistID, forKey: "artistID")
        aCoder.encode(collectionID, forKey: "collectionID")
        aCoder.encode(trackID, forKey: "trackID")
        aCoder.encode(artistName, forKey: "artistName")
        aCoder.encode(collectionName, forKey: "collectionName")
        aCoder.encode(trackName, forKey: "trackName")
        aCoder.encode(collectionCensoredName, forKey: "collectionCensoredName")
        aCoder.encode(trackCensoredName, forKey: "trackCensoredName")
        aCoder.encode(artistViewURL, forKey: "artistViewURL")
        aCoder.encode(collectionViewURL, forKey: "collectionViewURL")
        aCoder.encode(trackViewURL, forKey: "trackViewURL")
        aCoder.encode(previewURL, forKey: "previewURL")
        aCoder.encode(artworkUrl30, forKey: "artworkUrl30")
        aCoder.encode(artworkUrl60, forKey: "artworkUrl60")
        aCoder.encode(artworkUrl100, forKey: "artworkUrl100")
        aCoder.encode(collectionPrice, forKey: "collectionPrice")
        
     
    }
    
    required public init?(coder aDecoder: NSCoder) {

        self.discCount = aDecoder.decodeObject(forKey: "discCount") as? Int
        self.discNumber = aDecoder.decodeObject(forKey: "discNumber") as? Int
        self.trackCount = aDecoder.decodeObject(forKey: "trackCount") as? Int
        self.trackNumber = aDecoder.decodeObject(forKey: "trackNumber") as? Int
        self.country = aDecoder.decodeObject(forKey: "country") as? String
        self.currency = aDecoder.decodeObject(forKey: "currency") as? String
        self.primaryGenreName = aDecoder.decodeObject(forKey: "primaryGenreName") as? String
        self.collectionArtistName = aDecoder.decodeObject(forKey: "collectionArtistName") as? String

        self.isStreamable = aDecoder.decodeObject(forKey: "isStreamable") as? Bool
        self.isPlaying = aDecoder.decodeObject(forKey: "isPlaying") as? Bool

        self.trackTimeMillis = aDecoder.decodeObject(forKey: "trackTimeMillis") as? Int
        self.trackExplicitness = aDecoder.decodeObject(forKey: "trackExplicitness") as? String
        self.releaseDate = aDecoder.decodeObject(forKey: "releaseDate") as? String
        self.collectionExplicitness = aDecoder.decodeObject(forKey: "collectionExplicitness") as? String
        
        self.artworkUrl30 = aDecoder.decodeObject(forKey: "artworkUrl30") as? String
        self.artworkUrl60 = aDecoder.decodeObject(forKey: "artworkUrl60") as? String
        self.artworkUrl100 = aDecoder.decodeObject(forKey: "artworkUrl100") as? String
        self.collectionPrice = aDecoder.decodeObject(forKey: "collectionPrice") as? Double
        self.trackPrice = aDecoder.decodeObject(forKey: "trackPrice") as? Double
        
        self.artistName = aDecoder.decodeObject(forKey: "artistName")  as? String
        self.collectionName = aDecoder.decodeObject(forKey: "collectionName") as? String
        self.trackName = aDecoder.decodeObject(forKey: "trackName") as? String
        self.collectionCensoredName = aDecoder.decodeObject(forKey: "collectionCensoredName") as? String
        self.trackCensoredName = aDecoder.decodeObject(forKey: "trackCensoredName") as? String
        self.artistViewURL = aDecoder.decodeObject(forKey: "artistViewURL") as? String
        self.collectionViewURL = aDecoder.decodeObject(forKey: "collectionViewURL") as? String
        self.trackViewURL = aDecoder.decodeObject(forKey: "trackViewURL") as? String
        self.previewURL = aDecoder.decodeObject(forKey: "previewURL") as? String
        
        self.wrapperType = aDecoder.decodeObject(forKey: "wrapperType") as? String

        self.kind = aDecoder.decodeObject(forKey: "kind") as? String
        self.artistID = aDecoder.decodeObject(forKey: "artistID") as? Int
        self.collectionID = aDecoder.decodeObject(forKey: "collectionID") as? Int
        self.trackID = aDecoder.decodeObject(forKey: "trackID") as? Int
        
    }
    
    // Conform to Equatable to use contains()
      static func ==(lhs: ResultData, rhs: ResultData) -> Bool {
          return lhs.trackID == rhs.trackID
      }
}










