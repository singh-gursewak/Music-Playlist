//
//  SearchSongVC.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 07/12/24.
//

import UIKit

class SearchSongVC: BaseClassVC {
    
    //MARK: - VARIABLES
    var songs                                    = [ResultData]()
    var playlist                                 = [PlaylistArray]()
    var selectedTracks                           = [ResultData](){
        didSet{
            searchTableView.reloadData()
            btnAdd.isHidden = selectedTracks.isEmpty
        }
    }
    var recentSearch                            : [String]?
    var addCompletion: (([PlaylistArray],String) -> Void)?
    var selectedId : String?
    var isSearching = false
    
    //MARK: - IBOULTET
    @IBOutlet weak var searchTableView : UITableView!
    @IBOutlet weak var searchBar       : UISearchBar!
    @IBOutlet weak var btnAdd          : UIButton!
    @IBOutlet weak var chooseableView  : UITableView!
    @IBOutlet weak var c_bottomConstraint: NSLayoutConstraint! // Constraint for bottom position

    //MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        self.chooseableView.reloadData()
        self.searchBar.backgroundImage = UIImage()
        if let savedArray = UserDefaults.standard.array(forKey: "recentSearch") as? [String] {
            recentSearch = savedArray
            self.chooseableView.reloadData()
        }
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationBarHiddenStatus(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationBarHiddenStatus(false)
    }
    
    
    func registerCell(){
        self.searchTableView.register(UINib(nibName: "SearchTableCell", bundle: .main), forCellReuseIdentifier: "SearchTableCell")
    }
    
    
    func getMusicSearch(text:String){
        AppleMusicKit.shared.searchMusicWithoutCatalog(text) { [weak self] (result) in
            guard let self = self else {return}
          //  self.isLoading = false
            switch result{
            case .success(let res):
                self.songs = res.results ?? []
                self.searchTableView.reloadData()
            case .failure(let err):
                switch err {
                case .errorReport(let desc):
                    print(desc)
                }
                print(err.localizedDescription)
            }
        }
    }
  
    
    //MARK: - IBACTIONS
    @IBAction func addClicked(_ sender:UIButton){
        // Move the view from bottom to top
        c_bottomConstraint.constant = 0
        
        // Animate the change of constraint
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded() // This updates the view with the new constraint
        })
    }
    
    @IBAction func closeClicked(_ sender: UIButton){
        c_bottomConstraint.constant = -600 // The initial bottom constraint (at the bottom)
        // Animate the change of constraint
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded() // This updates the view with the new constraint
        })
    }

}

//MARK: - TABLEVIEW DATASOURCE
extension SearchSongVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == searchTableView{
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchTableView{
            if section == 1{
                return songs.count
            }
            return recentSearch?.count ?? 0
        }
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchTableView{
            if indexPath.section == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath) as! SearchTableCell
                let getData = self.songs[indexPath.row]
                cell.lblTrackName.text = getData.trackName ?? ""
                cell.lblArtistName.text = getData.artistName ?? ""
                cell.imgPreview.setImage(link: getData.artworkUrl100 ?? "")
                cell.selectionStyle = .default
                if let index = selectedTracks.firstIndex(where: { $0.trackID == getData.trackID }) {
                    if getData.trackID == self.selectedTracks[index].trackID {
                        cell.accessoryType = .checkmark
                    }else{
                        cell.accessoryType = .none
                    }
                }else{
                    cell.accessoryType = .none
                }
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath) as! SearchTableCell
                cell.lblTrackName.text = self.recentSearch?[indexPath.row]
                return cell
            }
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChoosePlaylisttableCell", for: indexPath) as! ChoosePlaylisttableCell
            cell.lblName?.text = playlist[indexPath.row].name ?? ""
            return cell

        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == searchTableView{
            if indexPath.section == 0{
                return isSearching ? 0 : 55
            }
            return UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchTableView{
            if indexPath.section == 1{
                let getTracks = self.songs[indexPath.row]
                if selectedTracks.contains(where: { $0.trackID == getTracks.trackID }){
                    if let index = selectedTracks.firstIndex(where: { $0.trackID == getTracks.trackID }) {
                        // If the object exists, removed from the array
                        selectedTracks.remove(at: index)
                    }
                }else{
                    self.selectedTracks.append(getTracks)
                }
            }
        }else{
            let stringArray = [searchBar.text]
            UserDefaults.standard.set(stringArray, forKey: "recentSearch")
            self.playlist[indexPath.row].songs.append(contentsOf: selectedTracks)
            addCompletion?(self.playlist,self.playlist[indexPath.row].playListId ?? "")
            self.popORDismiss()
        }
    }
}

extension SearchSongVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        getMusicSearch(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    
}

