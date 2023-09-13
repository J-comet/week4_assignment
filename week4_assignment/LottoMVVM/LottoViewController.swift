//
//  LottoViewController.swift
//  week4_assignment
//
//  Created by 장혜성 on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var numLabel: UILabel!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    private let viewModel = LottoViewModel()
    private let repository = LottoRepository()
    
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.inputView = pickerView
        textField.tintColor = .clear
        textField.textAlignment = .center
        
        numLabel.numberOfLines = 0
        numLabel.textAlignment = .center
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        repository.callLottoInfo(selectNum: "1079") { response, isSuccess in
            print("response!!!! = \(response)")
            
        }
//        callLottoInfo(selectNum: "1079")
        
        indicatorView.hidesWhenStopped = true
        
        
    }

//    func callLottoInfo(selectNum: String) {
//        indicatorView.startAnimating()
//        AF.request(url + selectNum, method: .get)
//            .validate()
//            .responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("JSON: \(json)")
//
//                if json["returnValue"] == "fail" {
//                    self.numLabel.text = "당첨번호가 조회되지 않습니다."
//                } else {
//                    let date = json["drwNoDate"].stringValue
//                    let drwtNo1 = json["drwtNo1"].intValue
//                    let drwtNo2 = json["drwtNo2"].intValue
//                    let drwtNo3 = json["drwtNo3"].intValue
//                    let drwtNo4 = json["drwtNo4"].intValue
//                    let drwtNo5 = json["drwtNo5"].intValue
//                    let drwtNo6 = json["drwtNo6"].intValue
//                    let bonusNumber = json["bnusNo"].intValue
//
//                    self.numLabel.text = "당첨번호\n \(drwtNo1) \(drwtNo2) \(drwtNo3) \(drwtNo4) \(drwtNo5) \(drwtNo6) + 보너스번호 \(bonusNumber)\n\n당첨일\n\(date)"
//                }
//
//            case .failure(let error):
//                print(error)
//                self.numLabel.text = "재시도해주세요"
//            }
//            self.indicatorView.stopAnimating()
//        }
//    }
}

extension LottoViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numList.count
    }
    
    // 피커뷰 내용 설정
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(viewModel.numList[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = String(viewModel.numList[row])
//        callLottoInfo(selectNum: String(viewModel.numList[row]))
    }
    
}
