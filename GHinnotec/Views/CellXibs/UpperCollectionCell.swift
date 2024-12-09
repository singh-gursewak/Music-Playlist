//
//  UpperCollectionCell.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 07/12/24.
//

import UIKit

class UpperCollectionCell: UICollectionViewCell{
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var collectionMultMedia : UICollectionView!
    @IBOutlet weak var lblPlaylistName     : UILabel!
    @IBOutlet weak var lblSongCount        : UILabel!
    
    //MARK: - VARIABLES & PROPERTIES
    var songs : [ResultData]?{
        didSet{
            collectionMultMedia.reloadData {
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionMultMedia.register(UINib(nibName: "MediaLibraryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MediaLibraryCollectionCell")

    }
    
}
//MARK: - COLLECTIONVIEW METHODS
extension UpperCollectionCell:UICollectionViewDataSource,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if songs?.count ?? 0 > 3{
            return 4
        }
        return songs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaLibraryCollectionCell", for: indexPath) as! MediaLibraryCollectionCell
        let setLink = self.songs?[indexPath.row].artworkUrl100 ?? ""
        cell.imgPreview.setImage(link: setLink)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if songs?.count == 1{
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        }
        let noOfCellsInRow = 2   //number of column
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        if songs?.count == 2{
            return CGSize(width: size , height: Int(collectionView.frame.size.height))
        }
        return CGSize(width: size , height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
