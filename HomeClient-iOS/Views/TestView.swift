//
//  TestView.swift
//  HomeClient-iOS
//
//  Created by user on 8/21/23.
//

import SwiftUI

struct TestView: View {
    
    @StateObject var homeViewModel: HomeLightViewModel
    
    init(homeViewModel: HomeLightViewModel) {
        _homeViewModel = StateObject(wrappedValue: homeViewModel)
    }
    
    var body: some View {
        VStack {
            
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(homeViewModel: HomeLightViewModel())
    }
}
