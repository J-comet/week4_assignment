//
//  LottoViewModel.swift
//  week4_assignment
//
//  Created by 장혜성 on 2023/09/13.
//

import Foundation

final class LottoViewModel {
    
    let numList: [Int] = Array(1...1100).reversed()
    
    private let repository = LottoRepository()
    
    var isLoading: Observable<Bool> = Observable(false)
    var selectNum: Observable<String> = Observable("")
    var resultLottoText: Observable<String> = Observable("")
    
    var numRowCount: Int {
        return numList.count
    }
    
    func pickerViewContent(titleForRow row: Int) -> String {
        return String(numList[row])
    }
    
    func pickerViewdidSelectRow(didSelectRow row: Int) {
        selectNum.value = String(numList[row])
    }
    
    func getLottoNum(completionHandler: @escaping () -> Void) {
        repository.callLottoInfo(selectNum: self.selectNum.value) { [weak self] response, isSuccess in
            
            self?.isLoading.value = true
            self?.resultLottoText.value = "로딩 중"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let response else {
                    self?.resultLottoText.value = "오류가 발생했어요"
                    self?.isLoading.value = false
                    completionHandler()
                    return
                }
                
                if isSuccess {
                    self?.resultLottoText.value = "당첨번호\n\(response.drwtNo1) \(response.drwtNo2) \(response.drwtNo3) \(response.drwtNo4) \(response.drwtNo5) \(response.drwtNo6) + 보너스번호 \(response.bnusNo)\n\n당첨일\n\(response.drwNoDate)"
                } else {
                    self?.resultLottoText.value = "\(self?.selectNum.value ?? "0")회에 대한 정보가 없어요"
                }
                self?.isLoading.value = false
                completionHandler()
            }
            
        }
    }
    
}

