//
//  YourLibraryVC.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 06/12/24.
//

import UIKit
import CoreData

class YourLibraryVC: BaseClassVC {
    
    //MARK: - VARIABLES
    var playlist = [PlaylistArray]()
    
    
    //MARK: - IBOULETS
    @IBOutlet weak var libCollcetionView : UICollectionView!
    @IBOutlet weak var libTableView      : UITableView!
    @IBOutlet weak var c_bottomConst     : NSLayoutConstraint!
    @IBOutlet weak var btnGridTble       : UIButton!
    
    //MARK: - VIEW LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        btnGridTble.setImageTintColor(UIColor.label)
        addGesture()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        hideTabBar(false)
    }
    
    func addGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.touchTapped(_:)))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func touchTapped(_ sender: UITapGestureRecognizer) {
        c_bottomConst.constant = -350
        // Animate the change of constraint
        animateView()
        hideTabBar(false)
    }
    
    func animateView(){
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded() // This updates the view with the new constraint
        })
    }
    
    func registerCells(){
        self.libTableView.register(UINib(nibName: "LibraryTableViewCell", bundle: .main), forCellReuseIdentifier: "LibraryTableViewCell")
    }
    
    //MARK:- CORE DATA: RETRIEVE SAVED DATA
    func fetchData(){
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<PlaylistData>(entityName: "PlaylistData")
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            print(fetchedResults)
            
            if fetchedResults.count > 0 {
                for i in fetchedResults{
                    self.playlist = i.playlist ?? []
                }
            }
            self.libTableView.reloadData()
            self.libCollcetionView.reloadData()

        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
    }
    
    //MARK: - IBACTIONS
    @IBAction func gridListClicked(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        btnGridTble.setImageTintColor(UIColor.label, for: sender.state)

        if sender.isSelected{
            self.libCollcetionView.isHidden = false
            self.libTableView.isHidden = true
            self.libCollcetionView.reloadData()
            
        }else{
            
            self.libTableView.isHidden = false
            self.libCollcetionView.isHidden = true
            self.libTableView.reloadData()
        }
    }
    
    @IBAction func plusClicked(_ sender: UIButton){
        hideTabBar(true)
        // Move the view from bottom to top
        c_bottomConst.constant = 0
        
        // Animate the change of constraint
        animateView()
    }
    @IBAction func createClicked(_ sender: UIButton){
        c_bottomConst.constant = -350
        if let vc = openViewControllerBasedOnIdentifier(VCNames.createPlaylistVC) as? CreatePlaylistVC{
            vc.playlist = self.playlist
          
        }
    }
}

// MARK: - TABLEVIEW DATASOURCE & DELEGATES
extension YourLibraryVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryTableViewCell", for: indexPath) as! LibraryTableViewCell
        cell.songs = self.playlist[indexPath.row].songs
        cell.lblPlaylistName.text = self.playlist[indexPath.row].name ?? ""
        cell.lblSongsCount.text = "\(self.playlist[indexPath.row].songs.count.description) Songs"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = openViewControllerBasedOnIdentifier(VCNames.playlistDetailVC) as? PlaylistDetailVC{
            let getData = self.playlist[indexPath.row]
            vc.songs = getData.songs
            vc.playlist = self.playlist
            vc.name = getData.name
            vc.selectedId = getData.playListId ?? ""

        }
    }
}

extension YourLibraryVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlist.count//8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpperCollectionCell", for: indexPath) as! UpperCollectionCell
        let getData = self.playlist[indexPath.row]
        cell.lblPlaylistName.text = getData.name ?? ""
        cell.lblSongCount.text = "\(getData.songs.count.description) Songs"
        cell.songs = getData.songs
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 2   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size , height: size + 70)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = openViewControllerBasedOnIdentifier(VCNames.playlistDetailVC) as? PlaylistDetailVC{
            let getData = self.playlist[indexPath.row]
            vc.songs = getData.songs
            vc.playlist = self.playlist
            vc.name = getData.name
            vc.selectedId = getData.playListId ?? ""

        }
    }
}

extension YourLibraryVC : UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let _ = touch.view as? UIButton { return false }
        return true
    }
}
