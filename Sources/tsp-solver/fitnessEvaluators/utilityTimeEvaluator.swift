import Foundation
class UtilityTimeEvaluator:FitnessEvaluator{
    private let timeMatrix:[[Float]]
    private let valueList:[Float]
    private var cache:[Route:Float]=[:]
    static let maxFlightTimeSeconds:Float=10*60
    func evaluate(r:Route)->Float{
        if cache[r]==nil{
            if r.waypointIndices.count==0{
                cache[r]=0
                return 0
            }
            var e:Float=self.valueList[r.waypointIndices[0]]
            var flightTime:Float=0
            for i in 1 ..< (r.waypointIndices.count){
                flightTime+=self.timeMatrix[r.waypointIndices[i-1]][r.waypointIndices[i]]
                e+=self.valueList[r.waypointIndices[i]]
            }
            // TODO: Add flight time to start and end
            cache[r]=e-exp(flightTime-UtilityTimeEvaluator.maxFlightTimeSeconds)-flightTime/200
        }
        return cache[r]!
    }


    init(timeMatrix:[[Float]], valueList:[Float]){
        self.timeMatrix=timeMatrix
        self.valueList=valueList
    }
}
