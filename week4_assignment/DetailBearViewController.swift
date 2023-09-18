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
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    var bear: Bear?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "상세 정보"
        
        indicatorView.hidesWhenStopped = true
        
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
        
        randomButton.layer.cornerRadius = 8
        randomButton.setTitle("랜덤 맥주 추천", for: .normal)
        randomButton.backgroundColor = .yellow
        randomButton.tintColor = .black
        randomButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }
    
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        callRandomBear()
    }
    
    func callDetailBear(id: Int) {
        indicatorView.startAnimating()
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
                self.indicatorView.stopAnimating()
            }
    }
    
    func callRandomBear() {
        indicatorView.startAnimating()
        AF.request(RootUrl.bear + "/random", method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    let url = URL(string: json[0]["image_url"].stringValue)
                    
                    self.nameLabel.text = json[0]["name"].stringValue
                    self.thumbImageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
                    let description = json[0]["description"].stringValue
                    self.descriptionTextView.text = description
                    
                case .failure(let error):
                    print(error)
                    self.descriptionTextView.text = "오류가 발생했습니다"
                }
                self.indicatorView.stopAnimating()
            }
    }
}
