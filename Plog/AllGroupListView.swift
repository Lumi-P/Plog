//그룹 목록을 띄우는 화면

import SwiftUI

struct AllGroupListView: View {
    @State var text : String
    @State var editText : Bool = false
    
    var body: some View {
        VStack {
            HStack{
                TextField("검색" , text : self.$text)
                    .textInputAutocapitalization(.never)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(15)
                    .overlay(
                        HStack{
                            Spacer()
                            if self.editText{
                                Button(action : {
                                    self.editText = false
                                    self.text = ""
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }){
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(Color(.black))
                                        .padding()
                                }
                            }else{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color(.black))
                                    .padding()
                            }
                        }
                    ).onTapGesture {
                        self.editText = true
                }
            }.padding(.horizontal, 20.0)
                .padding(.top, 20)
        
            //그룹 목록
            List(Groups.dummyGroupList.filter({"\($0.place)".contains(self.text) || self.text.isEmpty}), id: \.id) { group in
                NavigationLink {
                    if(group.peopleList.contains{$0.name == "개설자"}) {
                        GroupDetailView(group: group)
                            .navigationBarHidden(true)
                    } else {
                        JoinGroupView(group: group)
                            .navigationBarHidden(true)
                    }
                } label: {
                    GroupCell(group: group)
                }
            }
            .padding(.top, 0.0)
        }.background(Color(.systemGray6))
    }
}

struct AllGroupListView_Previews: PreviewProvider {
    static var previews: some View {
        AllGroupListView(text: "")
            .previewInterfaceOrientation(.portrait)
    }
}