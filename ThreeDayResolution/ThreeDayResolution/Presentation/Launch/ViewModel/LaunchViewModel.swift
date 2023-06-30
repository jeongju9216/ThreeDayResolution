//
//  LaunchViewModel.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import Foundation

struct LaunchViewModel {
    
    private let runDateKey = "RunDate"
    private let runCountKey = "RunCount"
    
    //MARK: - Properties
    init() { }
    
    //MARK: - Methods
    func launch() async -> StateData {
        let serverStateData: StateData = await getServerStateData()
        
        let versionData: VersionData = await getVersionData()
        setVersion(versionData)
        
        await fetchPolicyURL()
        
        return serverStateData
    }
    
    func fetchLastRunDate() -> Date {
        let date = UserDefaults.standard.object(forKey: runDateKey) as! Date
        return date
    }
    
    func saveRunDate() {
        UserDefaults.standard.set(Date(), forKey: runDateKey)
        
        let runCount = UserDefaults.standard.integer(forKey: runCountKey) + 1
        UserDefaults.standard.set(runCount, forKey: runCountKey)
    }
    
    private func getServerStateData() async -> StateData {
        return await FirebaseService.shared.fetchState()
    }
    
    private func getVersionData() async -> VersionData {
        return await FirebaseService.shared.fetchVersion()
    }
    
    private func setVersion(_ version: VersionData) {
        BaseData.shared.currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        
        BaseData.shared.forcedUpdateVersion = version.forced
        BaseData.shared.lastetVersion = version.lasted
        
        BaseData.shared.appleID = version.appleID
        BaseData.shared.bundleID = version.bundleID
    }
    
    private func fetchPolicyURL() async {
        BaseData.shared.policyURL = await FirebaseService.shared.fetchPolicyURL()
    }
}
