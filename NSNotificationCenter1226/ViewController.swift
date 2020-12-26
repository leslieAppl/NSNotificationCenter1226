//
//  ViewController.swift
//  Delegation-In-Swift
//
//  Created by Software Testing on 2/8/18.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var leftSquareView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var rightSquareView: UIView!
    
    var logoDownloader: LogoDownloader?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishDownloading), name: Notification.Name(rawValue: logoDownloadNotificationID), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLeftSquare), name: Notification.Name(rawValue: welcomReadyNotificationID), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showWelcomLabel), name: Notification.Name(rawValue: welcomReadyNotificationID), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showRightSquare), name: Notification.Name(rawValue: welcomReadyNotificationID), object: nil)
        
        leftSquareView.alpha = 0.0
        welcomeLabel.alpha = 0.0
        rightSquareView.alpha = 0.0
        
        imageView.alpha = 0.0
        loginView.alpha = 0.0
        
        let imageURL: String = "https://cdn.spacetelescope.org/archives/images/publicationjpg/heic1509a.jpg"
        
        logoDownloader = LogoDownloader(logoURL: imageURL)
        logoDownloader?.downloadLogo()
        
    } // end func viewDidLoad()

    // Performing clean up 
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: logoDownloadNotificationID), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: welcomReadyNotificationID), object: nil)
        
    }
    
    @objc func showLeftSquare() {
        
        UIView.animate(withDuration: 1) {
            
            self.leftSquareView.alpha = 1.0
        }
    }
    
    @objc func showWelcomLabel() {
        
        UIView.animate(withDuration: 1) {
            
            self.welcomeLabel.alpha = 1.0
        }
    }
    
    @objc func showRightSquare() {
        
        UIView.animate(withDuration: 1) {
            
            self.rightSquareView.alpha = 1.0
        }
    }
    
    @objc func didFinishDownloading() {
        
        imageView.image = logoDownloader?.image
        
        UIView.animate(withDuration: 2, delay: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            self.loadingLabel.alpha = 0.0
            self.imageView.alpha = 1.0
            
        }) {(completed: Bool) in
            
            if completed {
                
                UIView.animate(withDuration: 2.0) {
                    
                    self.loginView.alpha = 1.0
                    
                }
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: welcomReadyNotificationID), object: self)
    }
    
} // end class ViewController

