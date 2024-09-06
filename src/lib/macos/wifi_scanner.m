#import <Foundation/Foundation.h>
#import <CoreWLAN/CoreWLAN.h>

NSString *jsonStringFromNetwork(CWNetwork *network) {
    NSMutableString *jsonString = [NSMutableString stringWithString:@"{"];
    
    // Ensure SSID comes first
    [jsonString appendFormat:@"\"SSID\": \"%@\", ", network.ssid ?: @"Unknown"];
    
    // List of properties to add in alphabetical order after SSID
    NSDictionary *properties = @{
        @"BSSID": network.bssid ?: @"Unknown",
        @"RSSI": @(network.rssiValue),
        @"Noise": @(network.noiseMeasurement),
        @"Channel": network.wlanChannel ? @(network.wlanChannel.channelNumber) : @"Unknown",
        @"BeaconInterval": @(network.beaconInterval),
        @"CountryCode": network.countryCode ?: @"Unknown",
        @"IBSS": @(network.ibss),
        @"SSIDData": network.ssidData ? [[NSString alloc] initWithData:network.ssidData encoding:NSUTF8StringEncoding] : @"Unknown",
        @"InformationElementData": network.informationElementData ? [network.informationElementData base64EncodedStringWithOptions:0] : @"None"
    };
    
    // Sort remaining keys alphabetically
    NSArray *sortedKeys = [[properties allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    // Add each property in alphabetical order
    for (NSString *key in sortedKeys) {
        [jsonString appendFormat:@"\"%@\": \"%@\", ", key, properties[key]];
    }
    
    // Remove trailing comma and space, close the JSON object
    if ([jsonString hasSuffix:@", "]) {
        [jsonString deleteCharactersInRange:NSMakeRange([jsonString length] - 2, 2)];
    }
    [jsonString appendString:@"}"];
    
    return jsonString;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CWInterface *wifiInterface = [CWWiFiClient sharedWiFiClient].interface;
        NSError *error = nil;
        
        // Scan for available networks
        NSSet *networks = [wifiInterface scanForNetworksWithSSID:nil error:&error];
        
        NSMutableString *jsonOutput = [NSMutableString stringWithString:@"{\"status\": \"success\", \"data\": ["];
        
        if (error) {
            // Output the error as a JSON string
            printf("{\"status\": \"failure\", \"message\": \"%s\"}\n", [[NSString stringWithFormat:@"Error scanning for networks: %@", error.localizedDescription] UTF8String]);
            return 1;
        } else {
            // Process each network and create a JSON string
            for (CWNetwork *network in networks) {
                [jsonOutput appendString:jsonStringFromNetwork(network)];
                [jsonOutput appendString:@", "];
            }
            
            // Remove trailing comma and space, close the JSON array
            if ([jsonOutput hasSuffix:@", "]) {
                [jsonOutput deleteCharactersInRange:NSMakeRange([jsonOutput length] - 2, 2)];
            }
            [jsonOutput appendString:@"]}"];
        }
        
        // Output the final JSON string using printf to avoid the timestamp
        printf("%s\n", [jsonOutput UTF8String]);
    }
    return 0;
}
