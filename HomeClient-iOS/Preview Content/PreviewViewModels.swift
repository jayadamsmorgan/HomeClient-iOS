import Foundation

class PreviewViewModels {
    
    let homeLightViewModel: HomeLightViewModel
    let homeSensorsViewModel: HomeSensorsViewModel
    let settingViewModel: SettingsViewModel
    
    init() {
        homeLightViewModel = HomeLightViewModel()
        homeSensorsViewModel = HomeSensorsViewModel()
        settingViewModel = SettingsViewModel()
    }
    
}
