//
// Created by DTVD on 9/10/17.
// Copyright (c) 2017 orakaro. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController, DependencyInjectable {

    static func make(withDependency dependency: Void) -> RootViewController {
        let vc = RootViewController()
        return vc
    }
}

extension RootViewController: RegistrationStateViewController {
    var state: RegistrationState { return .root }
}

