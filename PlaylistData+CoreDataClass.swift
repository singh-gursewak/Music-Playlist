//
//  PlaylistData+CoreDataClass.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 08/12/24.
//
//

import Foundation
import CoreData

@objc(PlaylistData)
public class PlaylistData: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaylistData> {
        return NSFetchRequest<PlaylistData>(entityName: "PlaylistData")
    }

    @NSManaged public var playlist: [PlaylistArray]?

}
extension PlaylistData : Identifiable {

}
