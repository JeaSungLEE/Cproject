//
//  OptionRootView.swift
//  Cproject
//
//  Created by jercy on 12/3/23.
//

import SwiftUI

struct OptionRootView: View {
    @ObservedObject var viewModel: OptionViewModel
    
    var body: some View {
        Text("옵션 화면!!")
    }
}

#Preview {
    OptionRootView(viewModel: OptionViewModel())
}
