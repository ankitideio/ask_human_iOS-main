//
//  ReceiveMessageTVC.swift
//  ask-human
//
//  Created by meet sharma on 20/11/23.
//

import UIKit
import Kingfisher
import AVFoundation

class ReceiveMessageTVC: UITableViewCell {
    
    @IBOutlet weak var vwReceiverImg: UIView!
    @IBOutlet weak var vwReceiverMsg: UIView!
    @IBOutlet weak var lblMessageTitle: UILabel!
    @IBOutlet weak var vwImage: UIView!
    @IBOutlet weak var widthReceiverMessage: NSLayoutConstraint!
    @IBOutlet weak var lblReceiverTime: UILabel!
    @IBOutlet weak var lblReceiverName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var clsnVwMessage: UICollectionView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var vwMessage: UIView!
    @IBOutlet weak var imgVwProfile: UIImageView!
    var arrImage = [String]()
    var callBack:((_ isSelect:String,_ url:String)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func uiSet(){
        
        clsnVwMessage.delegate = self
        clsnVwMessage.dataSource = self
        widthReceiverMessage.constant =  CGFloat(arrImage.count*110)
        print("array Count:==",arrImage.count)
        clsnVwMessage.reloadData()
        
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
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}

extension ReceiveMessageTVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImage.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReceiveMessageImageCVC", for: indexPath) as! ReceiveMessageImageCVC
        cell.btnClick.tag = indexPath.row
        cell.btnClick.addTarget(self, action: #selector(actionSelect), for: .touchUpInside)
        if arrImage[indexPath.row].contains(".png") || arrImage[indexPath.row].contains(".jpeg") || arrImage[indexPath.row].contains(".jpg"){
            cell.imgVwMessage.imageLoad(imageUrl: arrImage[indexPath.row])
            cell.imgVwPlay.isHidden = true
        }else{
            cell.imgVwPlay.isHidden = false
            cell.imgVwMessage.kf.indicatorType = .activity
            cell.imgVwMessage.kf.indicator?.startAnimatingView()
            let url = URL(string: arrImage[indexPath.row])
            print("Url",url!)
            generateThumbnail(url: url!) { thumbnail in
                if let thumbnail = thumbnail {
                    cell.imgVwMessage.kf.indicator?.stopAnimatingView()
                    cell.imgVwMessage.image = thumbnail
                    print("Thumbnail loaded")
                } else {
                    print("Failed to load thumbnail")
                }
            }
        }
        return cell
    }
    @objc func actionSelect(sender:UIButton){
        
        if arrImage[sender.tag].contains(".png") || arrImage[sender.tag].contains(".jpg") || arrImage[sender.tag].contains(".jpeg"){
            callBack?("image",arrImage[sender.tag])
        }else{
            callBack?("video",arrImage[sender.tag])
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if arrImage.count > 2{
            return CGSize(width: Int(clsnVwMessage.frame.width)/3-8, height: 144)
            
        }else{
            return CGSize(width: Int(clsnVwMessage.frame.width)/arrImage.count-10, height: 144)
            
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if arrImage[indexPath.row].contains(".png") || arrImage[indexPath.row].contains(".jpg") || arrImage[indexPath.row].contains(".jpeg"){
            callBack?("image",arrImage[indexPath.row])
            
        }else{
            callBack?("video",arrImage[indexPath.row])
            
        }
    }
}
