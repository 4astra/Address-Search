//
//  AddressBookViewController.m
//  Address Search
//
//  Created by Minh Dat Giap on 9/24/15.
//  Copyright © 2015 Hoat Ha Van. All rights reserved.
//

#import "AddressBookViewController.h"
#import "NSString+Utils.h"

static NSString *const cellIndentify = @"AddressBookCell";
//dict keys
static NSString *const kDictFirstName = @"FirstName";
static NSString *const kDictLastName = @"LastName";
static NSString *const kDictName = @"Name";
static NSString *const kDictPhone = @"LastName";
static NSString *const kDictEmail = @"LastName";

//NSMutableDictionary Extend
@implementation NSMutableDictionary (Your_Util)

+(id)dictWithFirstName:(NSString*)firstName lastName:(NSString*)lastName{
    return [NSMutableDictionary dictionaryWithObjects:@[firstName, lastName] forKeys:@[kDictFirstName, kDictLastName]];
}

+(id)dictWithName:(id)name phone:(id)phone email:(id)email{
    return [NSMutableDictionary dictionaryWithObjects:@[name, phone, email] forKeys:@[kDictName, kDictPhone, kDictEmail]];
}

-(id)getDictName{
    return [self valueForKey:kDictName];
}

-(id)getFirstName{
    return [self valueForKey:kDictFirstName];
}

-(id)getLastName{
    return [self valueForKey:kDictLastName];
}

@end

@interface AddressBookViewController ()<UIScrollViewDelegate>

@property (assign, nonatomic) BOOL isSearching;
@property (strong, nonatomic) NSArray *arrPeoples;

@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrAddressBookIndexTitle = @[@"#", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    
    self.dictABWithKey = [[NSMutableDictionary alloc] init];
    
    [self getAddressBookInformation];
    
    _isSearching = NO;
    
    self.dictSearchABWithKey = [[NSMutableDictionary alloc] init];
}


-(void)getAddressBookInformation
{
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    if (status == kABAuthorizationStatusDenied || status == kABAuthorizationStatusRestricted) {
        // grant access to contacts
        [[[UIAlertView alloc] initWithTitle:nil message:@"Cannot access this Addrress Book" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    if (!addressBook) {
        NSLog(@"ABAddressBookCreateWithOptions error: %@", CFBridgingRelease(error));
        return;
    }
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (error) {
            NSLog(@"ABAddressBookRequestAccessWithCompletion error: %@", CFBridgingRelease(error));
        }
        
        if (granted) {
            // if they gave you permission, then just carry on
            [self listPeopleInAddressBook:addressBook];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:nil message:@"Cannot access this Addrress Book" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            });
        }
        CFRelease(addressBook);
    });
}

- (void)listPeopleInAddressBook:(ABAddressBookRef)addressBook
{
    //Init
    AddressBookInfo *addressBookInfo = [[AddressBookInfo alloc] initAddressBook];
    
    NSArray *allPeople = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    
    _arrPeoples = [NSArray arrayWithArray:allPeople];
    
    NSInteger numberOfPeople = [allPeople count];
    
    for (NSInteger i = 0; i < numberOfPeople; i++) {
        
        ABRecordRef person = (__bridge ABRecordRef)allPeople[i];
        
        //Get Name Information
        NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName  = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
        
        if ([firstName length] == 0) {
            firstName = @"";
        }
        if ([lastName length] == 0) {
            lastName = @"";
        }
        
        NSMutableDictionary *dictName = [NSMutableDictionary dictWithFirstName:firstName lastName:lastName];
        //Get key character
        NSString *contactName = @"";
        NSString *nameKey = @"";
        if ([firstName length] == 0 && [lastName length] == 0) {
            dictName = [NSMutableDictionary dictWithFirstName:@"No Name" lastName:@""];
            nameKey = @"#";
        }
        else
        {
            contactName = [[NSString stringWithFormat:@"%@ %@", firstName, lastName] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            nameKey = [contactName substringWithRange:NSMakeRange(0, 1)];
        }
        
        //Get Phone information
        NSMutableArray *arrPhone = [[NSMutableArray alloc] init];
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFIndex numberOfPhoneNumbers = ABMultiValueGetCount(phoneNumbers);
        for (CFIndex i = 0; i < numberOfPhoneNumbers; i++) {
            NSString *phoneNumber = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneNumbers, i));
            [arrPhone addObject:phoneNumber];
            NSLog(@"  phone:%@", phoneNumber);
        }
        CFRelease(phoneNumbers);
        
        //Get Email Information
        NSMutableArray *arrEmail = [[NSMutableArray alloc] init];
        ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
        CFIndex numberOfEmails = ABMultiValueGetCount(emails);
        
        for (CFIndex i = 0; i < numberOfEmails; i++) {
            NSString *email = CFBridgingRelease(ABMultiValueCopyValueAtIndex(emails, i));
            [arrEmail addObject:email];
            NSLog(@"  email:%@", email);
        }
        CFRelease(emails);
        
        NSMutableDictionary *dictAddressBook = [NSMutableDictionary dictWithName:dictName phone:arrPhone email:arrEmail];
        //add to address book
        [addressBookInfo addAddressBookWithKey:nameKey addressBook:dictAddressBook];
    }
    
    NSMutableDictionary *tempDictAddressBookWithKey;
    tempDictAddressBookWithKey = [[NSMutableDictionary alloc] initWithObjects:@[addressBookInfo.keyOther, addressBookInfo.keyA, addressBookInfo.keyB, addressBookInfo.keyC, addressBookInfo.keyD, addressBookInfo.keyE, addressBookInfo.keyF, addressBookInfo.keyG, addressBookInfo.keyH, addressBookInfo.keyI, addressBookInfo.keyJ, addressBookInfo.keyK, addressBookInfo.keyL, addressBookInfo.keyM, addressBookInfo.keyN, addressBookInfo.keyO, addressBookInfo.keyP, addressBookInfo.keyQ, addressBookInfo.keyR, addressBookInfo.keyS, addressBookInfo.keyT, addressBookInfo.keyU, addressBookInfo.keyV, addressBookInfo.keyW, addressBookInfo.keyX, addressBookInfo.keyY, addressBookInfo.keyZ] forKeys:arrAddressBookIndexTitle];
    
    //Delete Null key in array
    for (int i = 0; i <= [arrAddressBookIndexTitle count] - 1; i++) {
        NSString *key = [arrAddressBookIndexTitle objectAtIndex:i];
        NSMutableArray *value = [tempDictAddressBookWithKey objectForKey:key];
        if ([value count] == 0) {
            [tempDictAddressBookWithKey removeObjectForKey:key];
        }
    }
    
    //sort
    self.dictABWithKey = tempDictAddressBookWithKey;
    self.arrABWithKeyIndexTitle = [[self.dictABWithKey allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    //reload table
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.ibTableView reloadData];
    });
    
}

#pragma mark - TableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isSearching) {
        return [self.arrSearchABWithKeyIndexTitle count];
    }
    return [self.arrABWithKeyIndexTitle count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearching) {
        NSString *nameKey = [[self.arrSearchABWithKeyIndexTitle objectAtIndex:section] uppercaseString];
        NSArray *arrCurrentAddressBook = [NSArray arrayWithArray:[self.dictSearchABWithKey objectForKey:nameKey]];
        return [arrCurrentAddressBook count];
    }
    NSString *nameKey = [[self.arrABWithKeyIndexTitle objectAtIndex:section] uppercaseString];
    NSArray *arrCurrentAddressBook = [NSArray arrayWithArray:[self.dictABWithKey objectForKey:nameKey]];
    return [arrCurrentAddressBook count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentify];

    NSString *nameKey = _isSearching? [self.arrSearchABWithKeyIndexTitle objectAtIndex:indexPath.section]: [self.arrABWithKeyIndexTitle objectAtIndex:indexPath.section];
    nameKey = [nameKey uppercaseString];
    
    NSMutableArray *arrCurrentAddressBook = _isSearching?[self.dictSearchABWithKey objectForKey:nameKey]:[self.dictABWithKey objectForKey:nameKey];
    
    NSMutableDictionary *dictName = [[arrCurrentAddressBook objectAtIndex:indexPath.row] getDictName];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [dictName getFirstName], [dictName getLastName]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NSString *nameKey = _isSearching? [self.arrSearchABWithKeyIndexTitle objectAtIndex:indexPath.section]: [self.arrABWithKeyIndexTitle objectAtIndex:indexPath.section];
    nameKey = [nameKey uppercaseString];
    
    NSMutableArray *arrCurrentAddressBook = _isSearching?[self.dictSearchABWithKey objectForKey:nameKey]:[self.dictABWithKey objectForKey:nameKey];

    NSMutableDictionary *dictName = [[arrCurrentAddressBook objectAtIndex:indexPath.row] getDictName];
    
    NSLog(@"Full Name: %@ %@", [dictName getFirstName], [dictName getLastName]);
    
    //To do transit to new View Controller
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *ibHeader = [[UIView alloc] initWithFrame:
                          CGRectMake(0, 0, tableView.frame.size.width, 20)];
    HeaderView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(18, 0, HeaderView.frame.size.width, 20)];
    
    [headerLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [ibHeader addSubview:headerLabel];
    headerLabel.text = _isSearching?[self.arrSearchABWithKeyIndexTitle objectAtIndex:section]:[self.arrABWithKeyIndexTitle objectAtIndex:section];
    
    return ibHeader;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return arrAddressBookIndexTitle;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return _isSearching ?[self.arrSearchABWithKeyIndexTitle indexOfObject:title]: [self.arrABWithKeyIndexTitle indexOfObject:title];
}


#pragma mark - UISearchBar's Delegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ([NSString isEmptyString:searchText]) {
        _isSearching = NO;
        [_ibTableView reloadData];
        
    }else{
        
        _isSearching = YES;
        [self searchContactWithKey:searchText];
    }
}

-(void)searchContactWithKey:(NSString*)searchText{
    
    AddressBookInfo *addressBookInfo = [[AddressBookInfo alloc] initAddressBook];
    
    NSInteger numberOfPeople = [_arrPeoples count];
    
    for (NSInteger i = 0; i < numberOfPeople; i++) {
        
        ABRecordRef person = (__bridge ABRecordRef)_arrPeoples[i];
        
        //Get Name Information
        NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName  = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
        
        if ([NSString isEmptyString:firstName]) {
            firstName = @"";
        }
        if ([NSString isEmptyString:lastName]) {
            lastName = @"";
        }
        
        firstName = [firstName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        lastName = [lastName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        NSString *fullName =  [NSString stringWithFormat:@"%@ %@", firstName, lastName];
        if ([NSString isEmptyString:firstName] && [NSString isEmptyString:lastName]) {
            fullName = @"no name";
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF contains[cd] %@)", searchText];
        
        if ([predicate evaluateWithObject:fullName]) {
            
            NSMutableDictionary *dictName;
            
            //Get key character
            
            NSString *nameKey = @"";
            
            if ([firstName length] == 0 && [lastName length] == 0) {
                
                dictName = [NSMutableDictionary dictWithFirstName:@"No Name" lastName:@""];
                nameKey = @"#";
            }
            else
            {
                dictName = [NSMutableDictionary dictWithFirstName:firstName lastName:lastName];
                nameKey = [[NSString stringWithFormat:@"%@ %@", firstName, lastName] substringWithRange:NSMakeRange(0, 1)];
            }
            
            //Get Phone information
            NSMutableArray *arrPhone = [[NSMutableArray alloc] init];
            ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
            CFIndex numberOfPhoneNumbers = ABMultiValueGetCount(phoneNumbers);
            
            for (CFIndex i = 0; i < numberOfPhoneNumbers; i++) {
                NSString *phoneNumber = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneNumbers, i));
                [arrPhone addObject:phoneNumber];
                
            }
            CFRelease(phoneNumbers);
            
            //Get Email Information
            NSMutableArray *arrEmail = [[NSMutableArray alloc] init];
            ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
            CFIndex numberOfEmails = ABMultiValueGetCount(emails);
            
            for (CFIndex i = 0; i < numberOfEmails; i++) {
                NSString *email = CFBridgingRelease(ABMultiValueCopyValueAtIndex(emails, i));
                [arrEmail addObject:email];
                
            }
            CFRelease(emails);
            
            NSMutableDictionary *dictAddressBook = [NSMutableDictionary dictWithName:dictName phone:arrPhone email:arrEmail];
            [addressBookInfo addAddressBookWithKey:nameKey addressBook:dictAddressBook];
            
        }
    }
    
    NSMutableDictionary *tempDictAddressBookWithKey;
    tempDictAddressBookWithKey = [[NSMutableDictionary alloc] initWithObjects:@[addressBookInfo.keyOther, addressBookInfo.keyA, addressBookInfo.keyB, addressBookInfo.keyC, addressBookInfo.keyD, addressBookInfo.keyE, addressBookInfo.keyF, addressBookInfo.keyG, addressBookInfo.keyH, addressBookInfo.keyI, addressBookInfo.keyJ, addressBookInfo.keyK, addressBookInfo.keyL, addressBookInfo.keyM, addressBookInfo.keyN, addressBookInfo.keyO, addressBookInfo.keyP, addressBookInfo.keyQ, addressBookInfo.keyR, addressBookInfo.keyS, addressBookInfo.keyT, addressBookInfo.keyU, addressBookInfo.keyV, addressBookInfo.keyW, addressBookInfo.keyX, addressBookInfo.keyY, addressBookInfo.keyZ] forKeys:arrAddressBookIndexTitle];
    
    //*** Delete Null Key ***
    for (int i = 0; i <= [arrAddressBookIndexTitle count] - 1; i++) {
        NSString *key = [arrAddressBookIndexTitle objectAtIndex:i];
        NSArray *value = [tempDictAddressBookWithKey objectForKey:key];
        if ([value count] == 0) {
            [tempDictAddressBookWithKey removeObjectForKey:key];
        }
    }
    
    self.dictSearchABWithKey = tempDictAddressBookWithKey;
    self.arrSearchABWithKeyIndexTitle = [[self.dictSearchABWithKey allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.ibTableView reloadData];
    });
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.view endEditing:YES];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
