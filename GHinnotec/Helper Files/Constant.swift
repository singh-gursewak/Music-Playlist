//
//  Constant.swift
//

import Foundation
import UIKit
import Photos


struct StoryBoardNames {
    static let main  = "Main"
}
struct VCNames{
    static let createPlaylistVC = "CreatePlaylistVC"
    static let playlistListVC = "PlaylistListingVC"
    static let searchSongVC = "SearchSongVC"
    static let playlistDetailVC = "PlaylistDetailVC"


}


final class AppSettings {
    private enum SettingKey: String {
        case hasLogin
        
    }
    
    static var hasLogIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: SettingKey.hasLogin.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.hasLogin.rawValue
            let name = newValue
            defaults.set(name, forKey: key)
            defaults.synchronize()
        }
    }
}


struct Messages {
    static let appName                      = "Spotify"
    static let nameMessage                  = "Please enter Playlist Name"
    static let internetConnection           = "Internet connection appears to be offline."
    static let serverError                  = "Not connected to the Server."

}

