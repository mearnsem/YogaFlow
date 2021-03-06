//
//  PoseController.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/15/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation
import CoreData

class PoseController {
    
    static let baseUrl = "https://yoga-api.firebaseio.com/poses.json"
    
    static func fetchPoses(completion: (poses: [Pose]) -> Void) {
        guard let url = NSURL(string: baseUrl) else {
            completion(poses: [])
            return
        }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(poses: [])
            }
            guard let data = data,
                jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject] else {
                    completion(poses: [])
                    return
            }
            let poses = jsonDictionary.flatMap { Pose(name: $0, dictionary: $1 as! [String: AnyObject]) }.sort({$0.0.name < $0.1.name})
            dispatch_async(dispatch_get_main_queue(), { 
                completion(poses: poses)
            })
            
        }
    }
    
    static var types: [Type] {
        let request = NSFetchRequest(entityName: "Type")
        
        return (try? Stack.sharedStack.managedObjectContext.executeFetchRequest(request)) as? [Type] ?? []
    }
    
    static func searchPoses(poses: [Pose], searchTerm: String) -> [Pose] {
        let sortedPoses = poses.filter { $0.name.lowercaseString.containsString(searchTerm.lowercaseString) }
        
        return sortedPoses
        
//        fetchPoses { (poses) in
//            for pose in poses {
//                if pose.name.containsString(searchTerm) {
//                    sortedPoses.append(pose)
//                }
////                if checkIfPoseTypesContainsTerm(pose, term: searchTerm) == true {
////                    sortedPoses.append(pose)
////                }
//            }
//        }
    }
    
    static func checkIfPoseTypesContainsTerm(pose: Pose, term: String) -> Bool {
        for poseType in pose.types {
            if let type = poseType as? Type {
                if type.name.containsString(term.lowercaseString) {
                    return true
                }
            }
        }
        return false
    }
}