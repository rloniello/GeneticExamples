## Truth Seekers
## Command-line tool
- [x] Simple boolean chromosome. 
- [x] Standard Implementation.

This project is concerned with the basics. Simple declaration of the genetic object with boolean traits.
Fitness is calculated by how many traits are true over the total number of traits.
This project also describes how decimal values (Float / Double) can be used as probabilities for truthfulness.

### Basic Implementation:

All Genetic objects need: 
1) A chromosome - A particular creatures values that represent it's solution to the problem.
2) A genome - All possible combinations of traits for any given gene.
3) A fitness value - a value that represents its how well it solves the problem.
4) A reproduction method.  - A way of reproducing with another genetic object (can be a different structure entirely). 

The `chromosome`, `genome`, and `fitness` values can be set in the structure declaring conformance to the Genetic Protocol. 
likewise, you can simply return `self` in the reproduction method:

```Swift
struct Seeker: Genetic {
    var fitness: Double = 0.0
    
    var chromosome: [Trait] = []
    
    static var genome: [Gene] = []
    
    func reproduce(with other: Genetic) throws -> Seeker {
        return self
    }
}
```

No other methods or functions are needed to declare your genetic object. 
You may notice that each Gene in the chromosome takes an array of trait objects as alleles.

```Swift 
    static var genome: [Gene] = [
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        Gene(named: "", alleles: [Trait(true), Trait(false)]),
        // ...
        ]
        
```
We could also define them like so: 
```Swift
    // ...
    Gene(named: "", alleles: [Trait(true), Trait(false), Trait(false), Trait(false)]),
    // ...
```
Making this gene `false` 3/4's of the time.  (genes are initialized at random).
Similarly, we could just define it with a float or double in the form of a probability: 
```Swift
    // ...
    Gene(named: "", alleles: [Trait(0.25), Trait(0.75))]),
    // ...
```
Of course later we would have to determine which values are true or false, ... over 0.5 or under?
