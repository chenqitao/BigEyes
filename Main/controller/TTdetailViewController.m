//
//  TTdetailViewController.m
//  BigEyes
//
//  Created by mac chen on 15/8/18.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTdetailViewController.h"
#import "DetailImageModel.h"
#import "FavourModel.h"
#import "ImporTableViewCell.h"
#import "CommentTableViewCell.h"
#import "MenuButton.h"
#import "MenuItem.h"
#import "MenuView.h"


#define TTFavouruserImage 50
@interface TTdetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView    *mytableView;
    NSMutableArray *dataSource;         //model数据数组
    NSMutableArray *favourArr;          //点赞数组model
    UIImageView    *headImage;          //头部图片
    NSString       *lat;                //精度
    NSString       *lng;                //纬度
    NSString       *favourid;           //点赞id
    NSString       *focusid;            //关注id
    BOOL           isfavour;            //是否点赞
    BOOL           isfocus;             //是否关注
    UIView         *bottomView;         //底部评论view
    UITextField    *commenttextfield;   //评论输入框
    UIButton       *sendBtn;            //发送按钮
    

}
/** 记录scrollView上次偏移的Y距离 */
@property (nonatomic, assign) CGFloat                    scrollY;
/** 导航条的背景view */
@property (nonatomic, strong) UIView                     *naviView;
/** 导航条的title */
@property (nonatomic, strong) UILabel                    *titleLabel;
/** 导航条的title */
@property (nonatomic, strong) UIButton                   *backBtn;
/** 记录当前展示的tableView 计算顶部topView滑动的距离 */
@property (nonatomic, weak  ) UITableView                *showingTableView;




@end


@implementation TTdetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigtionBar];
    [self setUpCommentView];
    [self registNotification];
    // Do any additional setup after loading the view.
}


#pragma mark  键盘升落
- (void)registNotification {

    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShow:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];

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
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);
        
    }];
    
    headImage = [UIImageView new];
    [self.view addSubview:headImage];
    [headImage sd_setImageWithURL:[NSURL URLWithString:_detailImageURL] placeholderImage:nil];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(27);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.equalTo(@HeadViewHeight);
        
    }];

  
}

- (void)setUpNavigtionBar{
    
    //初始化山寨导航条
    _naviView = [UIView new];
    [self.view addSubview:_naviView];
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.equalTo(@TTNavigationbarHeight);
    }];
    _naviView.backgroundColor = TTColor(255, 0, 19, 1);
    _naviView.alpha = 0.0;
    
    
    //添加导航条上的大文字
    _titleLabel = [UILabel new];
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_naviView.mas_top).with.offset(15);
        make.left.equalTo(_naviView.mas_left).with.offset(TTScreenWidth/2-20);
        make.right.equalTo(_naviView.mas_right).with.offset(-50);
        make.bottom.equalTo(_naviView.mas_bottom).with.offset(-10);
    }];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont systemFontOfSize:19];
    _titleLabel.text = @"详情";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.alpha = 0;
    
    _backBtn = [UIButton new];
    [self.view addSubview:_backBtn];
    [_backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [_backBtn bk_whenTapped:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_naviView.mas_top).with.offset(20);
        make.left.equalTo(_naviView.mas_left).with.offset(10);
        make.height.equalTo(@25);
        make.width.equalTo(@25);
    }];
    
    
}

- (void)setUpCommentView {
    bottomView  = [UIView new];
    [self.view addSubview:bottomView];
    
    commenttextfield = [UITextField new];
    [bottomView addSubview:commenttextfield];
    
    sendBtn = [UIButton new];
    [bottomView addSubview:sendBtn];
    
    bottomView.backgroundColor = TTColor(255, 0, 19, 1);
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.equalTo(@50);
    }];
    
   
    commenttextfield.placeholder = @"来说说呗";
    commenttextfield.borderStyle = UITextBorderStyleRoundedRect;
    [commenttextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).with.offset(70*TTScreenWidth/640);
        make.right.equalTo(sendBtn.mas_left).with.offset(-20*TTScreenWidth/640);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
    }];
    
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn bk_whenTapped:^{
        [self sendComment];
        [self.view endEditing:YES];
        commenttextfield.text = @"";
    }];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.right.equalTo(bottomView.mas_right).with.offset(-20);
        make.width.equalTo(@50);
    }];
}



- (void)createData {
    [self loadDetailList];
}

#pragma mark   获取详情列表
- (void)loadDetailList {
    dataSource = [[NSMutableArray alloc]init];
    [[TTHTTPRequest shareHTTPRequest]openAPIGetToMethod:TTGetDetailURL parmars:@{@"tid":_tid,@"pageno":@"1",@"pagesize":@"20"} success:^(id responseObject) {
        NSArray *arr = responseObject[@"datas"];
        for (NSDictionary *dic in arr) {
            DetailImageModel *detailModel = [DetailImageModel objectWithKeyValues:dic];
            [dataSource addObject:detailModel];
        }
        [self loadFavourList];
        [[TMCache sharedCache]setObject:arr forKey:TTDetailData block:nil];
        
    } fail:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];



}

#pragma mark   获取点赞列表
- (void)loadFavourList {
    favourArr = [[NSMutableArray alloc]init];
    [[TTHTTPRequest shareHTTPRequest]openAPIPostToMethod:TTGetFavoutListURL parmars:@{@"tid":_tid} success:^(id responseObject) {
        
        NSArray *arr = responseObject[@"datas"];
        for (NSDictionary *dic in arr) {
            FavourModel *favourmodel = [FavourModel objectWithKeyValues:dic];
            [favourArr addObject:favourmodel];
            if ([[TTUserDefaultTool objectForKey:TTuid]isEqualToString:favourmodel.uid] ) {
                isfavour = YES;
                favourid = favourmodel.favour_id;
            }
        }
        [[TMCache sharedCache]setObject:arr forKey:TTFavourData block:nil];
        
        [self loadFocusList];
    } fail:^(NSError *error) {
        
    }];
 

}

#pragma mark  获取关注列表
- (void)loadFocusList {
    isfocus = NO;
    [[TTHTTPRequest shareHTTPRequest]openAPIPostToMethod:TTGetFocusListURL parmars:@{@"uid":[TTUserDefaultTool objectForKey:TTuid],@"sid":[TTUserDefaultTool objectForKey:TTSessionid]} success:^(id responseObject) {
        NSArray *focusArr = responseObject[@"datas"];
        for (NSDictionary *dic in focusArr) {
            if ([dic[@"tid"]isEqualToString:_tid]) {
                focusid = dic[@"focusid"];
                isfocus = YES;
            }
        }
        [mytableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];

}

#pragma mark  点赞
- (void)favourWithTid:(NSString *)tid {
    if (isfavour){
        [[TTHTTPRequest shareHTTPRequest]openAPIPostToMethod:TTDeleteFavourURL parmars:@{@"sid":[TTUserDefaultTool objectForKey:TTSessionid],@"tid":tid,@"favour_id":favourid} success:^(id responseObject) {
             isfavour = !isfavour;
            [self createData];
        } fail:^(NSError *error) {
            NSLog(@"error:%@",error);
        }];
    
    }
    else {
        [[TTHTTPRequest shareHTTPRequest]openAPIPostToMethod:TTFavourURL parmars:@{@"sid":[TTUserDefaultTool objectForKey:TTSessionid],@"tid":tid,@"uid":[TTUserDefaultTool objectForKey:TTuid]} success:^(id responseObject) {
            isfavour = !isfavour;
            [self createData];
        } fail:^(NSError *error) {
            NSLog(@"error:%@",error);
        }];
    
    }

}

#pragma mark  关注

- (void)focusWithTid:(NSString *)tid {
    if (isfocus){
        [[TTHTTPRequest shareHTTPRequest]openAPIPostToMethod:TTDeleteFocusURL parmars:@{@"sid":[TTUserDefaultTool objectForKey:TTSessionid],@"uid":[TTUserDefaultTool objectForKey:TTuid],@"focusid":focusid} success:^(id responseObject) {
            isfocus = !isfocus;
            [self createData];
        } fail:^(NSError *error) {
            NSLog(@"error:%@",error);
        }];
        
    }
    else {
        [[TTHTTPRequest shareHTTPRequest]openAPIPostToMethod:TTFocusURL parmars:@{@"sid":[TTUserDefaultTool objectForKey:TTSessionid],@"tid":tid,@"uid":[TTUserDefaultTool objectForKey:TTuid]} success:^(id responseObject) {
            isfocus = !isfocus;
            [self createData];
        } fail:^(NSError *error) {
            NSLog(@"error:%@",error);
        }];
        
    }


}

#pragma mark  评论
- (void)sendComment {
    
    if(![commenttextfield.text isEqualToString:@""]) {
        
    [[TTHTTPRequest shareHTTPRequest]openAPIPostToMethod:[NSString stringWithFormat:@"%@&tid=%@",TTcommentURL,_tid]
                                            parmars:@{@"sid":[TTUserDefaultTool objectForKey:TTSessionid],
                                                      @"authorid":[TTUserDefaultTool objectForKey:TTuid],
                                                      @"author":[TTUserDefaultTool objectForKey:TTname],
                                                      @"subject":@"test",
                                                      @"message":commenttextfield.text,
                                                     
                                                  }
     success:^(id responseObject) {
        [MBProgressHUD showMessageThenHide:@"评论成功" toView:self.view];
        [self createData];
        [self moveToBottom];
        
         
    } fail:^(NSError *error) {
        NSLog(@"error:%@",error);
        
    }];
        
    }
    else {
        [MBProgressHUD showMessageThenHide:@"评论内容不能为空" toView:self.view];
        
    }


}

#pragma mark 分享
- (void)share {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    MenuItem *menuItem = [[MenuItem alloc] initWithTitle:@"Sina" iconName:@"post_type_bubble_weibo" glowColor:[UIColor grayColor] index:1];
    [items addObject:menuItem];
    
    MenuItem *menuItem1 = [[MenuItem alloc] initWithTitle:@"QQ" iconName:@"post_type_bubble_QQ" glowColor:[UIColor colorWithRed:0.000 green:0.840 blue:0.000 alpha:1.000] index:2];
    [items addObject:menuItem1];
    
    MenuItem *menuItem2 = [[MenuItem alloc] initWithTitle:@"weichat" iconName:@"post_type_bubble_weichat" glowColor:[UIColor colorWithRed:0.687 green:0.000 blue:0.000 alpha:1.000] index:3];
    [items addObject:menuItem2];
    
    
    
    MenuView *centerButton = [[MenuView alloc] initWithFrame:self.view.bounds items:items];
    centerButton.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        if (selectedItem) {
            [self shareto:selectedItem.index];
        }
        
    };
    [centerButton showMenuAtView:self.view];



}

-(void )shareto:(NSUInteger )index{
    
  
}


#pragma mark tableview的scrollview移动到底部

- (void)moveToBottom {

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[TMCache sharedCache] objectForKey:TTDetailData]) {
        [dataSource removeAllObjects];
        NSArray *dataArr = [[TMCache sharedCache] objectForKey:TTDetailData];
        for (NSDictionary *dic in dataArr) {
            DetailImageModel  *detailImageModel = [DetailImageModel objectWithKeyValues:dic];
            [dataSource addObject:detailImageModel];
        }
        return dataSource.count;
    } else {
        return dataSource.count;
    }

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
        UIImage *favourBtnimage = isfavour == YES?[UIImage imageNamed:@"is_favour_yes"]:[UIImage imageNamed:@"is_favour_no"];
        UIImage *focusBtnImage  = isfocus  == YES?[UIImage imageNamed:@"is_focus_yes"]:[UIImage imageNamed:@"is_focus_no"];
        [importableviewcell.favourBtn setImage:favourBtnimage forState:UIControlStateNormal];
        [importableviewcell.focusBtn setImage:focusBtnImage forState:UIControlStateNormal];
        importableviewcell.detailModel         = dataSource[indexPath.row];
        importableviewcell.titleLab.text       = importableviewcell.detailModel.subject;
        importableviewcell.addressLab.text     = @"";
        
        //获取点赞列表，并将头像放到scrollview上
        //移除scroll上面的所有子视图
        for (UIView *obj in importableviewcell.scroll.subviews) {
            [obj removeFromSuperview];
        }
       //判断缓存点赞数组是否为空，如为空则不改，如不为空则取缓存
        favourArr = [[[TMCache sharedCache]objectForKey:TTFavourData]isKindOfClass:[NSNull class]]?favourArr:[[TMCache sharedCache]objectForKey:TTFavourData];
        importableviewcell.scroll.contentSize  = CGSizeMake(TTFavouruserImage*favourArr.count, TTFavouruserImage);
        for (int i=0;i<favourArr.count;i++ ) {
            UIImageView *userImage = [[UIImageView alloc]initWithFrame:CGRectMake(i*(TTFavouruserImage+10)+10, 0, TTFavouruserImage, TTFavouruserImage)];
            
        //设置圆角以及边框颜色
            userImage.layer.cornerRadius = TTFavouruserImage/2;
            [userImage.layer setMasksToBounds:YES];
            userImage.layer.borderWidth  = 1;
            userImage.layer.borderColor  = TTColor(255, 48, 48, 1).CGColor;
            
        
            FavourModel *favourmodel = [FavourModel objectWithKeyValues:favourArr[i]];
            [userImage sd_setImageWithURL:[NSURL URLWithString:favourmodel.userImage]];
            [importableviewcell.scroll addSubview:userImage];
        }
        
        [importableviewcell.favourBtn bk_whenTapped:^{
            [self favourWithTid:_tid];
        }];
        
        [importableviewcell.focusBtn bk_whenTapped:^{
            [self focusWithTid:_tid];
        }];
        
        [importableviewcell.shareBtn bk_whenTapped:^{
            [self share];
        }];
    
    
    }
    else {
       
        CommentTableViewCell *commenttablecell = (CommentTableViewCell *)cell;
        commenttablecell.detailModel           = dataSource[indexPath.row];
        commenttablecell.commentLab.text       = commenttablecell.detailModel.message;
        commenttablecell.nameLab.text          = commenttablecell.detailModel.username;
        commenttablecell.timeLab.text          = [NSString dateFormaterWithTime:commenttablecell.detailModel.dateline];
        [commenttablecell.Icon sd_setImageWithURL:[NSURL URLWithString:commenttablecell.detailModel.avatar_url] placeholderImage:nil];

    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    if (scrollView == mytableView) {
        
        
        //记录出上一次滑动的距离，因为是在tableView的contentInset中偏移的ScrollHeadViewHeight，所以都得加回来
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat delta   = offsetY - self.scrollY;  //与上次存放的值相减
        self.scrollY    = offsetY;
        
        
        //修改顶部的scrollHeadView位置 并且通知scrollHeadView内的控件也修改位置
        CGRect headRect = headImage.frame;
        headRect.origin.y -= delta;
        headImage.frame = headRect;
    
    
    // CGFloat alphaScaleShow = (offsetY ) / ( naviH+ ScrollHeadViewHeight);
    //根据偏移量算出alpha的值,渐隐,当偏移量大于-180开始计算消失的值
    CGFloat startF = -200;
    //初始的偏移量Y值为 顶部控件的高度
    CGFloat initY  = HeadViewHeight;
    //缺少的那一段渐变Y值
    CGFloat lackY  = initY + startF;
    //渐现alpha值
    CGFloat alphaScaleShow = (offsetY + initY - lackY) /  (initY - naviH  - lackY) ;
    
    
    if (alphaScaleShow >= 0.98) {
        //显示导航条
        [UIView animateWithDuration:0.04 animations:^{
            self.naviView.alpha   = 1;
            self.titleLabel.alpha = 1;
        }];
    } else {
        self.naviView.alpha   = 0;
        self.titleLabel.alpha = 0;
    }
    /**
     *  改变naviView的alpha值
     */
    
    self.naviView.alpha   = alphaScaleShow;
    self.titleLabel.alpha = alphaScaleShow;
    
    
    //缩放图片
    
    CGFloat scaleTopView = 1 - (offsetY  + HeadViewHeight) / 100;
    scaleTopView = scaleTopView > 1 ? scaleTopView : 1;
    
    CGAffineTransform transform = CGAffineTransformMakeScale(scaleTopView, scaleTopView );
    CGFloat ty = (scaleTopView - 1) * HeadViewHeight;
    headImage.transform = CGAffineTransformTranslate(transform, 0, -ty * 0.2);

    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

  
    if (indexPath.row == 0) {
        return 150;
    }
    else {
        static NSString *identifier = @"cellID";
        CommentTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [self configureCell:cell withIndexPath:indexPath];
        if ([cell.detailModel.subject isEqualToString:@""]) {
            return 60;
        }
        else {
       
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
            CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
            return height;
             }
        }
    
  

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.view endEditing:YES];
}


#pragma mark  键盘升落方法

- (void) keyboardWasShow:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    
    CGSize keyboardSize = [value CGRectValue].size;
   //这里做一点小小的调整，解决键盘挡住输入框的问题
    keyboardSize.height = keyboardSize.height == 216?252:keyboardSize.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0, -keyboardSize.height, TTScreenWidth, TTScreenHeight);
        
    }];
    
    
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    float duration = [info [UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    
    [UIView animateWithDuration:duration animations:^{
        //[myTableView scrollRectToVisible:CGRectMake(0, 0, kWidth, kHeight) animated:YES];
        self.view.frame = CGRectMake(0, 0, TTScreenWidth, TTScreenHeight );
    }];
  
    
}










@end
