//
//  PlaylistDetailVC.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 07/12/24.
//

import UIKit
import CoreData

class PlaylistDetailVC: BaseClassVC {
    
    //MARK: - VARIABLES
    var playlist       = [PlaylistArray]()
    var songs          = [ResultData]()
    var name           : String?
    var selectedId : String?
    
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var songsTableView   : UITableView!
    @IBOutlet weak var lblPlaylistName  : UILabel!
    @IBOutlet weak var lblSongsCount    : UILabel!
    

    //MARK: - VIEW LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        populateData()
        songsTableView.reloadData()
        registerCell()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarHiddenStatus(true)
    }
    
    func populateData(){
        self.lblPlaylistName.text = self.name ?? ""
        self.lblSongsCount.text = "\(self.songs.count.description) Songs"
    }
    
    func registerCell(){
        self.songsTableView.register(UINib(nibName: "SearchTableCell", bundle: .main), forCellReuseIdentifier: "SearchTableCell")
    }
    
    //MARK: - IBACTION
    @IBAction func plusClicked(_ sender:UIButton){
        if let vc = openViewControllerBasedOnIdentifier(VCNames.searchSongVC) as? SearchSongVC{
            vc.playlist = self.playlist
            vc.addCompletion = { [weak self] selectedData, selectedId in // called once adding songs in playlist completed
                guard let self = self else {return}
                self.runOnMain {
                    if let getIdIndex = self.playlist.firstIndex(where: {$0.playListId == selectedId}){
                        if self.selectedId == self.playlist[getIdIndex].playListId{
                            self.songs = self.playlist[getIdIndex].songs
                        }
                    }
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
                    self.lblSongsCount.text = "\(self.songs.count.description) Songs"
                    self.songsTableView.reloadData()

                }
            }
        }
    }
    
}

//MARK: - TABLEVIEW DATASOURCE & DELETEGATE

extension PlaylistDetailVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath) as! SearchTableCell
        let getData = songs[indexPath.row]
        cell.lblTrackName.text  = getData.trackName ?? ""
        cell.lblArtistName.text = getData.artistName ?? ""
        cell.imgPreview.setImage(link: getData.artworkUrl100 ?? "")

        return cell
    }
}
