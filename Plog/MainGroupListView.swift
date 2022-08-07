//그룹 목록 페이지

import SwiftUI

struct MainGroupListView: View {
    //상단 메뉴 스타일
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemGreen
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .body)], for: .normal)
    }
    
    @State private var selectedSide: SideOfTheForce = .allG
    @State private var showComposer: Bool = false
    @State private var sheetPresented = false
    @State private var theId = 0

    var body: some View {
        NavigationView {
            VStack {
                //상단 메뉴
                Picker(selection: $selectedSide, label: Text("")) {
                    ForEach(SideOfTheForce.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.top, .leading, .trailing])
                
                ZStack {
                    //그룹 목록
                    ChosenGroup(selectedSide: selectedSide)
                        .id(theId)
                    
                    //버튼: 그룹 추가 페이지로 이동
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                sheetPresented.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                            }.fullScreenCover(isPresented: $sheetPresented) {
                                ComposeGroupView()
                                    .navigationBarHidden(true)
                                    .onDisappear{
                                        self.theId += 1
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear{self.theId += 1}
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainGroupListView()
    }
}

//SwiftUI 뷰를 UIHostingController로 감싸서 UIKit에서 사용함
class MainGroupListVHC: UIHostingController<MainGroupListView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: MainGroupListView())
    }
}
