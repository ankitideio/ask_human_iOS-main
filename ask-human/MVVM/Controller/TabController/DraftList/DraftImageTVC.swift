//
//  DraftImageTVC.swift
//  ask-human
//
//  Created by meet sharma on 20/11/23.
//

import UIKit
import AVFoundation
import Kingfisher
import AVKit

class DraftImageTVC: UITableViewCell {

    @IBOutlet var viewBack: UIView!
    @IBOutlet weak var heightCollVw: NSLayoutConstraint!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnSearch: GradientButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var collVwImages: UICollectionView!
    @IBOutlet weak var lblDecription: UILabel!
    var arrDraftList = [DraftList]()
    var index = 0
    var callBack:((_ videoUrl:URL)->())?
    var callBackImg:((_ imgUrl:String)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func uiSet(){
        collVwImages.delegate = self
        collVwImages.dataSource = self
        if traitCollection.userInterfaceStyle == .dark {
                collVwImages.backgroundColor =  UIColor(hex: "#161616")
                print("Dark Mode - Setting background color to dark")
            
            
            } else {
                collVwImages.backgroundColor =  UIColor(hex: "#FFFFFF")
                print("Light Mode - Setting background color to white")
                
            }
        collVwImages.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    func generateThumbnail(url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let asset = AVURLAsset(url: url)
                let imageGenerator = AVAssetImageGenerator(asset: asset)
                let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60), actualTime: nil)
                let thumbnail = UIImage(cgImage: thumbnailCGImage)
                
                DispatchQueue.main.async {
                    completion(thumbnail)
                }
            } catch {
                print("Error generating thumbnail: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
extension DraftImageTVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if index < arrDraftList.count {
               return arrDraftList[index].media?.count ?? 0
           } else {
               return 0
           }
               
               
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DraftImgCVC", for: indexPath) as! DraftImgCVC
        cell.imgVw.image = nil
//        cell.imgVw?.imageLoad(imageUrl: arrDraftList[index].media?[indexPath.item] ?? "")
        let mediaItem = arrDraftList[index].media?[indexPath.item] ?? ""

                if mediaItem.uppercased().hasSuffix(".MOV") {
                    cell.imgVwPlay.isHidden = false
                    cell.imgVw.kf.indicatorType = .activity
                    cell.imgVw.kf.indicator?.startAnimatingView()
                    let url = URL(string: arrDraftList[index].media?[indexPath.item] ?? "")
                    generateThumbnail(url: url!) { thumbnail in
                                if let thumbnail = thumbnail {
                                    cell.imgVw.kf.indicator?.stopAnimatingView()
                                    cell.imgVw.image = thumbnail
                                    print("Thumbnail loaded")
                                } else {
                                    print("Failed to load thumbnail")
                                }
                            }
                    cell.btnPlay.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
                    cell.btnPlay.tag = indexPath.row
                } else {
                    cell.btnPlay.addTarget(self, action: #selector(showImage), for: .touchUpInside)
                    cell.btnPlay.tag = indexPath.row
                    cell.imgVwPlay.isHidden = true
                    cell.imgVw?.imageLoad(imageUrl: mediaItem)
                }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3-10, height: 130)
    }
    @objc func playVideo(sender:UIButton){
        let url = URL(string: arrDraftList[index].media?[sender.tag] ?? "")
       
        callBack?(url!)
       
    }
    @objc func showImage(sender:UIButton){
        callBackImg?(arrDraftList[index].media?[sender.tag] ?? "")
    }
}

