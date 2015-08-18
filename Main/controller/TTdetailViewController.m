//
//  TTdetailViewController.m
//  BigEyes
//
//  Created by mac chen on 15/8/18.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTdetailViewController.h"
#import "DetailImageModel.h"
#import "ImporTableViewCell.h"
#import "CommentTableViewCell.h"

@interface TTdetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
   UITableView    *mytableView;
   NSMutableArray *dataSource;         //model数据数组
   UIImageView    *headImage;          //头部图片

}
/** 记录scrollView上次偏移的Y距离 */
@property (nonatomic, assign) CGFloat                    scrollY;
/** 导航条的背景view */
@property (nonatomic, strong) UIView                     *naviView;
/** 导航条的title */
@property (nonatomic, strong) UILabel                    *titleLabel;
/** 记录当前展示的tableView 计算顶部topView滑动的距离 */
@property (nonatomic, weak  ) UITableView                *showingTableView;



@end


@implementation TTdetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUpNavigtionBar];
    // Do any additional setup after loading the view.
}

- (void)createUI {
 
    mytableView = [UITableView new];
    [self.view addSubview:mytableView];
    mytableView.delegate = self;
    mytableView.dataSource = self;
    mytableView.rowHeight = UITableViewAutomaticDimension;
    mytableView.estimatedRowHeight = 30;
    //这一句非常重要，设置tableview的内容视图边距
    mytableView.contentInset = UIEdgeInsetsMake(HeadViewHeight, 0, 0, 0);
    [mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
    }];
    
    headImage = [UIImageView new];
    [self.view addSubview:headImage];
    [headImage sd_setImageWithURL:[NSURL URLWithString:_detailImageURL] placeholderImage:nil];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.equalTo(@HeadViewHeight);
        
    }];


}

- (void)setUpNavigtionBar{
    
    //初始化山寨导航条
    self.naviView = [UIView new];
    [self.view addSubview:self.naviView];
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.equalTo(@TTNavigationbarHeight);
    }];
    self.naviView.backgroundColor = TTColor(255, 0, 19, 1);
    self.naviView.alpha = 0.0;
    
    
    //添加导航条上的大文字
    self.titleLabel = [UILabel new];
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.naviView.mas_top).with.offset(15);
        make.left.equalTo(self.naviView.mas_left).with.offset(TTScreenWith/2-60);
        make.right.equalTo(self.naviView.mas_right).with.offset(-50);
        make.bottom.equalTo(self.naviView.mas_bottom).with.offset(-10);
    }];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:19];
    self.titleLabel.text = @"详情";
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.alpha = 0;
    
    
}



- (void)createData {
  dataSource = [[NSMutableArray alloc]init];
    [[TTHTTPRequest shareHTTPRequest]openAPIGetToMethod:TTGetDetailURL parmars:@{@"tid":[NSNumber numberWithInteger:_tid],@"pageno":@"1",@"pagesize":@"20"} success:^(id responseObject) {
        NSArray *arr = responseObject[@"datas"];
        for (NSDictionary *dic in arr) {
            DetailImageModel *detailModel = [DetailImageModel objectWithKeyValues:dic];
            [dataSource addObject:detailModel];
        }
        [mytableView reloadData];
        
    } fail:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cellID";
    if (indexPath.row == 0) {
        ImporTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ImporTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [self configureCell:cell withIndexPath:indexPath];
        return cell;
    }
    else {
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [self configureCell:cell withIndexPath:indexPath];
        return cell;
       
    
    }

}

- (void)configureCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ImporTableViewCell *importableviewcell = (ImporTableViewCell *)cell;
        [importableviewcell.favourBtn setImage:[UIImage imageNamed:@"is_favour_no"] forState:UIControlStateNormal];
        [importableviewcell.focusBtn setImage:[UIImage imageNamed:@"is_focus_no"] forState:UIControlStateNormal];
        importableviewcell.detailModel         = dataSource[indexPath.row];
        importableviewcell.titleLab.text       = importableviewcell.detailModel.subject;
        importableviewcell.addressLab.text     = @"";

    
    
    }
    else {
        CommentTableViewCell *commenttablecell = (CommentTableViewCell *)cell;
        commenttablecell.detailModel           = dataSource[indexPath.row];
        commenttablecell.commentLab.text       = commenttablecell.detailModel.subject;
        commenttablecell.nameLab.text          = commenttablecell.detailModel.username;
        commenttablecell.timeLab.text          = commenttablecell.detailModel.dateline;
        [commenttablecell.Icon sd_setImageWithURL:[NSURL URLWithString:commenttablecell.detailModel.avatar_url] placeholderImage:nil];
        
        
    }
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    }
    else  return 70;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        return 200;
    }
    else  return 70;
 

}

@end
