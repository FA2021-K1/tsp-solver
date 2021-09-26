class UtilityTimeEvaluator:FitnessEvaluator{
    private let timeMatrix:[[Float]]
    private let valueList:[Float]
    func evaluate(r:Route)->Float{
        var e:Float=0
        var flightTime:Float=0
        for i in 1...(r.waypointIndices.count){
            flightTime+=self.timeMatrix[r.waypointIndices[i-1]][r.waypointIndices[i]]
        }
        return e
    }
    init(timeMatrix:[[Float]], valueList:[Float]){
        self.timeMatrix=timeMatrix
        self.valueList=valueList
    }
}
