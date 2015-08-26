//
//  ImageListViewController.m
//  BigEyes
//
//  Created by mac chen on 15/8/14.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "ImageListViewController.h"
#import "ImageModel.h"
#import "ImageTableViewCell.h"
#import "TTdetailViewController.h"
#import "MapViewController.h"


@interface ImageListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView    *mytableView;
    NSMutableArray *dataSource;   //数据源
    NSInteger      pageno;        //获取List的第几页
    NSInteger      pagesize;      //获取List的个数
    UIButton       *camaraBtn;    //大眼睛拍照按钮
   
   
}

@end

@implementation ImageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BigEyes";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(pushmenu)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"map"] style:UIBarButtonItemStylePlain target:self action:@selector(pushmap)];
    dataSource = [[NSMutableArray alloc]init];
   
    // Do any additional setup after loading the view.
}

- (void)createUI {
    mytableView = [UITableView new];
    [self.view addSubview:mytableView];
    mytableView.delegate = self;
    mytableView.dataSource = self;
    mytableView.delaysContentTouches = NO;
    
   //MJRefresh添加，和github上教程不一样
    [mytableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
    camaraBtn = [UIButton new];
    [self.view addSubview:camaraBtn];
    [camaraBtn setImage:[UIImage imageNamed:@"cameraBtn"] forState:UIControlStateNormal];
    [camaraBtn bk_whenTapped:^{
        NSLog(@"拍照");
    }];
    [camaraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
        make.bottom.equalTo(self.view).with.offset(20);
        
    }];

}

- (void)refreshData {
    [self createData];
}

- (void)createData {
    pageno = 1;
    pagesize = 10;
    [[TTHTTPRequest shareHTTPRequest]openAPIGetToMethod:TTImageListURL parmars:@{@"pageno":[NSNumber numberWithInteger:pageno],@"pagesize":[NSNumber numberWithInteger:pagesize]} success:^(id responseObject) {
        NSArray *arr = responseObject[@"datas"];
        for (NSDictionary *dic in arr) {
        ImageModel  *imageModel = [ImageModel objectWithKeyValues:dic];
        [dataSource addObject:imageModel];
        }
        [mytableView.header endRefreshing];
      
        [mytableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"cellID";
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.contentView.frame = CGRectMake(0, 0, tableView.frame.size.width, [self tableView:tableView heightForRowAtIndexPath:indexPath]);
        // add a UIButton that you create
    }

    [self configureCell:cell withIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return (TTScreenWidth+180)/2;
}

- (void)configureCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {

    ImageTableViewCell *imageTableViewCell = (ImageTableViewCell *)cell;
    imageTableViewCell.imagemodel          = dataSource[indexPath.row];
    [imageTableViewCell.backgroundImage sd_setImageWithURL:[NSURL URLWithString:imageTableViewCell.imagemodel.snapurl]placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [imageTableViewCell.userImage sd_setImageWithURL:[NSURL URLWithString:imageTableViewCell.imagemodel.userImage] placeholderImage:nil];
    imageTableViewCell.titleLab.text       = imageTableViewCell.imagemodel.subject;
    imageTableViewCell.time.text           = [NSString dateFormaterWithTime:imageTableViewCell.imagemodel.dateline];
    imageTableViewCell.commentBtn.tag      = 7000+indexPath.row;
    [imageTableViewCell.commentBtn bk_whenTapped:^{
        NSLog(@"%ld",imageTableViewCell.commentBtn.tag);
    }];
    [imageTableViewCell.focusBtn bk_whenTapped:^{
        NSLog(@"关注，嘿嘿");
    }];
  
    
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TTdetailViewController *detailVC;
    if (!detailVC) {
        detailVC = [[TTdetailViewController alloc]init];
    }
    detailVC.showNavi = NO;
    detailVC.haveBack = NO;
    ImageModel *imageModel = dataSource[indexPath.row];
    detailVC.detailImageURL = imageModel.snapurl;
    detailVC.tid            = imageModel.tid;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
    
}



#pragma mark 弹出menu视图
- (void)pushmap {
    MapViewController *mapVC = [[MapViewController alloc]init];
    mapVC.haveBack = YES;
    mapVC.showNavi = YES;
    [self.navigationController pushViewController:mapVC animated:YES];
}

#pragma mark 弹出地图
- (void)pushmenu {
    [self presentLeftMenuViewController:self];

}

- (void)viewWillAppear:(BOOL)animated {

    [self.navigationController setNavigationBarHidden:NO];
}


@end
