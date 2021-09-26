struct Route:Hashable{
    let waypointIndices:[Int]
    func mutate(numTasks:Int)->Route{
        let mutationFloat=Float.random(in: 0..<1)
        if waypointIndices.count==0{
            return Route(waypointIndices:[Int.random(in: 0..<numTasks)])
        }else if  mutationFloat<0.2{
            // remove random element
            var newWaypoints=waypointIndices
            newWaypoints.remove(at: Int.random(in: 0..<(waypointIndices.count)))
            return Route(waypointIndices: newWaypoints)
        }else if (waypointIndices.count==1 || mutationFloat<0.4) && waypointIndices.count<numTasks{
            // add random element
            var newWaypoints=waypointIndices
            // get task which is not yet added
            var toAdd = -1
            while toAdd == -1{
                let toTest=Int.random(in: 0..<numTasks)
                if !waypointIndices.contains(toTest){
                    toAdd=toTest
                }
            }
            newWaypoints.append(toAdd)
            return Route(waypointIndices: newWaypoints)
        }else{
            // swap random elements
            let index1=Int.random(in: 0..<(waypointIndices.count))
            let index2=Int.random(in: 0..<(waypointIndices.count))
            var newWaypoints=waypointIndices
            let tmp=newWaypoints[index1]
            newWaypoints[index1]=newWaypoints[index2]
            newWaypoints[index2]=tmp
            return Route(waypointIndices: newWaypoints)
        }
    }
    static func produceOffspring(parent1:Route, parent2:Route, numTasks:Int)->Route{
        let splitPoint=Int.random(in: 0..<(parent1.waypointIndices.count))
        var newWaypoints=[Int](repeating:0,count:splitPoint)
        for i in 0..<splitPoint{
            newWaypoints[i]=parent1.waypointIndices[i]
        }
        let secondSlitPoint=Int.random(in: 0..<(parent2.waypointIndices.count))
        for i in 0..<secondSlitPoint{
            if !parent1.waypointIndices.contains(parent2.waypointIndices[i]){
                newWaypoints.append(parent2.waypointIndices[i])
            }
        }
        return Route(waypointIndices: newWaypoints)
    }
    static func produceRandom(numTasks:Int)->Route{
        var t=Route(waypointIndices:[])
        for _ in 0..<50{
            t=t.mutate(numTasks: numTasks)
        }
        return t
    }
    static func == (lhs: Route, rhs: Route) -> Bool {
        return lhs.waypointIndices==rhs.waypointIndices
    }

    func hash(into hasher: inout Hasher) {
        self.waypointIndices.hash(into: &hasher)
    }
}