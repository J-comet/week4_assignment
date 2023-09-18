//
//  LottoRepository.swift
//  week4_assignment
//
//  Created by 장혜성 on 2023/09/13.
//

import Foundation
import Alamofire

final class LottoRepository {
    
    private let url = "https://www.dhlottery.co.kr/common.do"
    
    func callLottoInfo(
        selectNum: String,
        complete: @escaping (_ response: ResponseLotto?, _ isSuccess: Bool) -> ()
    ){
        let requestLotto = RequestLotto(drwNo: selectNum)
        
        AF.request(
            url,
            method: .get,
            parameters: requestLotto,
            encoder: URLEncodedFormParameterEncoder.default
        )
        .validate(statusCode: 200...500)
        .responseDecodable(of: ResponseLotto.self) { response in
            var requestStatus: String
            switch response.result {
            case .success(let data):
                complete(data, true)
                requestStatus = "성공"
            case .failure(let error):
                print(error)
                complete(nil, false)
                requestStatus = "실패"
            }
            print("======== \(response.request?.urlRequest?.url) ======== 호출 \(requestStatus)")
        }
    }
    
    //    func callLottoInfo(
    //        selectNum: String
    //    ) {
    //        AF.request(url + selectNum, method: .get)
    //            .validate()
    //            .responseJSON { response in
    //            switch response.result {
    //            case .success(let value):
    //                let json = JSON(value)
    //                print("JSON: \(json)")
    //
    //                if json["returnValue"] == "fail" {
    //
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
