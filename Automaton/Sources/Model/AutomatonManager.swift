//
// Created by DTVD on 9/10/17.
// Copyright (c) 2017 orakaro. All rights reserved.
//

import Foundation

enum RegistrationState {
    case any
    case root
    case registerRoot
    case profileRegister
    case startWithMercari
    case emailLogin
    case atteLogin
    case home
}

enum RegistrationEvent: Hashable {
    case showRegisterRoot()
    case registerWithFacebook(profile: FacebookProfile?)
    case startWithMercari(resource: MercariIdResource?, token: String?)
    case loginWithEmail()
    case loginWithAtte(resource: MercariIdResource?, token: String?)
    case loginAndShowHome(token: String?, userId: Int64)
}

struct DefaultEvent {
    static let showRegisterRoot: RegistrationEvent = .showRegisterRoot()
    static let registerWithFacebook: RegistrationEvent = .registerWithFacebook(profile: nil)
    static let startWithMercari: RegistrationEvent = .startWithMercari(resource: nil, token: nil)
    static let loginWithEmail: RegistrationEvent = .loginWithEmail()
    static let loginWithAtte: RegistrationEvent = .loginWithAtte(resource: nil, token: nil)
    static let loginAndShowHome: RegistrationEvent = .loginAndShowHome(token: nil, userId: 0)
}

extension RegistrationEvent {
    func toInt() -> Int {
        switch self {
        case .showRegisterRoot : return 0
        case .registerWithFacebook: return 1
        case .startWithMercari: return 2
        case .loginWithEmail: return 3
        case .loginWithAtte: return 4
        case .loginAndShowHome: return 5
        }
    }
    var hashValue: Int {
        return self.toInt()
    }

}

func == (lhs: RegistrationEvent, rhs: RegistrationEvent) -> Bool {
    return lhs.toInt() == rhs.toInt()
}

let registrationGraph: [Transition<RegistrationState, RegistrationEvent>] = [
    Transition(from: .root, to: .registerRoot, by: DefaultEvent.showRegisterRoot),
    Transition(from: .registerRoot, to: .profileRegister, by: DefaultEvent.registerWithFacebook),
    Transition(from: .registerRoot, to: .startWithMercari, by: DefaultEvent.startWithMercari),
    Transition(from: .registerRoot, to: .emailLogin, by: DefaultEvent.loginWithEmail),
    Transition(from: .registerRoot, to: .atteLogin, by: DefaultEvent.loginWithAtte),
    Transition(from: .registerRoot, to: .home, by: DefaultEvent.loginAndShowHome),
]

struct AutomatonManager {
    static let registrationMachine = Automaton<RegistrationState, RegistrationEvent>(
        initialState: .root,
        transitions: registrationGraph
    )
}