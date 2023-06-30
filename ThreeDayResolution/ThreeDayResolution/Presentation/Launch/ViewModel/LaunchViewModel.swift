//
//  LaunchViewModel.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/29.
//

import Foundation

struct LaunchViewModel {
    
    //MARK: - Methods
    func launch() async -> StateData {
        let serverStateData: StateData = await getServerStateData()
        
        let versionData: VersionData = await getVersionData()
        setVersion(versionData)
        
        await fetchPolicyURL()
        
        return serverStateData
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
