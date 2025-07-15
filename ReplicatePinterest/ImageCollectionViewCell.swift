//
//  ImageCollectionViewCell.swift
//  ReplicatePinterest
//
//  Created by The Coding Kid on 20/11/2024.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ImageCell"
    @IBOutlet var imageCointainer:UIView!
    @IBOutlet var image:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageCointainer)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
  
}
