//
//  PlaylistListingVC.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 07/12/24.
//

import UIKit
import CoreData

class PlaylistListingVC: BaseClassVC {
    
    //MARK: - VARIABLES
    var playlist  = [PlaylistArray]()
    
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var playlistTableView  : UITableView!

    //MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
            registerCell()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationBarHiddenStatus(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationBarHiddenStatus(false)
    }
    
    func registerCell(){
        self.playlistTableView.register(UINib(nibName: "MyPlaylistsTableCell", bundle: .main), forCellReuseIdentifier: "MyPlaylistsTableCell")
    }
    
   //MARK: - IBACTIONS
    @IBAction func plusClicked(_ sender: UIButton){
        if let vc = openViewControllerBasedOnIdentifier(VCNames.searchSongVC) as? SearchSongVC{
            vc.playlist = self.playlist
            vc.addCompletion = { [weak self] selectedData,selectedId in // called once adding songs in playlist completed
                guard let self = self else {return}
                self.runOnMain {
                    self.playlist = selectedData
                    guard let appDelegate =
                        UIApplication.shared.delegate as? AppDelegate else {
                            return
                    }
                    // 1
                    let managedContext =
                        appDelegate.persistentContainer.viewContext
                   
                    let playListData = PlaylistData(context: managedContext)
                    
                    playListData.playlist = self.playlist
                    print(playListData.playlist ?? "")
                    //Save all playlist data in core data
                    appDelegate.saveContext()
                    self.playlistTableView.reloadData()

                }
            }
        }
    }
}

extension PlaylistListingVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPlaylistsTableCell", for: indexPath) as! MyPlaylistsTableCell
        let getData = self.playlist[indexPath.row]
        cell.lblPlaylistName.text = getData.name ?? ""
        cell.lblSongsCount.text = "\(getData.songs.count.description) Songs"
        return cell
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

