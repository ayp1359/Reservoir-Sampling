#import <Foundation/Foundation.h>

int main(int argc, const char *argv[]){
  
  @autoreleasepool {
    
    int numOfSamples = 1000;
    int lengthOfReservoir = 2;
    NSUInteger lenthOfArray = 10;
    
    NSMutableArray *stream = [[NSMutableArray alloc] initWithCapacity:lenthOfArray];
    for (int i=0; i<lenthOfArray; i++) {
      [stream addObject:[NSNumber numberWithInt:i]];
    }
    
    NSMutableArray *reservoirSamplesArray = [[NSMutableArray alloc] init];
    
    for(int s=1;s<=numOfSamples;s++){
      
      NSMutableArray *reservoir = [[NSMutableArray alloc] init];
      for (int i=0;i<lengthOfReservoir;i++){
        [reservoir addObject:[stream objectAtIndex:i]];
      }
      
      for(int i=lengthOfReservoir;i<lenthOfArray;i++){
        NSUInteger j = arc4random()%(i+1);
        if(j<lengthOfReservoir){
          [reservoir replaceObjectAtIndex:j withObject:[stream objectAtIndex:i]];
        }
      }
      
      [reservoirSamplesArray addObjectsFromArray:reservoir];
    }
    
    NSCountedSet *countedSet = [NSCountedSet setWithArray:reservoirSamplesArray];
    
    for (id item in countedSet){
      float percentProb = 100*[countedSet countForObject:item]/numOfSamples;
      NSLog(@"(sample:%@,prob:%%%2.1f)",item,percentProb);
    }
    
    NSLog(@"Sampling probablity should be close to: %%%2.1f for each sample",(float)100*lengthOfReservoir/lenthOfArray);
  }
  
  return 0;
}