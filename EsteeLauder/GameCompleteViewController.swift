//
//  GameCompleteViewController.swift
//  EsteeLauder
//
//  Created by Kang on 2022/06/16.
//

import Foundation
import UIKit
import AVKit

class GameCompleteViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var postsCollectionView: UICollectionView!
    @IBOutlet var postsLabel: UILabel!
    @IBOutlet var featuresCollectionView: UICollectionView!
    @IBOutlet var videoView: UIView!

    @IBAction func showFeatures() {
        postsCollectionView.isHidden = true
        postsLabel.isHidden = true
        videoView.isHidden = true
        featuresCollectionView.isHidden = false
        self.avPlayer?.pause()
    }

    @IBAction func showVideo() {
        postsCollectionView.isHidden = true
        postsLabel.isHidden = true
        videoView.isHidden = false
        featuresCollectionView.isHidden = true

        (children.last as! AVPlayerViewController).player = self.avPlayer
        (children.last as! AVPlayerViewController).player?.play()
    }

    @IBAction func showPosts() {
        postsCollectionView.isHidden = false
        postsLabel.isHidden = false
        videoView?.isHidden = true
        featuresCollectionView.isHidden = true
        self.avPlayer?.pause()
    }

    var avPlayer: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        let videoURL = Bundle.main.url(forResource: "movie_1", withExtension: "mp4")!
        self.avPlayer = AVPlayer(url: videoURL)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == featuresCollectionView {
            return 3
        }
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featuresCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturesCell", for: indexPath) as! FeaturesCell
            cell.imageView.image = UIImage(named: "features_\(indexPath.item+1)")
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.imageView.image = UIImage(named: "post_\(indexPath.item+1)")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == featuresCollectionView {
            return CGSize(width: 240, height: 240)
        }

        return CGSize(width: 128, height: 128)
    }
}
