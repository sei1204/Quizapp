//
//  QuizViewController.swift
//  Quiz
//
//  Created by 三城聖 on 2015/12/13.
//  Copyright © 2015年 三城聖. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
//    問題文を格納する配列
    var quizArray = [AnyObject]()
    
//    正解数
    var correctAnswer: Int = 0
    
//    クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
//    選択肢のボタン
    @IBOutlet var choiceButton1: UIButton!
    @IBOutlet var choiceButton2: UIButton!
    @IBOutlet var choiceButton3: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        一時的にクイズを格納しておく配列
        var tmpArray = [AnyObject]()
        
//        tmpArrayに問題文と３つの選択肢と答えの番号の入った配列を追加していく
        tmpArray.append(["問題文１","選択肢","選択肢２","選択肢３",1])
        tmpArray.append(["問題文２","選択肢","選択肢２","選択肢３",2])
        tmpArray.append(["問題文３","選択肢","選択肢２","選択肢３",2])
        tmpArray.append(["問題文４","選択肢","選択肢２","選択肢３",3])
        tmpArray.append(["問題文５","選択肢","選択肢２","選択肢３",3])
        tmpArray.append(["問題文６","選択肢","選択肢２","選択肢３",3])
        
//        問題をシャッフルしてquizArrayに格納する
        srand(UInt32(time(nil)))
        while (tmpArray.count > 0) {
            let index = Int(rand()) % tmpArray.count
            quizArray.append(tmpArray[index])
            tmpArray.removeAtIndex(index)
        }
        choiceQuiz()
        
    }
    
    func choiceQuiz() {
        
//        問題文のテキストを表示
        quizTextView.text = quizArray[0][0] as! String
        
//        選択肢のボタンにそれぞれ選択肢のテキストをセット
        choiceButton1.setTitle((quizArray[0][1] as! String), forState: .Normal)
        choiceButton2.setTitle((quizArray[0][2] as! String), forState: .Normal)
        choiceButton3.setTitle((quizArray[0][3] as! String), forState: .Normal)
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        if quizArray[0][4] as! Int == sender.tag {
//            正解数を増やす
            correctAnswer++
        }
        
//        解いた問題をquizArrayから取り除く
        quizArray.removeAtIndex(0)
        
//        解いた問題数の合計が予め設定していた問題数に達したら結果画面へ
        
        if quizArray.count == 0 {
            performsegueToResult()
        }else {
            choiceQuiz()
        }
    }

    func performsegueToResult () {
        performSegueWithIdentifier("toResultView", sender: nil)
        
    }
    
//    セグエが選ばれた時に呼ばれるメソッド
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toResultView") {
            
            let resultView = segue.destinationViewController as! ResultViewController
            resultView.correctAnswer = self.correctAnswer
        }
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
