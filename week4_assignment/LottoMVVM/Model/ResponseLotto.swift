//
//  ResponseLotto.swift
//  week4_assignment
//
//  Created by 장혜성 on 2023/09/13.
//

import Foundation

struct ResponseLotto: Decodable {
    let returnValue: String     // 통신 결과
    let drwNoDate: String       // 당첨일
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}
