//
// Created by DTVD on 9/10/17.
// Copyright (c) 2017 orakaro. All rights reserved.
//

import Foundation

struct State<S, A> {
    private let run: (S) -> (S, A)

    init(f: @escaping (S) -> (S, A)) {
        self.run = f
    }

    func run(s: S) -> (S, A) {
        return self.run(s)
    }

    func map<B>(g: @escaping (A) -> B) -> State<S, B> {
        return State<S, B> { s in
            let (s1, val) = self.run(s)
            return (s1, g(val))
        }
    }

    func flatMap<B>(g: @escaping (A) -> State<S, B>) -> State<S, B> {
        return State<S, B> { s in
            let (s1, val) = self.run(s)
            return g(val).run(s1)
        }
    }
}
