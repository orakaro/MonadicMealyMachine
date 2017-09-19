//
// Created by DTVD on 9/10/17.
// Copyright (c) 2017 orakaro. All rights reserved.
//

import UIKit

typealias RState = RegistrationState

enum REvent {
    case showRegisterRoot
    case registerWithFacebook(profile: FacebookProfile)
    case startWithMercari(resource: MercariIdResource, token: String)
    case loginWithEmail
    case loginWithAtte(resource: MercariIdResource, token: String)
    case loginAndShowHome(token: String, userId: Int64)
}

struct TransitionFunc {
    static let registerRootTransition: (Void) -> State<RState, UIViewController> = { v in
        let vc = RegisterRootViewController.make(withDependency: v)
        return State<RState, UIViewController> { s in
            let s1: RState = s == .root ? .registerRoot: .any
            return (s1, vc)
        }
    }

    static let facebookProfileTransition : (FacebookProfile) -> State<RState, UIViewController> = { profile in
        let vc = ProfileRegisterViewController.make(withDependency: .init(facebookProfile: profile))
        return State<RState, UIViewController> { s in
            let s1: RState = s == .registerRoot ? .profileRegister : .any
            return (s1, vc)
        }
    }

    static let mercariStartTransition: (MercariIdResource, String) -> State<RState, UIViewController> = { resource, token in
        let vc = StartWithMercariViewController.make(withDependency: .init(resource: resource, token: token))
        return State<RState, UIViewController> { s in
            let s1: RState = s == .registerRoot ? .startWithMercari : .any
            return (s1, vc)
        }
    }

    static let emailLoginTransition: (Void) -> State<RState, UIViewController> = { v in
        let vc = EmailLoginViewController.make(withDependency: v)
        return State<RState, UIViewController> { s in
            let s1: RState = s == .registerRoot ? .emailLogin : .any
            return (s1, vc)
        }
    }

    static let atteLoginTransition: (MercariIdResource, String) -> State<RState, UIViewController> = { resource, token in
        let vc = AtteLoginViewController.make(withDependency: .init(resource: resource, token: token))
        return State<RState, UIViewController> { s in
            let s1: RState = s == .registerRoot ? .atteLogin: .any
            return (s1, vc)
        }
    }

    static let homeTransition: (String, Int64) -> State<RState, UIViewController> = { token, userId in
        let vc = HomeViewController.make(withDependency: .init(token: token, userId: userId))
        return State<RState, UIViewController> { s in
            let s1: RState = s == .registerRoot ? .home : .any
            return (s1, vc)
        }
    }
}

let transitionFunc: (REvent) -> State<RState, UIViewController> = { event in
    switch event {
        case .showRegisterRoot:
            return TransitionFunc.registerRootTransition()
        case .registerWithFacebook(let profile):
            return TransitionFunc.facebookProfileTransition(profile)
        case .startWithMercari(let resource, let token):
            return TransitionFunc.mercariStartTransition(resource, token)
        case .loginWithEmail:
            return TransitionFunc.emailLoginTransition()
        case .loginWithAtte(let resource, let token):
            return TransitionFunc.atteLoginTransition(resource, token)
        case .loginAndShowHome(let token, let userId):
            return TransitionFunc.homeTransition(token, userId)
    }
}

struct MonadicAutomatonManager {
    static let registrationMachine = MonadicAutomaton<RState, REvent, UIViewController>(f : transitionFunc)
}
