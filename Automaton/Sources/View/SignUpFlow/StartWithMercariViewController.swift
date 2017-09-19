//
// Created by DTVD on 9/10/17.
// Copyright (c) 2017 orakaro. All rights reserved.
//

import UIKit

final class StartWithMercariViewController: UIViewController, DependencyInjectable {

    struct Dependency {
        let resource: MercariIdResource
        let token: String
    }

    private var resource: MercariIdResource!
    private var token: String!

    static func make(withDependency dependency: Dependency) -> StartWithMercariViewController {
        let vc = StartWithMercariViewController()
        vc.resource = dependency.resource
        vc.token = dependency.token
        return vc
    }
}

extension StartWithMercariViewController: RegistrationStateViewController {
    var state: RegistrationState { return .startWithMercari}
}

