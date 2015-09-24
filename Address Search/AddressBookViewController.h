//
//  AddressBookViewController.h
//  Address Search
//
//  Created by Minh Dat Giap on 9/24/15.
//  Copyright © 2015 Hoat Ha Van. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "AddressBookInfo.h"


@interface AddressBookViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSArray *arrAddressBookIndexTitle;
}

@property (strong, nonatomic) NSArray *arrABWithKeyIndexTitle;
@property (strong, nonatomic) NSMutableDictionary *dictABWithKey;
@property (weak, nonatomic) IBOutlet UITableView *ibTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *ibSearchBar;
@property (strong, nonatomic) NSArray *arrSearchABWithKeyIndexTitle;
@property (strong, nonatomic) NSMutableDictionary *dictSearchABWithKey;
@end
