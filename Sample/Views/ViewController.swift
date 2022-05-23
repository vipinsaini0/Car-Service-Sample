//
//  ViewController.swift
//  Sample
//
//  Created by Vipin Saini on 07/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewTopHeader: UIView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var layoutViewMainWidth: NSLayoutConstraint!
    @IBOutlet weak var layoutViewContainerWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionViewMG: UICollectionView!
    @IBOutlet weak var collectionViewNearby: UICollectionView!
    @IBOutlet weak var collectionViewTrending: UICollectionView!
    @IBOutlet weak var collectionViewLaunch: UICollectionView!
    @IBOutlet weak var collectionViewUpcoming: UICollectionView!
    @IBOutlet weak var collectionViewBlog: UICollectionView!
    
    
    
    
    //MARK: - View Load
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setDesign()
    }
}

//Set Design
extension ViewController {
    
    func setDesign() {
        scrollView.contentInsetAdjustmentBehavior = .never
        
        self.setViewWidth(layoutWidth: layoutViewMainWidth)
        self.setViewWidth(layoutWidth: layoutViewContainerWidth)
        
        //Top Header color
        let colorGreenL = UIColor.greenLight
        let colorGreenD = UIColor.greenDark
        let sizeRect:CGRect = CGRect(x: 0, y: 0, width: getScreenSize().width, height: viewTopHeader.bounds.height)
        viewTopHeader.applyGradient(isVertical: true, colorArray: [colorGreenL, colorGreenD], viewBound: sizeRect)
        
        //Search Text
        let searchBound = CGRect(x: 0, y: 0, width: getScreenSize().width-20, height: viewSearch.bounds.height)
       viewSearch.addRoundShadow(cornerRadius: 10, size: searchBound)
    }
}

extension ViewController {
    func setViewWidth(layoutWidth:NSLayoutConstraint) {
        let screenSize = getScreenSize()
        layoutWidth.constant = screenSize.width
    }
    func getScreenSize() -> CGRect {
        return UIScreen.main.bounds
    }
}


    //MARK: - CollectionView
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewMG {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MGCollectionViewCell", for: indexPath) as! MGCollectionViewCell
            cell.addRoundShadow(cornerRadius: 10, size: cell.bounds)
            return cell
        } else if collectionView == collectionViewNearby {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearbyCollectionViewCell", for: indexPath) as! NearbyCollectionViewCell
            cell.viewLogo.addRoundShadow(cornerRadius: 40, size: cell.viewLogo.bounds)
            return cell
        } else if collectionView == collectionViewTrending {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath) as! TrendingCollectionViewCell
            cell.addRoundShadow(cornerRadius: 10, size: cell.bounds)
            return cell
        } else if collectionView == collectionViewLaunch {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LaunchCollectionViewCell", for: indexPath) as! LaunchCollectionViewCell
            return cell
        } else if collectionView == collectionViewUpcoming {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCollectionViewCell", for: indexPath) as!UpcomingCollectionViewCell
            return cell
        } else if collectionView == collectionViewBlog {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlogCollectionViewCell", for: indexPath) as! BlogCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MGCollectionViewCell", for: indexPath) as! MGCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}
