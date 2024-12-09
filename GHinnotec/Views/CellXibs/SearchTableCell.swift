//
//  SearchTableCell.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 07/12/24.
//

import UIKit

class SearchTableCell: UITableViewCell {
    
    //MARK: - IBOUTLET
    @IBOutlet weak var imgPreview     : UIImageView!
    @IBOutlet weak var lblTrackName   : UILabel!
    @IBOutlet weak var lblArtistName  : UILabel!
    @IBOutlet weak var lblType        : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
