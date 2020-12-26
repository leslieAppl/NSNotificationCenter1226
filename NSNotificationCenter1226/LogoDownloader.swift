//
//  LogoDownloader.swift
//  NSNotificationCenter1226
//
//  Created by leslie on 12/26/20.
//

import Foundation
import UIKit

let logoDownloadNotificationID = "com.iosbrain.logoDownloadCompletedNotificationID"
let welcomReadyNotificationID = "com.iosbrain.welcomeReadyNotificationID"

class LogoDownloader {
    
    var logoURL: String
    var image: UIImage?
    
    init(logoURL: String) {
        
        self.logoURL = logoURL
    }
    
    func downloadLogo() -> Void {
        
        // Start the image download task asynchronously by submitting it to the default background queue;
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            
            let imageURL = URL(string: self.logoURL)
            let imageData = NSData(contentsOf: imageURL!)
            self.image = UIImage(data: imageData! as Data)
            print("image downloaded")
            
            // Once the image finishes downloading,
            // I jump onto the MAIN THREAD TO UPDATE THE UI.
            DispatchQueue.main.async {
                
                self.didDownloadImage()
            }
        }
    }
    
    func didDownloadImage() {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: logoDownloadNotificationID), object: self)
    }
}


