//
//  BearViewController.swift
//  week4_assignment
//
//  Created by 장혜성 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class BearViewController: UIViewController {

    @IBOutlet var bearCollectionView: UICollectionView!
    
    var bearList: [Bear] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "오늘의 맥주는?"
        
        setCollectionViewLayout()
        configVC()
        callBearList(page: 1)
        
        // 네비게이션바 아래 라인 생기도록하기
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
//        navigationController?.navigationBar.tintColor = .blue
//        navigationController?.navigationBar.backgroundColor = .yellow
//        view.backgroundColor = .yellow
    }
    
    override func awakeAfter(using coder: NSCoder) -> Any? {
        navigationItem.backButtonDisplayMode = .minimal
        return super.awakeAfter(using: coder)
    }

    func configVC() {
        bearCollectionView.dataSource = self
        bearCollectionView.delegate = self
        
        let nib = UINib(nibName: BearCollectionViewCell.identifier, bundle: nil)
        bearCollectionView.register(nib, forCellWithReuseIdentifier: BearCollectionViewCell.identifier)
    }
    
    func callBearList(page: Int) {
        
        let parameters: [String: String] = ["page": "\(page)"]
        
        AF.request(RootUrl.bear, method: .get, parameters: parameters)
            .validate()
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
            
                for item in json.arrayValue {
                    self.bearList.append(
                        Bear(
                            id: item["id"].intValue,
                            name: item["name"].stringValue,
                            imgUrl: item["image_url"].stringValue))
                }
                
                self.bearCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setCollectionViewLayout() {
        // 비율 계산해서 디바이스 별로 UI 설정
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let count: CGFloat = 2
        let width: CGFloat = UIScreen.main.bounds.width - (spacing * (count + 1)) // 디바이스 너비 계산
        
        layout.itemSize = CGSize(width: width / count, height: width / count)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)  // 컨텐츠가 잘리지 않고 자연스럽게 표시되도록 여백설정
        layout.minimumLineSpacing = spacing         // 셀과셀 위 아래 최소 간격
        layout.minimumInteritemSpacing = spacing    // 셀과셀 좌 우 최소 간격
        
        bearCollectionView.collectionViewLayout = layout  // layout 교체
    }
}

extension BearViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bearList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BearCollectionViewCell.identifier, for: indexPath) as! BearCollectionViewCell
        
        cell.configureCell(row: bearList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailBearViewController.identifier) as! DetailBearViewController
        let row = bearList[indexPath.row]
        vc.bear = row
        navigationController?.pushViewController(vc, animated: true)
    }
}
