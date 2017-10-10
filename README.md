# Monadic Mealy Machine

Demo for Souzoh iOS Talk 2017: 
[メルカリ アッテを支えるオートマトン](https://speakerdeck.com/dtvd/monadic-mealy-machine)

## Requirement
Swift 4 / Xcode 9

## Summary
State Monad
```swift
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
```
Monadic Mealy Machine
```swift
struct MonadicAutomaton<S, A, B> {
    typealias T = (A) -> State<S, B>
    private var f : T

    init(f: @escaping T) {
        self.f = f
    }

    func transition(from: S, by: A) -> (S, B) {
        return f(by).run(s: from)
    }
}
```
