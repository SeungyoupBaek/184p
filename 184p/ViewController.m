//
//  ViewController.m
//  184p
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#define CELL_ID @"CELL_ID"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>{
    NSMutableArray *data;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
    // 입력문자열길이가 2보다 클때만 추가가능
    NSString * inputStr = [alertView textFieldAtIndex:0].text;
    return [inputStr length] > 2;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // 데이터 추가
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *name = [alertView textFieldAtIndex:0];
        
        if (name > 0) {
            NSString *addData = name.text;
            [data addObject:addData];
            // 테이블뷰에 추가
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(data.count -1) inSection:0];
            NSArray *row = [NSArray arrayWithObject:indexPath];
            [self.table insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

-(IBAction)toggleEdit:(id)sender{
    self.table.editing = !self.table.editing;
}

// 각 스타일을 번갈아가면서 사용
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row%3 == 0) {
        return UITableViewCellEditingStyleNone;
    }else if (indexPath.row%3 == 1){
        return UITableViewCellEditingStyleDelete;
    }else
    {
        return UITableViewCellEditingStyleInsert;
    }

}

// 삭제/추가작업 - 로그로 확인
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        // 데이터 삭제
        [data removeObjectAtIndex:indexPath.row];
        // 테이블셀 삭제
        NSArray *rowList = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:rowList withRowAnimation:UITableViewRowAnimationAutomatic];
        NSLog(@"%d번째 삭제", (int)indexPath.row);
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"추가" message:Nil delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        NSLog(@"%d번쨰 추가", (int)indexPath.row);
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CELL_ID forIndexPath:indexPath];
    cell.textLabel.text = data[indexPath.row];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    data = [[NSMutableArray alloc]initWithObjects:@"item0",@"item1",@"item2",@"item3",@"item4",@"item5",@"item6",@"item7", nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
