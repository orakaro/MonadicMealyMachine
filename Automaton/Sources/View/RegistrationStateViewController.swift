//
// Created by DTVD on 9/10/17.
// Copyright (c) 2017 orakaro. All rights reserved.
//

import UIKit

protocol RegistrationStateViewController {
    var state: RegistrationState { get }
    func nextViewController(event: RegistrationEvent) -> UIViewController?
}

extension RegistrationStateViewController {
    func nextViewController(event: RegistrationEvent) -> UIViewController? {
        let machine = AutomatonManager.registrationMachine
        guard let state = machine.transition(from: state, by: event) else { return nil }

        switch state {
        case .root:
            return RootViewController.make(withDependency: ())
        case .registerRoot:
            return RegisterRootViewController.make(withDependency: ())
        case .profileRegister :
            switch event {
            case .registerWithFacebook(.some(let profile)):
                return ProfileRegisterViewController.make(withDependency: .init(facebookProfile: profile))
            default: return nil
            }
        case .startWithMercari:
            switch event {
            case .startWithMercari(.some(let resource), .some(let token)):
                return StartWithMercariViewController.make(withDependency: .init(resource: resource, token: token))
            default: return nil
            }
        case .emailLogin:
            return EmailLoginViewController.make(withDependency: ())
        case .atteLogin:
            switch event {
            case .loginWithAtte(.some(let resource), .some(let token)):
                return AtteLoginViewController.make(withDependency: .init(resource: resource, token: token))
            default: return nil
            }
        case .home:
            switch event {
            case .loginAndShowHome(.some(let token), let userId):
                return HomeViewController.make(withDependency: .init(token: token, userId: userId))
            default: return nil
            }
        default: return nil
        }
    }
}


