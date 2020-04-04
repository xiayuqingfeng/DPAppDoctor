//
//  CheckNetWorkBytes.m
//  DPAppDoctor
//
//  Created by xiayupeng on 2020/4/4.
//  Copyright © 2020 yupeng xia. All rights reserved.
//

#import "CheckNetWorkBytes.h"
#ifdef DPAppDoctorDebug

#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>

uint64_t _lastBytes_CheckNetWorkBytes;
@implementation CheckNetWorkBytes
///获取当前网络流量 kb
+ (NSString *)getNetWorkBytesPerSecond {
    long newBytes = [CheckNetWorkBytes getGprsWifiFlowIOBytes];
    long currentBytes = 0;
    if ( _lastBytes_CheckNetWorkBytes > 0) {
        currentBytes = newBytes - _lastBytes_CheckNetWorkBytes;
    }
    _lastBytes_CheckNetWorkBytes = newBytes;
    return [NSString stringWithFormat:@"%.0f",currentBytes/1024.0];
}

+ (long long )getGprsWifiFlowIOBytes{
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1) {
        return 0;
    }
    uint64_t iBytes = 0;
    uint64_t oBytes = 0;
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        if (ifa->ifa_data == 0)
            continue;
        //Wifi
        if (strncmp(ifa->ifa_name, "lo", 2)) {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
        }
        //3G或者GPRS
        if (!strcmp(ifa->ifa_name, "pdp_ip0")){
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
        }
    }
    freeifaddrs(ifa_list);
    uint64_t bytes = 0;
    bytes = iBytes + oBytes;
    return bytes;
}
@end

#endif
