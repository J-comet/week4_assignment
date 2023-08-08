//
//  DetailBearViewController.swift
//  week4_assignment
//
//  Created by 장혜성 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class DetailBearViewController: UIViewController {
    
    static let identifier = "DetailBearViewController"
    
    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    var bear: Bear?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "상세 정보"
        
        guard let bear else {
            return
        }
        print(bear)
        
        thumbImageView.contentMode = .scaleAspectFit
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
     
        callDetailBear(id: bear.id)
        
        thumbImageView.kf.setImage(with: URL(string: bear.imgUrl), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        nameLabel.text = bear.name
    }
    
    func callDetailBear(id: Int) {
        
        AF.request(RootUrl.bear + "/\(id)", method: .get)
            .validate()
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
            
                let description = json[0]["description"].stringValue
                
                self.descriptionTextView.text = description
                
            case .failure(let error):
                print(error)
                self.descriptionTextView.text = "오류가 발생했습니다"
            }
        }
    }

}
