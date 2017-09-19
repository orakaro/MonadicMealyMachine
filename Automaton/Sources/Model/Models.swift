//
// Created by DTVD on 9/10/17.
// Copyright (c) 2017 orakaro. All rights reserved.
//

import Foundation

struct FacebookProfile {
    var credential: Credential
    var basicInfo: BasicInfo
}

struct Credential {
    let tokenString: String
    let appId: String
    let userId: String
}

struct BasicInfo {
    let email: String?
    let id: String
    let name: String
    let avatar: String
    let birthday: Date?
}

struct MercariIdResource {
    let name: String
    let email: String
    let birthDate: Date?
}
