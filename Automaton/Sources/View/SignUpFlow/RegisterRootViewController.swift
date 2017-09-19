//
// Created by DTVD on 9/10/17.
// Copyright (c) 2017 orakaro. All rights reserved.
//

import UIKit

final class RegisterRootViewController: UIViewController, DependencyInjectable  {

    static func make(withDependency dependency: Void) -> RegisterRootViewController {
        let vc = RegisterRootViewController()
        return vc
    }

    private func loginWithFacebook(withProfile profile: FacebookProfile) {
        guard let viewController = nextViewController(event: .registerWithFacebook(profile: profile)) else { return }
        present(viewController, animated: true)
    }

    private func monadicLoginWithFacebook(withProfile profile: FacebookProfile) {
        let event: REvent = .registerWithFacebook(profile: profile)
        let (s1, vc) = MonadicAutomatonManager.registrationMachine.transition(from: state, by: event)
        if s1 == .any { return }
        present(vc, animated: true)
    }
}

extension RegisterRootViewController: RegistrationStateViewController {
    var state: RegistrationState { return .root }
}
