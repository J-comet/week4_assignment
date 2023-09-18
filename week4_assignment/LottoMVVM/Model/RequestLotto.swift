//
//  Lotto.swift
//  week4_assignment
//
//  Created by 장혜성 on 2023/09/13.
//

import Foundation

//method=getLottoNumber&drwNo=
struct RequestLotto: Encodable {
    let method = "getLottoNumber"
    let drwNo: String
}
