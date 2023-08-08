//
//  BearCollectionViewCell.swift
//  week4_assignment
//
//  Created by 장혜성 on 2023/08/08.
//

import UIKit
import Kingfisher

class BearCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BearCollectionViewCell"

    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        designCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImageView.image = nil
    }
    
    func designCell() {
        thumbImageView.contentMode = .scaleAspectFit
        nameLabel.textAlignment = .center
        thumbImageView.kf.indicatorType = .activity
    }

    func configureCell(row: Bear) {
        nameLabel.text = row.name
        thumbImageView.kf.setImage(with: URL(string: row.imgUrl), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
    }
}
