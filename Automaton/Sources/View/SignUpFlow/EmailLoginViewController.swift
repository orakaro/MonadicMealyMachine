//
// Created by DTVD on 9/10/17.
// Copyright (c) 2017 orakaro. All rights reserved.
//

import UIKit

final class EmailLoginViewController: UIViewController, DependencyInjectable {

    static func make(withDependency dependency: Void) -> EmailLoginViewController {
        let vc = EmailLoginViewController()
        return vc
    }
}

extension EmailLoginViewController: RegistrationStateViewController {
    var state: RegistrationState { return .emailLogin }
}
