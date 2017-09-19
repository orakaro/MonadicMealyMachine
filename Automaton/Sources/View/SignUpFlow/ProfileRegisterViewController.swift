//
// Created by DTVD on 9/10/17.
// Copyright (c) 2017 orakaro. All rights reserved.
//

import UIKit

final class ProfileRegisterViewController: UIViewController, DependencyInjectable {

    struct Dependency {
        let facebookProfile: FacebookProfile
    }

    private var facebookProfile: FacebookProfile!

    static func make(withDependency dependency: Dependency) -> ProfileRegisterViewController {
        let vc = ProfileRegisterViewController()
        vc.facebookProfile = dependency.facebookProfile
        return vc
    }
}

extension ProfileRegisterViewController: RegistrationStateViewController {
    var state: RegistrationState { return .profileRegister }
}

