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
        
        indicatorView.hidesWhenStopped = true
        
        initViewModel()
    }
    
    private func initViewModel() {
        viewModel.selectNum.value = "1079"
        
        viewModel.resultLottoText.bind { [weak self] resultLottoInfo in
            print("\(resultLottoInfo)")
            self?.numLabel.text = resultLottoInfo
        }
        
        viewModel.isLoading.bind { [weak self] isLoading in
            if isLoading {
                self?.indicatorView.startAnimating()
            } else {
                self?.indicatorView.stopAnimating()
            }
        }
        
        viewModel.selectNum.bind { [weak self] selected in
            self?.viewModel.getLottoNum {
                self?.textField.text = selected
            }
        }
    }
}

extension LottoViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numRowCount
    }
    
    // 피커뷰 내용 설정
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.pickerViewContent(titleForRow: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.pickerViewdidSelectRow(didSelectRow: row)
    }
    
}
