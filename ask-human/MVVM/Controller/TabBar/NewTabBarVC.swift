//
//  NewTabBarVC.swift
//  ask-human
//
//  Created by meet sharma on 21/11/23.
//

import UIKit

class NewTabBarVC: UIViewController,UITabBarControllerDelegate, UITabBarDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet var botmVwTabBar: NSLayoutConstraint!
    @IBOutlet var vwTabBAr: UIView!
    @IBOutlet var vwTabBarTop: NSLayoutConstraint!
    @IBOutlet var vwHeightTabBar: NSLayoutConstraint!
    @IBOutlet weak var profileTab: UITabBarItem!
    @IBOutlet weak var notificationTab: UITabBarItem!
    @IBOutlet weak var walletTab: UITabBarItem!
    @IBOutlet weak var homeTab: UITabBarItem!
    @IBOutlet weak var tabBar: TabBarWithCorners!
    @IBOutlet weak var scrollVw: UIScrollView!
    
    //MARK: - VARIABLES
    private var upperLineView: UIView!
    private var selectedImageView: UIImageView!
    private let spacing: CGFloat = 15
    private let imageHeight: CGFloat = 20
    var isComing = false
    var viewModel = NOtificationVM()
    var isSelect = 0
    var isComingRefer = false
    
    //MARK: - LIFE CYCLE METHOD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarImages()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("Store.selectTabIndex:--\(Store.selectTabIndex ?? 0)")
        if  Store.selectTabIndex == 2 {
            NotificationCenter.default.post(name: Notification.Name("notificationCount"), object: nil)
            tabBar.selectedItem = tabBar.items?[2]
            DispatchQueue.main.async {
                self.scrollVw.setContentOffset(.zero, animated: false)
                self.scrollVw.setContentOffset(CGPoint(x: self.scrollVw.frame.size.width * 2, y: 0), animated: false)
                NotificationCenter.default.post(name: Notification.Name("getProfile"), object: nil)
            }
        }else if Store.selectTabIndex == 1{
            NotificationCenter.default.post(name: Notification.Name("getnotifyCount"), object: nil)
            tabBar.selectedItem = tabBar.items?[1]
            DispatchQueue.main.async {
                self.scrollVw.setContentOffset(.zero, animated: false)
                self.scrollVw.setContentOffset(CGPoint(x: self.scrollVw.frame.size.width * 1, y: 0), animated: false)
                NotificationCenter.default.post(name: Notification.Name("notifications"), object: nil)
            }
        }else{
            NotificationCenter.default.post(name: Notification.Name("notificationCount"), object: nil)
            tabBar.selectedItem = tabBar.items?[0]
            if isComing == false{
                DispatchQueue.main.async {
                    self.scrollVw.setContentOffset(.zero, animated: false)
                }
            } else {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name("UserListApi"), object: nil)
                    self.vwTabBAr.isHidden = false
                    self.tabBar.isHidden = false
                    self.vwHeightTabBar.constant = 60
                    self.scrollVw.setContentOffset(.zero, animated: false)
                    self.scrollVw.setContentOffset(CGPoint(x: self.scrollVw.frame.size.width * 3, y: 0), animated: false)
                    NotificationCenter.default.addObserver(self, selector: #selector(self.hideTabBar(notification:)), name: Notification.Name("hideTabBar"), object: nil)
                }
            }
        }
        setupTabBar()
        addShadowToTabBar()
    }
    private func setupTabBarImages() {
        if traitCollection.userInterfaceStyle == .dark {
            profileTab.image = UIImage(named: "profiledark")
            profileTab.selectedImage = UIImage(named: "pinkProfile")
            homeTab.image = UIImage(named: "darkMessage")
            homeTab.selectedImage = UIImage(named: "messages")
        }else{
            profileTab.image = UIImage(named: "grayProfile")
            profileTab.selectedImage = UIImage(named: "pinkProfile")
            homeTab.image = UIImage(named: "messagUnselect")
            homeTab.selectedImage = UIImage(named: "messages")
        }
    }
    @objc func hideTabBar(notification:Notification){
        vwTabBAr.isHidden = true
        tabBar.isHidden = true
        vwHeightTabBar.constant = 0
        vwTabBarTop.constant = 0
        botmVwTabBar.constant = 5
    }
    //MARK: - FUNCTIONS
    private func addShadowToTabBar() {
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.25
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        tabBar.layer.shadowRadius = 4
    }
    private func setupTabBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.tabBar.layer.cornerRadius = 20
            self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            self.addTabbarIndicatorView(index: Store.selectTabIndex ?? 0, isFirstTime: true)
            self.addSelectedImageView(index: Store.selectTabIndex ?? 0)
        }
        if let items = self.tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
            }
        }
    }
    
    private func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false) {
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else { return }
        if !isFirstTime {
            upperLineView.removeFromSuperview()
        }
        upperLineView = UIView(frame: CGRect(x: tabView.frame.minX + spacing-8, y: tabView.frame.minY + 0.1, width: tabView.frame.size.width - spacing, height: 2))
        let gradientLayer = makeGradientLayer()
        upperLineView.layer.addSublayer(gradientLayer)
        tabBar.addSubview(upperLineView)
    }
    
    private func makeGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = upperLineView.bounds
        gradientLayer.colors = [UIColor(hex: "#E50B83").cgColor, UIColor(hex: "#890D99").cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        return gradientLayer
    }
    
    private func addSelectedImageView(index: Int) {
        selectedImageView?.removeFromSuperview()
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else { return }
        selectedImageView = UIImageView(image: UIImage(named: "shadow")) // Replace "yourImageName" with the actual name of your image
        selectedImageView.contentMode = .scaleAspectFill
        let centerY = tabView.frame.midY - (imageHeight / 2)
        selectedImageView.frame = CGRect(x: tabView.frame.midX - 35, y: 14, width: 70, height: imageHeight)
        tabBar.addSubview(selectedImageView)
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let selectedIndex = tabBar.items?.firstIndex(of: tabBar.selectedItem!) {
            Store.selectTabIndex = selectedIndex
            if Store.selectTabIndex == 0{
                showLoader = true
                NotificationCenter.default.post(name: Notification.Name("notificationCount"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("tabInboxClick"), object: nil)
                if isComing == false{
                    scrollVw.setContentOffset(.zero, animated: false)
                }else{
                    scrollVw.setContentOffset(.zero, animated: false)
                    scrollVw.setContentOffset(CGPoint(x: scrollVw.frame.size.width*3, y: 0), animated: false)
                }
                addTabbarIndicatorView(index: 0)
                addSelectedImageView(index: 0)
            }else if Store.selectTabIndex == 1{
                NotificationCenter.default.post(name: Notification.Name("getnotifyCount"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("notificationCount"), object: nil)
                scrollVw.setContentOffset(.zero, animated: false)
                scrollVw.setContentOffset(CGPoint(x: scrollVw.frame.size.width*1, y: 0), animated: false)
                addTabbarIndicatorView(index: 1)
                addSelectedImageView(index: 1)
                isComing = false
                NotificationCenter.default.post(name: Notification.Name("notifications"), object: nil)
            }else {
                NotificationCenter.default.post(name: Notification.Name("notificationCount"), object: nil)
                print("Token: -- \(Store.authKey ?? "")")
                NotificationCenter.default.post(name: Notification.Name("getProfile"), object: nil)
                NotificationCenter.default.post(name: Notification.Name("scrollView"), object: nil)
                scrollVw.setContentOffset(.zero, animated: false)
                scrollVw.setContentOffset(CGPoint(x: scrollVw.frame.size.width*2, y: 0), animated: false)
                addTabbarIndicatorView(index: 2)
                addSelectedImageView(index: 2)
            }
        }
    }
    
}



