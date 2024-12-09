//
//  CreatePlaylistVC.swift
//  GHinnotec
//
//  Created by Gursewak Singh on 07/12/24.
//

import UIKit

class CreatePlaylistVC: BaseClassVC {
    
    //MARK: - VARIABLES
    var playlist  = [PlaylistArray]()
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var txtEnterPlaylist  : UITextField!
    
    //MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEnterPlaylist.addBottomBorder()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarHiddenStatus(false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationBarHiddenStatus(true)

    }
    
    //MARK: - IBACTIONS
    @IBAction func confirmClicked(_ sender: UIButton){
        if txtEnterPlaylist.text == "" || txtEnterPlaylist.text == " "{
            self.showAlert(message: Messages.nameMessage, title: Messages.appName)
        }else{
            let timestamp = Date().timeIntervalSince1970
            print(timestamp.description)
           
            let data = PlaylistArray(name: txtEnterPlaylist.text ?? "", playListId: timestamp.description,songs: [])
            playlist.append(data)
            if let vc = openViewControllerBasedOnIdentifier(VCNames.playlistListVC) as? PlaylistListingVC{
                vc.playlist = self.playlist
            }
        }
    }
}
