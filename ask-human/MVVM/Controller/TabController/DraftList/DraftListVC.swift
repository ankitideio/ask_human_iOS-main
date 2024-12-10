//
//  DraftListVC.swift
//  ask-human
//
//  Created by meet sharma on 20/11/23.
//

import UIKit
import AVFoundation
import AVKit

class DraftListVC: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var lblScrenTitle: UILabel!
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var tblVwDraft: UITableView!
    var viewModel = NoteVM()
    var arrDraftList = [DraftList]()
    var isComing = 0
    var callBack:(()->())?
    //MARK: - LIFE CYCLE METHOD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNoteApi()
    }
    override func viewWillAppear(_ animated: Bool) {
        Store.isComingDraft = false
        darkMode()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            darkMode()
            tblVwDraft.reloadData()
        }
        
    }
    func darkMode(){
        if traitCollection.userInterfaceStyle == .dark {
            lblNoData.textColor = .white
            lblScrenTitle.textColor = .white
            btnBack.setImage(UIImage(named: "keyboard-backspace25"), for: .normal)
        }else{
            lblNoData.textColor = UIColor(hex: "#6F7179")
            lblScrenTitle.textColor = .black
            btnBack.setImage(UIImage(named: "back"), for: .normal)
        }
        }
    func getNoteApi(){
        viewModel.getNoteApi { data in
            self.arrDraftList = data ?? []
            
            if self.arrDraftList.count > 0{
                
                self.lblNoData.isHidden = true
                
            }else{
                
                self.lblNoData.isHidden = false
                
            }
            self.tblVwDraft.estimatedRowHeight = 50
            self.tblVwDraft.rowHeight = UITableView.automaticDimension
            self.tblVwDraft.reloadData()
            
        }
    }
    
    //MARK: - ACTION
    @IBAction func actionSegment(_ sender: UISegmentedControl) {
        sender.changeUnderlinePosition()
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        SceneDelegate().notificationsRoot(selectTab: 2)
    }
    
    
    
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension DraftListVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDraftList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "DraftImageTVC", for: indexPath) as! DraftImageTVC
        
        if traitCollection.userInterfaceStyle == .dark {
            cell1.lblDecription.textColor = .white
            cell1.btnEdit.backgroundColor = .white
            cell1.btnEdit.setTitleColor(.black, for: .normal)
            cell1.viewBack.backgroundColor = UIColor(hex: "#161616")
            cell1.viewBack.borderCol = .clear
            cell1.viewBack.borderWid = 0
            cell1.viewBack.layer.cornerRadius = 10
        }else{
            cell1.viewBack.layer.cornerRadius = 10
            cell1.viewBack.borderCol =  UIColor(hex: "#E8E8E8")
            cell1.viewBack.borderWid = 1
            cell1.lblDecription.textColor = UIColor(hex: "#313131")
            cell1.btnEdit.backgroundColor = .black
            cell1.btnEdit.setTitleColor(.white, for: .normal)
            cell1.viewBack.backgroundColor = .white
        }
        if arrDraftList[indexPath.row].media?.count ?? 0 > 0{
            cell1.heightCollVw.constant = 130
        }else{
            cell1.heightCollVw.constant = 0
        }
        cell1.arrDraftList = arrDraftList
        cell1.index = indexPath.row
        cell1.uiSet()
        cell1.lblDecription.text = arrDraftList[indexPath.row].note ?? ""
        cell1.btnDelete.addTarget(self, action: #selector(actionDeleteDraft), for: .touchUpInside)
        cell1.btnDelete.tag = indexPath.row
        cell1.btnSearch.addTarget(self, action: #selector(actionSearchDraft), for: .touchUpInside)
        cell1.btnSearch.tag = indexPath.row
        cell1.btnEdit.addTarget(self, action: #selector(actionEditDraft), for: .touchUpInside)
        cell1.btnEdit.tag = indexPath.row
        
        cell1.callBack = { (videoUrl) in
            let player = AVPlayer(url: videoUrl)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
        cell1.callBackImg = { (imgUrl) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewImageVC") as! ViewImageVC
            vc.imgString =  imgUrl
            vc.isComing = true
            vc.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(vc, animated: true)
        }
            return cell1

    }
    @objc func actionDeleteDraft(sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageAcceptPopUpVC") as! MessageAcceptPopUpVC
        vc.status = "draft"
        vc.callBack = {
            if self.arrDraftList.count > 0{
                self.viewModel.deleteDraft(id: self.arrDraftList[sender.tag].id ?? ""){ data in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResponsePopUpVC") as! ResponsePopUpVC
                    self.getNoteApi()
                    vc.message = data?.message ?? ""
                    vc.modalPresentationStyle = .overFullScreen
                    
                    self.navigationController?.present(vc, animated: false)
                }
            }
        }
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, animated: true)
        
          
    }
   
    @objc func actionSearchDraft(sender:UIButton){
        Store.notesId = arrDraftList[sender.tag].id ?? ""
        Store.selectTabIndex = 0
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewTabBarVC") as! NewTabBarVC
      
        vc.isComing = true
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func actionEditDraft(sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchNoteVC") as! SearchNoteVC
        vc.isComing = true
        Store.isComingDraft = true
        vc.draftId = arrDraftList[sender.tag].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
