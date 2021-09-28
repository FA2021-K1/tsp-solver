    import XCTest
    @testable import tsp_solver

    final class tsp_solverTests: XCTestCase {
        func testExample() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.
            let distanceMatrix=computeDistanceMatrix(locations: [Point(x: 200, y: 50), Point(x: 100, y: 1600), Point(x: -600, y: 500), Point(x: -600, y: -10), Point(x: 700, y: 700), Point(x:5000,y:-2000)])
            print(distanceMatrix)
            let evaluator=UtilityTimeEvaluator(timeMatrix: distanceMatrix, valueList: [4,3,6,8,2,12])
            let solver=GeneticTSP_Solver()
            let solution=solver.solve(num_cities: distanceMatrix.count, evaluator: evaluator)
            print(solution)
            //XCTAssertEqual(tsp_solver().text, "Hello, World!")
        }
    }

struct Point{
    let x:Float
    let y:Float
    static func time(p1:Point,p2:Point)->Float{
        return sqrt(pow(p1.x-p2.x,2)+pow(p1.y-p2.y,2))/5
    }
}
func computeDistanceMatrix(locations:[Point])->[[Float]]{
    var matrix:[[Float]]=[]
    for i in 0 ..< locations.count{
        var row=[Float]()
        for j in 0 ..< locations.count{
            row.append(Point.time(p1: locations[i], p2: locations[j]))
        }
        matrix.append(row)
    }
    return matrix
}
