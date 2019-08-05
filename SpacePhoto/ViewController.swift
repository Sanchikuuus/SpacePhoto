//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Sashko Shel on 8/4/19.
//  Copyright © 2019 Sashko Shel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    let photoInfoController = PhotoInfoController()
    @IBOutlet var pinchGesture: UIPinchGestureRecognizer!
    
    var centerX: CGFloat = 0
    var centerY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Loading..."
        
        descriptionLabel.text = ""
        descriptionLabel.alpha = 0
        copyrightLabel.text = ""
        copyrightLabel.alpha = 0
        imageView.alpha = 0
        
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo  {
                self.updateUI(with: photoInfo)
            }
        }
    }
    
    func updateUI(with photoInfo: PhotoInfo) {
        let task = URLSession.shared.dataTask(with: photoInfo.url) { (data, response, error) in
            
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.title = photoInfo.title
                self.descriptionLabel.text = photoInfo.description
                self.imageView.image = image
                if let copyright = photoInfo.copyright {
                    self.copyrightLabel.text = "Copyright \(copyright)"
                } else {
                    self.copyrightLabel.isHidden = true
                }
                self.loadingIndicator.stopAnimating()
                UIView.animate(withDuration: 1.5, animations: {
                    self.descriptionLabel.alpha = 1
                    self.imageView.alpha = 1
                    self.navigationTitle.titleView?.alpha = 1
                    if (photoInfo.copyright != nil) {
                        self.copyrightLabel.alpha = 1
                    }
                })
            }
        }
        task.resume()
    }
    
    @IBAction func pinchDetected(_ sender: UIPinchGestureRecognizer) {
        
        switch sender.state {
            
        case .possible:
            break
        case .began:
            break
        case .changed:
            let scaleTransform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
            
//            let firstTouch = sender.location(ofTouch: 0, in: self.view)
//            let imageOrigin = imageView.frame.origin
//
//            if sender.numberOfTouches == 2 {
//                let secondTouch = sender.location(ofTouch: 1, in: self.view)
//                centerX = ( firstTouch.x + secondTouch.x ) / 2 - imageOrigin.x
//                centerY = ( firstTouch.y + secondTouch.y ) / 2 - imageOrigin.y
//            } else if sender.numberOfTouches == 1 {
//                centerX = ( firstTouch.x - imageOrigin.x )
//                centerY = ( firstTouch.y - imageOrigin.y )
//            } else { return }
            
            // TODO: fix animation
            let translateTransform = CGAffineTransform(translationX: 0, y: 100)
            
            
            imageView.transform = scaleTransform.concatenating(translateTransform)
        case .ended:
            UIView.animate(withDuration: 0.5) {
                self.imageView.transform = CGAffineTransform.identity
            }
        case .cancelled:
            UIView.animate(withDuration: 0.5) {
                self.imageView.transform = CGAffineTransform.identity
            }
        case .failed:
            break
        @unknown default:
            break
        }
    }
    
}

