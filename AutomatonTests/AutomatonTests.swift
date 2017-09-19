//
//  AutomatonTests.swift
//  AutomatonTests
//
//  Created by orakaro on 2017/09/19.
//  Copyright © 2017 orakaro. All rights reserved.
//

import XCTest
@testable import Automaton

class AutomatonTests: XCTestCase {
    let machine = AutomatonManager.registrationMachine
    var currentState: RegistrationState? = .root

    let monadicMachine = MonadicAutomatonManager.registrationMachine
    var currentMonadicState: RState = .root

    override func setUp() {
        super.setUp()
    }

    func testAutomaton() {
        self.tryRoute(events: [
            DefaultEvent.showRegisterRoot,
            DefaultEvent.loginWithAtte
        ])
        XCTAssert(self.currentState == .atteLogin)
    }

    func testMonadicAutomaton() {
        self.tryMonadicRoute(events: [
            .showRegisterRoot,
            .loginWithAtte(resource: .init(name: "", email: "", birthDate: nil), token: "")
        ])
        XCTAssert(self.currentMonadicState == .atteLogin)
    }

    private func tryRoute(events: [RegistrationEvent]) {
        for event in events {
            self.currentState.map { state in
                self.currentState = self.machine.transition(from: state, by: event)
            }
        }
    }

    private func tryMonadicRoute(events: [REvent]) {
        for event in events {
            self.currentMonadicState = self.monadicMachine.transition(from: self.currentMonadicState, by: event).0
        }
    }

}
