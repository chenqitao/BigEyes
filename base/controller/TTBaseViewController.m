//
//  TTBaseViewController.m
//  sinaForJackchen
//
//  Created by mac chen on 15/7/28.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTBaseViewController.h"

@interface TTBaseViewController ()

@end

@implementation TTBaseViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}

-(id)initWithTableViewOrNOt:(BOOL)haveTableView{
    
    self  = [super init];
    if (self) {
        
    }
    
    return self;
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
    }
    
    return  self;
}

-(void)setUpUIWithTableOrNOt:(BOOL)haveTableView{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _haveBack = YES;
    _showNavi = YES;
    
    if (haveTableView) {
        _myTableView = [UITableView new];
        [self.view addSubview:_myTableView];
        _myTableView.delegate = (id<UITableViewDelegate>)self;
        _myTableView.dataSource = (id<UITableViewDataSource>)self;
        _myTableView.tableFooterView = [[UIView alloc]init];
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.showsVerticalScrollIndicator = NO;
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //self.navigationController.navigationBar.barTintColor=TTColor(255, 48, 48, 1);
    if (_haveBack) {
        self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(returenBtnTapped:)];
        
    }
    
    if (_showNavi) {//默认展示导航栏
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        
    }else{
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    }
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    
    [self createUI];
    [self createData];
    if (_showMenu) {
         self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(willShowMenu)];
        
    }
}
-(void)returenBtnTapped:(id)sender{
    if (_isShowModal) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)willShowMenu
{
   
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
   
}
-(void)createUI{
    
}
-(void)createData{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



@end
