import Foundation
protocol TSP_Solver{
    func solve(num_cities: Int, evaluator: FitnessEvaluator) -> Route
}

class GeneticTSP_Solver: TSP_Solver{
    var numIterations: Int=1000
    var numPopulation: Int=20
    func solve(num_cities: Int, evaluator: FitnessEvaluator) -> Route{
        var population: [Route]=[]
        for _ in 0..<numPopulation{
            population.append(Route.produceRandom(numTasks: num_cities))
        }
        for _ in 0..<numIterations{
            population.sort(by: {evaluator.evaluate(r: $0) > evaluator.evaluate(r: $1)})
            var nextGeneration: [Route]=[]
            for _ in 0..<numPopulation{
                        let parentOne = GeneticTSP_Solver.selectParent(population: population, evaluator: evaluator)
                        let parentTwo = GeneticTSP_Solver.selectParent(population: population, evaluator: evaluator)
                    
                    var child = Route.produceOffspring(parent1: parentOne, parent2: parentTwo, numTasks: num_cities)

                    if Float.random(in: 0...1) < 0.15{
                        child = child.mutate(numTasks: num_cities)
                    }
                    
                    nextGeneration.append(child)
            }
            population=nextGeneration
        }

        population.sort(by: {evaluator.evaluate(r: $0) > evaluator.evaluate(r: $1)})
        return population[0]
    }
    static func selectParent(population: [Route], evaluator:FitnessEvaluator) -> Route{
        var thresholds:[Float]=[0]
        for r in population{
            thresholds.append(exp(evaluator.evaluate(r: r))+thresholds.last!)
        }
        let rnd=Float.random(in: 0..<thresholds.last!)
        let index=thresholds.lastIndex(where: {val in val<rnd})!
        return population[index]
    }
}