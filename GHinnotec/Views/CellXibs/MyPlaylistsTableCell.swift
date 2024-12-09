//
//  MyPlaylistsTableCell.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 07/12/24.
//

import UIKit

class MyPlaylistsTableCell: UITableViewCell {
    
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var lblPlaylistName : UILabel!
    @IBOutlet weak var lblSongsCount   : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
