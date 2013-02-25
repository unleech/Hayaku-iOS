
#import "SaveFile.h"
#import "Constants.h"

@interface SaveFile (Private)

- (void)fillNewValues;

@end

@implementation SaveFile

static SaveFile* saveFile = nil;
@synthesize totalTimePlayed;
@synthesize totalCakes;
@synthesize totalCoins;
@synthesize remainingCakes;
@synthesize remainingCoins;
@synthesize spentCakes;
@synthesize spentCoins;
@synthesize listCostumes;
@synthesize listStages;
@synthesize listCharacters;

+(SaveFile*)sharedFile
{
	
	if (saveFile == nil)
		saveFile = [[[self class]alloc] init];
    
	return saveFile;
}

- (id) init
{
	
	self = [super init];
	if (self != nil)
	{
        
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentDirectory = [paths objectAtIndex:0];
		NSString *filePath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sav",RWappName]];
		if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            self.listStages = [[NSMutableDictionary alloc] init];
            self.listCostumes = [[NSMutableDictionary alloc] init];
		}		
	}
    
    [self fillNewValues];
    
	return self;
	
}

+(void) loadData
{
    @synchronized([SaveFile class]) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentDirectory = [paths objectAtIndex:0];
		NSString *filePath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sav",RWappName]];
        saveFile = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
		
    }
}

+(void) saveData
{
	[[NSUserDefaults standardUserDefaults] synchronize];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sav",RWappName]];
	[NSKeyedArchiver archiveRootObject:saveFile toFile:filePath];
}

-(void) encodeWithCoder:(NSCoder*)coder
{
	
}

-(id) initWithCoder:(NSCoder*)coder
{
	self = [super init];
	
    
    [self fillNewValues];
    
	return self;
	
}

- (void)fillNewValues
{
    if (self.listCostumes == nil)
        self.listCostumes = [[NSMutableDictionary alloc]init];
    if (self.listStages == nil)
        self.listStages = [[NSMutableDictionary alloc]init];
    if (self.listCharacters == nil)
        self.listCharacters = [[NSMutableDictionary alloc] init];

}

@end
