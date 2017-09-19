//
// Created by DTVD on 9/10/17.
// Copyright (c) 2017 orakaro. All rights reserved.
//

import Foundation

struct Transition<S, E> {
    let from: S
    let to: S
    let by: E
}

class Automaton<S: Hashable, E: Hashable> {
    var routes: [S: [E: S]] = [:]

    init(initialState: S, transitions: [Transition<S, E>]) {
        for t in transitions {
            addRoute(t)
        }
    }

    private func addRoute(_ t: Transition<S, E>) {
        var dict = routes[t.from] ?? [:]
        dict[t.by] = t.to
        routes[t.from] = dict
    }

    func transition(from: S, by: E) -> S? {
        guard let next = routes[from].flatMap({ $0[by] }) else { return nil }
        return next
    }
}
