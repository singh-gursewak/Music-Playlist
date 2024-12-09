//
//  Attachment.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 06/12/24.
//

import Foundation


// MARK: - Attachment
struct Attachment: Codable {
    let type: String?
    let url: String?
    let thumbnail : String?
    let size : String?
    let _id : String?
    let id:String?
    let postOwnerImage : String?
    let postOwnerId : String?
    let postOwnerName : String?
    let postId : String?
}

public class PlaylistArray: NSObject, NSCoding{
    
    var name : String?
    var playListId   : String?
    var songs = [ResultData]()
    
    public init(name: String?,playListId:String? ,songs:[ResultData]) {
        self.name = name
        self.playListId = playListId
        self.songs = songs
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(playListId, forKey: "playListId")
        coder.encode(songs, forKey: "songs")
    }
    
    public required init?(coder: NSCoder) {
        self.name = coder.decodeObject(forKey: "name") as? String
        self.playListId = coder.decodeObject(forKey: "playListId") as? String
        self.songs = coder.decodeObject(forKey: "songs") as? [ResultData] ?? []
    }
    
}
