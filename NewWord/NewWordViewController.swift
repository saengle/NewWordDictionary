//
//  NewWordViewController.swift
//  NewWord
//
//  Created by 쌩 on 5/17/24.
//

import UIKit

class NewWordViewController: UIViewController {
    
    @IBOutlet var searchTextFieldView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var firstRecommandWordLabel: UILabel!
    @IBOutlet var secondRecommandWordLabel: UILabel!
    @IBOutlet var thirdRecommandWordLabel: UILabel!
    
    @IBOutlet var recommandWordLabelList: [UILabel]!
    
    @IBOutlet var topView: UIView!
    @IBOutlet var wholeView: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var explanationLabel: UILabel!
    
    let newWordDict: [String: String] = ["오우예 씨몬!": "Oh Yeah C'mon 에서 탄생된 밈으로 특별한 의미는 없으며, 감탄사의 느낌으로 '오우야', '오우예아'같은 느낌입니다.", "가나디" : "강아지를 더욱 앙증맞게 부르는 단어입니다.", "당모치" : "당연히 모든 치킨은 옳다 라는 의미입니다.", "잼얘": "재미있는 이야기를 줄인 말입니다.", "뉴런공유" : "주로 나와 생각이나 행동이 비슷한 사람을 보고 뉴런을 공유한 것과 같이 유사하다고 말을 할 때 쓰이는 단어입니다.", "분모자처럼 뽑네" : "아이디어나 생각을 끊임없이 발휘하거나 능력, 실력이 출중하다는 의미입니다.", "드르륵 칵" : "편의점 야외에 설치된 플라스틱 의자를 지칭하는 단어입니다.", "말아주다": "아이돌 팬덤에서 주로 사용하는 단어로 나의 최애 가수가 무언가를 해줄 때 사용하는 단어입니다.", "갓생": "'신(GOD) + 인생'이 합쳐진 단어로 '남들보다 열심히 살아가는 모습'이라는 뜻을 갖고 있습니다.", "비담": "비주얼 담당을 줄여 말하는 말 입니다.", "꾸안꾸": "꾸민 듯 안꾸민 듯 자연스럽게 꾸민 모습을 뜻합니다.", "트민남": "트렌드에 민감한 남자 라는 뜻으로 연예인이나 SNS 인플루언서들이 입는 옷이나 패션, 취미, 음식 등을 좇아 따라하는 사람을 말합니다."]
    
    var dictKeyList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        self.searchTextFieldView.backgroundColor = .black
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.backgroundColor = .black
        searchButton.tintColor = .white
        
        setLabelUI(label: recommandWordLabelList[0])
        setLabelUI(label: recommandWordLabelList[1])
        setLabelUI(label: recommandWordLabelList[2])
        
        topView.layer.borderWidth = 2
        topView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        wholeView.layer.borderWidth = 2
        wholeView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        bottomView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        explanationLabel.text = ""
        explanationLabel.numberOfLines = 0
        
        for key in newWordDict.keys {
            dictKeyList.append(key)
        }
        
        makeRandomRecommand()
        
//        탭제스쳐레코나이져 1개로 세가지를 사용하려면 어떻게 하쥬 ..
        let tapFirst = UITapGestureRecognizer(target: self, action: #selector(NewWordViewController.tapFirstFunction))
        let tapSecond = UITapGestureRecognizer(target: self, action: #selector(NewWordViewController.tapSecondFunction))
        let tapThird = UITapGestureRecognizer(target: self, action: #selector(NewWordViewController.tapThirdFunction))
        
        recommandWordLabelList[0].isUserInteractionEnabled = true
        recommandWordLabelList[0].addGestureRecognizer(tapFirst)
        recommandWordLabelList[1].isUserInteractionEnabled = true
        recommandWordLabelList[1].addGestureRecognizer(tapSecond)
        recommandWordLabelList[2].isUserInteractionEnabled = true
        recommandWordLabelList[2].addGestureRecognizer(tapThird)
        
        
        addTapGestureRecognizer(labelList: recommandWordLabelList)
    }
    func setLabelUI(label: UILabel) {
        label.sizeToFit()
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        explanationLabel.text = newWordDict[searchTextField.text!, default: "알맞은 검색어를 입력하세요."]
        makeRandomRecommand()
    }
    
    private func makeRandomRecommand() {
        var tempRandomNumList = Set<Int>()
        while tempRandomNumList.count != 3 {
            tempRandomNumList.insert(Int.random(in: 0...dictKeyList.count-1))
        }
        for i in 0...2 {
            recommandWordLabelList[i].text = dictKeyList[Array(tempRandomNumList)[i]]
        }
    }
    
    private func addTapGestureRecognizer(labelList: [UILabel]) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(NewWordViewController.tapRecommandLabel))

        recommandWordLabelList.forEach{$0.isUserInteractionEnabled = true}
        recommandWordLabelList.forEach{$0.addGestureRecognizer(tap)}
    }
    
    @objc func tapFirstFunction(sender:UITapGestureRecognizer) {
        searchTextField.text = recommandWordLabelList[0].text
        explanationLabel.text = newWordDict[searchTextField.text!, default: "알맞은 검색어를 입력하세요."]
        makeRandomRecommand()
        }
    
    @objc func tapSecondFunction(sender:UITapGestureRecognizer) {
        searchTextField.text = recommandWordLabelList[1].text
        explanationLabel.text = newWordDict[searchTextField.text!, default: "알맞은 검색어를 입력하세요."]
        makeRandomRecommand()
        }
    
    @objc func tapThirdFunction(sender:UITapGestureRecognizer) {
        searchTextField.text = recommandWordLabelList[2].text
        explanationLabel.text = newWordDict[searchTextField.text!, default: "알맞은 검색어를 입력하세요."]
        makeRandomRecommand()
        }
    
    @objc func tapRecommandLabel(_ sender: UITapGestureRecognizer) {
        searchTextField.text = recommandWordLabelList[sender.view?.tag ?? 0].text
        explanationLabel.text = newWordDict[searchTextField.text!, default: "알맞은 검색어를 입력하세요."]
        makeRandomRecommand()
    }

}
