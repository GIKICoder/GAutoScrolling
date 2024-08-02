//
//  AutoTagsViewController.swift
//  GAutoScrolling
//
//  Created by GIKI on 2024/8/2.
//  Copyright © 2024 GIKI. All rights reserved.
//

import UIKit


class AutoTagsViewController: UIViewController {
    
    lazy var tagsArr: [String] = ["水电费水电费", "多少分", "飞潍坊市", "闻风丧胆", "电饭锅","给弟弟发个", "富贵花风格", "隔热", "个人股","挂号费干活", "个让哥哥", "大范甘迪风格", "二哥","给", "个人个人", "嗯", "古典风格地方","汉釜宫和", "很反感", "还让他让他", "富贵花富贵花","发个高合金钢", "干活", "激光焊接干活", "就","加油", "还让他", "刚好激光焊接", "好几块","烤鱼", "烤鱼烤鱼u英科宇", "快回家", "哭语音","人体艺", "今天有局", "很艰苦呀", "一天","几套衣服他", "二个人个人", "费伟伟", "广发华福干活","干豆腐不太热", "人烟浩穰天好热天", "复合弓", "润体乳他","今天有有人", "还让他让他", "额个热热", "讨厌就讨厌","金泰妍姐姐", "一样一样", "犹犹豫豫", "今天已经同意","加油", "今天有太阳", "贝多芬病毒", "发年货女娲娘娘"]
    
    lazy var collectionV: UICollectionView = {
        let layout = HorizontalTagsFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        cv.register(TagsCell.self, forCellWithReuseIdentifier: "TagsCell")
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    lazy var btnCommit:UIButton  = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "icon_new_login_commit"), for: .normal)
        btn.addTarget(self, action: #selector(btnCommitClicked), for: .touchUpInside)
        btn.backgroundColor = .red
        return btn
    }()
    
    // 最大可选数量
    private let maxCount: Int = 4
    // 已选择集合
    var selTagArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionV)
        view.addSubview(btnCommit)
        collectionV.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 300)
        btnCommit.frame = CGRect(x: 150, y: 500, width: 100, height: 40)
        collectionV.autoDirection = .horizontal
        collectionV.totalRepeatCount = 0
        collectionV.scrollPointsPerSecond = 30
        collectionV.startScrolling()
    }
    
    @objc func btnCommitClicked(){
        collectionV.reloadData()
    }
}

extension AutoTagsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: TagsCell = collectionV.dequeueReusableCell(withReuseIdentifier: "TagsCell", for: indexPath) as! TagsCell
        let index =  indexPath.item % tagsArr.count
        let tag = tagsArr[index]
        cell.lblTag.text = tag
        cell.setupStyle(isSelected: selTagArr.contains(tag))
        return cell
    }
    
    // 点击切换样式
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let cell: TagsCell = collectionView.cellForItem(at: indexPath) as! TagsCell
        let index =  indexPath.item % tagsArr.count
        let tagClicked = tagsArr[index]
        if selTagArr.contains(tagClicked){
            if let i = selTagArr.firstIndex(of: tagClicked){
                selTagArr.remove(at: i)
            }
            cell.setupStyle(isSelected: false)
        }
        else if selTagArr.count == maxCount{
            return
        }
        else{
            selTagArr.append(tagClicked)
            cell.setupStyle(isSelected: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let index = indexPath.item % tagsArr.count
        let width = tagsArr[index]
        return CGSize(width: labelWidth(width , 40), height: 40)
    }
    
    // 计算文本宽度
    func labelWidth(_ text: String, _ height: CGFloat) -> CGFloat{
        let size = CGSize(width: 2000, height: height)
        let font = UIFont.systemFont(ofSize: 14)
        let attr = [NSAttributedString.Key.font: font]
        let lblSize = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attr, context: nil)
        return CGFloat.minimum(lblSize.width + 20, collectionV.frame.width)
    }
}

class TagsCell: UICollectionViewCell {
    lazy var lblTag: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 14)
        lbl.backgroundColor = UIColor(rgb: 0xf5f5f5)
        return lbl
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //------
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(lblTag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lblTag.frame = contentView.bounds
        dd_View_Set_Corner(view: lblTag, radius: 6)
    }
    //------
    
    func setupStyle(isSelected: Bool){
        if isSelected{
            dd_View_Set_Border(mview: lblTag, borderW: 0.5, borderColor: UIColor(rgb: 0x8200FF))
            lblTag.backgroundColor = UIColor.white
            lblTag.textColor = UIColor(rgb: 0x8200FF)
        }
        else{
            dd_View_Set_Border(mview: lblTag, borderW: 0, borderColor: UIColor.clear)
            lblTag.backgroundColor = UIColor(rgb: 0xf5f5f5)
            lblTag.textColor = UIColor(rgb: 0x222222)
        }
    }
}

extension TagsCell{
    func dd_View_Set_Corner(view: UIView, radius: CGFloat){
        view.layer.cornerRadius = radius;
        view.layer.masksToBounds = true;
    }
    
    
    func dd_View_Set_Border(mview: UIView, borderW: CGFloat, borderColor: UIColor){
        mview.layer.borderWidth = borderW
        mview.layer.borderColor = borderColor.cgColor;
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
