//
//  LibraryTableViewCell.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 06/12/24.
//

import UIKit

class LibraryTableViewCell: UITableViewCell ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //MARK: - VARIABLES & PROPERTIES
    var songs : [ResultData]?{
        didSet{
            collectionMultMedia.reloadData {
                
            }
        }
    }
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var collectionMultMedia : UICollectionView!
    @IBOutlet weak var lblPlaylistName     : UILabel!
    @IBOutlet weak var lblSongsCount       : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      //  collectionMultMedia.register(MediaLibraryCollectionCell.self, forCellWithReuseIdentifier: "MediaLibraryCollectionCell")
        self.collectionMultMedia.register(UINib(nibName: "MediaLibraryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MediaLibraryCollectionCell")
        collectionMultMedia.dataSource = self
        collectionMultMedia.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if songs?.count ?? 0 > 3{
            return 4
        }
        return songs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaLibraryCollectionCell", for: indexPath) as! MediaLibraryCollectionCell
            let setLink = songs?[indexPath.row].artworkUrl100
            cell.imgPreview.setImage(link: setLink ?? "")
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 60, height: 60)
        
        if songs?.count == 1{
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height )
        }
         
        let noOfCellsInRow = 2   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        if songs?.count == 2{
            return CGSize(width: size , height: Int(collectionView.frame.size.height))
        }
        return CGSize(width: size , height: size )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
