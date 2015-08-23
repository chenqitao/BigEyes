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

#define TTFavouruserImage 50
@interface TTdetailViewController ()<UITableViewDataSource,UITableViewDelegate>
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
        make.left.equalTo(_naviView.mas_left).with.offset(TTScreenWith/2-20);
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



- (void)createData {
    dataSource = [[NSMutableArray alloc]init];
    [[TTHTTPRequest shareHTTPRequest]openAPIGetToMethod:TTGetDetailURL parmars:@{@"tid":_tid,@"pageno":@"1",@"pagesize":@"20"} success:^(id responseObject) {
        NSArray *arr = responseObject[@"datas"];
        for (NSDictionary *dic in arr) {
            DetailImageModel *detailModel = [DetailImageModel objectWithKeyValues:dic];
            [dataSource addObject:detailModel];
        }
        [self loadFavourList];
       
        
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
        importableviewcell.scroll.contentSize  = CGSizeMake(TTFavouruserImage*favourArr.count, TTFavouruserImage);
        for (int i=0;i<favourArr.count;i++ ) {
            UIImageView *userImage = [[UIImageView alloc]initWithFrame:CGRectMake(i*(TTFavouruserImage+10)+10, 0, TTFavouruserImage, TTFavouruserImage)];
            
        //设置圆角以及边框颜色
            userImage.layer.cornerRadius = TTFavouruserImage/2;
            [userImage.layer setMasksToBounds:YES];
            userImage.layer.borderWidth  = 1;
            userImage.layer.borderColor  = TTColor(255, 48, 48, 1).CGColor;
            
            FavourModel *favourmodel = favourArr[i];
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
            NSLog(@"分享");
        }];
    
    
    }
    else {
       
        CommentTableViewCell *commenttablecell = (CommentTableViewCell *)cell;
        commenttablecell.detailModel           = dataSource[indexPath.row];
        commenttablecell.commentLab.text       = commenttablecell.detailModel.subject;
//        commenttablecell.commentLab.text       = @"最近，一直在看浙江卫视的音乐节目《中国好声音》,最近，一直在看浙江卫视的音乐节目《中国好声音》";
        commenttablecell.nameLab.text          = commenttablecell.detailModel.username;
        commenttablecell.timeLab.text          = commenttablecell.detailModel.dateline;
        [commenttablecell.Icon sd_setImageWithURL:[NSURL URLWithString:commenttablecell.detailModel.avatar_url] placeholderImage:nil];
      
        
        
    }
    
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == mytableView) {
        
        
        //记录出上一次滑动的距离，因为是在tableView的contentInset中偏移的ScrollHeadViewHeight，所以都得加回来
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat delta   = offsetY - self.scrollY;  //与上次存放的值相减
        self.scrollY = offsetY;
        
        
        //修改顶部的scrollHeadView位置 并且通知scrollHeadView内的控件也修改位置
        CGRect headRect = headImage.frame;
        headRect.origin.y -= delta;
        headImage.frame = headRect;
    
    
    // CGFloat alphaScaleShow = (offsetY ) / ( naviH+ ScrollHeadViewHeight);
    //根据偏移量算出alpha的值,渐隐,当偏移量大于-180开始计算消失的值
    CGFloat startF = -200;
    //初始的偏移量Y值为 顶部控件的高度
    CGFloat initY = HeadViewHeight;
    //缺少的那一段渐变Y值
    CGFloat lackY = initY + startF;
    //渐现alpha值
    CGFloat alphaScaleShow = (offsetY + initY - lackY) /  (initY - naviH  - lackY) ;
    
    
    if (alphaScaleShow >= 0.98) {
        //显示导航条
        [UIView animateWithDuration:0.04 animations:^{
            self.naviView.alpha = 1;
            self.titleLabel.alpha = 1;
        }];
    } else {
        self.naviView.alpha = 0;
        self.titleLabel.alpha = 0;
    }
    /**
     *  改变naviView的alpha值
     */
    
    self.naviView.alpha = alphaScaleShow;
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
        CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
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



@end
