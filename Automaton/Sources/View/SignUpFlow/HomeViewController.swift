//
// Created by DTVD on 9/10/17.
// Copyright (c) 2017 orakaro. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController, DependencyInjectable {

    struct Dependency {
        let token: String
        let userId: Int64
    }

    private var token: String!
    private var userId: Int64!

    static func make(withDependency dependency: Dependency) -> HomeViewController {
        let vc = HomeViewController()
        vc.token = dependency.token
        vc.userId = dependency.userId
        return vc
    }
}

extension HomeViewController: RegistrationStateViewController {
    var state: RegistrationState { return  .home }
}
