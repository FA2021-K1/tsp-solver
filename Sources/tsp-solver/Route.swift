
struct Route:Hashable{
    let waypointIndices:[Int]
    func mutate(numTasks:Int)->Route{
        let mutationFloat=Float.random(in: 0..<1)
        if waypointIndices.count==0{
            return Route(waypointIndices:[Int.random(in: 0..<numTasks)])
        }else if  mutationFloat<0.4{
            // remove random element
            var newWaypoints=waypointIndices
            newWaypoints.remove(at: Int.random(in: 0..<(waypointIndices.count)))
            return Route(waypointIndices: newWaypoints)
        }else if (waypointIndices.count==1 || mutationFloat<0.7) && waypointIndices.count<numTasks{
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
        let minFinalLength=min(parent1.waypointIndices.count,parent2.waypointIndices.count)
        let maxFinalLength=max(parent1.waypointIndices.count,parent2.waypointIndices.count)
        let finalLength=Int.random(in: minFinalLength...maxFinalLength)
        let filteredParent2Waypoints=parent2.waypointIndices.filter({point in !parent1.waypointIndices.contains(point)})
        let minFirstSplitPoint=max(0,finalLength-filteredParent2Waypoints.count)
        let maxFirstSplitPoint=min(parent1.waypointIndices.count,finalLength)
        let firstSplitPoint=Int.random(in: minFirstSplitPoint...maxFirstSplitPoint)
        var newWaypoints=[Int](repeating:0,count:finalLength)
        for i in 0..<firstSplitPoint{
            newWaypoints[i]=parent1.waypointIndices[i]
        }
        let secondSlitPoint=finalLength-firstSplitPoint
        for i in 0..<secondSlitPoint{
            newWaypoints[firstSplitPoint+i] = filteredParent2Waypoints[i]
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
