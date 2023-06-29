//
//  FirebaseService.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import UIKit
import Firebase

final class FirebaseService {
    static let shared: FirebaseService = FirebaseService()
    private init() { }

    //MARK: - Properties
    private var firebaseRef: DatabaseReference!
    
    //MARK: - Methods
    func initFirebase() {
        configureFirebase()
        initFirebaseRef()
    }
    
    func configureFirebase() {
        FirebaseApp.configure()
    }
    
    func initFirebaseRef() {
        firebaseRef = Database.database().reference()
    }
    
    func fetchState() async -> StateData {
        var snapshot: DataSnapshot?
        do {
            snapshot = try await firebaseRef.child("state").getData()
        } catch {
            Logger.log(level: .error, error.localizedDescription)
        }
        
        let snapData = snapshot?.value as? [String: String]
        
        let result = snapData?["result"] ?? "fail"
        let notice = snapData?["notice"] ?? ""
        Logger.log("result: \(result) / notice: \(notice)")
        
        let stateData: StateData = .init(state: StateData.StateResult(rawValue: result) ?? .fail,
                                         notice: notice)
        
        return stateData
    }

    func fetchVersion() async -> VersionData {
        var snapshot: DataSnapshot?
        do {
            snapshot = try await firebaseRef.child("version").getData()
        } catch {
            Logger.error(error.localizedDescription)
        }
        
        let snapData = snapshot?.value as? [String: String]

        let forced = snapData?["forced"] ?? "0.0.0"
        let lasted = snapData?["lasted"] ?? "0.0.0"
        let appleID = snapData?["appleID"] ?? ""
        let bundleID = snapData?["bundleID"] ?? ""
        
        let versionData: VersionData = VersionData(forced: forced,
                                                   lasted: lasted,
                                                   appleID: appleID,
                                                   bundleID: bundleID)
        
        Logger.log("versions: \(versionData)")
        return versionData
    }
    
    func fetchPolicyURL() async -> String {
        var snapshot: DataSnapshot?
        do {
            snapshot = try await firebaseRef.child("policyURL").getData()
        } catch {
            Logger.error(error.localizedDescription)
        }
        
        let policyURL = snapshot?.value as? String ?? ""
        
        return policyURL
    }
}
