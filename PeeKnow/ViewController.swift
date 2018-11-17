//
//  ViewController.swift
//  PeeKnow
//
//  Created by Daniel Aragon Ore on 10/24/18.
//  Copyright © 2018 Daragonor. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var sampleImage: UIImageView!
    @IBOutlet weak var dominantColorOne: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var colors: [Int] = []
        
        for x in (0..<Int(sampleImage.image!.size.width)){
            for y in (0...Int(sampleImage.image!.size.height)){
                let hexString = sampleImage.image!.getPixelColor(atLocation: CGPoint(x: x, y: y), withFrameSize: sampleImage.frame.size)!.hexString
                if let value = Int(hexString, radix: 16) {
                    colors.append(value)
                }
            }
        }
        let dominantColors = kMeans(numCenters: 3, convergeDistance: 5 , points: colors).map({UIColor(hex: String($0, radix: 16))})
        self.dominantColorOne.backgroundColor = dominantColors[0]
    }
    
    @IBAction func choosePee(_ sender: Any) {
        
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        var colors: [Int] = []
        self.sampleImage.image = image
        for x in (0..<Int(sampleImage.image!.size.width)){
            for y in (0...Int(sampleImage.image!.size.height)){
                let hexString = image.getPixelColor(atLocation: CGPoint(x: x, y: y), withFrameSize: sampleImage.frame.size).hexString
                if let value = Int(hexString, radix: 16) {
                    colors.append(value)
                }
            }
        }
        let dominantColors = kMeans(numCenters: 3, convergeDistance: 5 , points: colors).map({UIColor(hex: String($0, radix: 16))})
        self.dominantColorOne.backgroundColor = dominantColors[0]

    
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil);
    }
}

