
//  DiscussionBoardViewController.swift
//  Plog

import UIKit
import FirebaseFirestore
import FirebaseStorage


class DiscussionBoardViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
//    let navigationBarAppearance = UINavigationBarAppearance()
    struct discussionBoard{
        var dTitle: String
        var dId: String
    }
    var boardTitle = [discussionBoard]()
    
    @IBOutlet weak var discussionTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardTitle.count
    }
    @IBAction func backBnt(_ sender: Any) {
  /*      let nextVC = UIStoryboard(name: "Community", bundle: nil).instantiateViewController(withIdentifier: "CommunityViewController") as! CommunityViewController
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)*/
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postBnt(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCell else{
            return UITableViewCell()
        }
        let board = boardTitle[indexPath.row]
        //db 데이터로 변경
        cell.labelTitle.text = board.dTitle as? String
        return cell
    }
    func tableView(_tableView:UITableView,heightForRowAt indexPath:IndexPath)->CGFloat{
        return 100.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        setDiscussionData()
    //    navigationBarAppearance.backgroundColor = .systemGray6
    }
    
    //상세 페이지로 이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DiscussionPostViewController", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let nextVC = segue.destination as! DiscussionPostViewController
     //       nextVC.receiveId = MyCell().uuid
            //문서 아이디 전달: 변경 필요
     //       nextVC.receiveId = "qPKLJSL6swUUzdrHGlPC"
      //      nextVC.receiveId = discussionBoard(dId: document.documentID)
          
            nextVC.modalPresentationStyle = .fullScreen
        }
        
        
    }
    func setDiscussionData(){
        let db = Firestore.firestore()
        db.collection("discussion").getDocuments(){(querySnapshot, err) in
            if let err = err {
                print(err)
            } else{
                for document in querySnapshot!.documents {
                    self.boardTitle.append(discussionBoard(dTitle: document.data()["ttitle"] as? String ?? "", dId: document.documentID))
                }
                self.discussionTableView.reloadData()
            }
        }
    }
}
class MyCell:UITableViewCell{
 //   var uuid:String = ""
    var documentIDString: String!
    @IBOutlet weak var labelTitle:UILabel!
}
