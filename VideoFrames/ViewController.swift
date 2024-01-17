//
//  ViewController.swift
//  VideoFrames
//
//  Created by 国富集团赵 on 2024/1/17.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imageView0: UIImageView!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func generatorImage() {
        
        if let url = Bundle.main.url(forResource: "oceans", withExtension: "mp4") {
            
            let asset = AVAsset(url: url)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true // 应用视频轨道的变换
            generator.requestedTimeToleranceBefore = CMTime.zero // 防止时间出现偏差
            generator.requestedTimeToleranceAfter = CMTime.zero
            
            // 临时写一个秒数
            let second = arc4random() % 46
            let time = CMTimeMakeWithSeconds(Float64(second), preferredTimescale: 600)
            generator.generateCGImageAsynchronously(for: time) { [weak self] cgImage, cmTime, error in

                if let cgImage = cgImage {
                    let image = UIImage(cgImage: cgImage)
                    DispatchQueue.main.async {
                        self?.imageView0.image = image
                    }
                }
            }
        }
    }
    
    @IBAction func generatorImages() {
        if let url = Bundle.main.url(forResource: "oceans", withExtension: "mp4") {

            let asset = AVAsset(url: url)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true // 应用视频轨道的变换
            generator.requestedTimeToleranceBefore = CMTime.zero // 防止时间出现偏差
            generator.requestedTimeToleranceAfter = CMTime.zero
            
            // 临时写几个秒数
            let second0 = arc4random() % 46
            let second1 = arc4random() % 46
            let second2 = arc4random() % 46
            
            let times = [NSValue(time: CMTimeMakeWithSeconds(Float64(second0), preferredTimescale: 600)), NSValue(time: CMTimeMakeWithSeconds(Float64(second1), preferredTimescale: 600)), NSValue(time: CMTimeMakeWithSeconds(Float64(second2), preferredTimescale: 600))]
            
            var images = [UIImage]()
            generator.generateCGImagesAsynchronously(forTimes: times) { [weak self] requestTime, cgImage, actualTime, result, error in
                
                if result == AVAssetImageGenerator.Result.succeeded , let cgImage = cgImage {
                    let image = UIImage(cgImage: cgImage)
                    images.append(image)
                    
                    if (images.count == 3) {
                        //
                        DispatchQueue.main.async {
                            self?.imageView1.image = images[0]
                            self?.imageView2.image = images[1]
                            self?.imageView3.image = images[2]
                        }
                    }
                }
            }
            
        }
    }

}

